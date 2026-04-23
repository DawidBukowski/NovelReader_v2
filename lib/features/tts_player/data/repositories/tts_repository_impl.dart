// lib/features/tts_player/data/repositories/tts_repository_impl.dart
//
// Implements [TtsRepository]. This is the brain of the playback pipeline:
//   text → sentence segments → synthesis queue → gapless just_audio playback
//   → TtsPlayerState stream → UI + AudioServiceHandler
// =============================================================================

import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/player_state.dart';
import '../../domain/entities/sentence_segment.dart';
import '../../domain/entities/voice_model.dart';
import '../../domain/repositories/tts_repository.dart';
import '../audio/audio_service_handler.dart';
import '../datasources/sherpa_onnx_service.dart';
import 'package:audio_service/audio_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SENTENCE TOKENISER
// ─────────────────────────────────────────────────────────────────────────────

/// Splits raw article text into [SentenceSegment] list.
/// Simple but robust: splits on sentence-ending punctuation followed by
/// whitespace, then trims whitespace-only segments.
List<SentenceSegment> _tokenise(String text) {
  // Regex: split AFTER [.!?] that is followed by whitespace or end of string,
  // but not after common abbreviations (Mr. Mrs. Dr. etc).
  final pattern = RegExp('(?<=[.!?])\\s+(?=[A-Z\\u0410-\\u042F"\'\\u00AB\\u201E])|(?<=\\n)\\n+');
  final rawSentences = text.split(pattern);

  final segments = <SentenceSegment>[];
  int cursor = 0;

  for (int i = 0; i < rawSentences.length; i++) {
    final sentence = rawSentences[i].trim();
    if (sentence.isEmpty) {
      cursor += rawSentences[i].length + 1;
      continue;
    }

    final startOffset = text.indexOf(sentence, cursor);
    final endOffset = startOffset + sentence.length;

    segments.add(SentenceSegment(
      index: segments.length,
      text: sentence,
      startOffset: startOffset,
      endOffset: endOffset,
    ));

    cursor = endOffset;
  }

  return segments;
}

// ─────────────────────────────────────────────────────────────────────────────
// IMPL
// ─────────────────────────────────────────────────────────────────────────────

class TtsRepositoryImpl implements TtsRepository {
  TtsRepositoryImpl({
    required SherpaOnnxService synthesisService,
    required OpenReaderAudioHandler audioHandler,
  })  : _synth = synthesisService,
        _audioHandler = audioHandler{
    _audioHandler.onPlayCompleted = () => skipNext();
    _audioHandler.onSkipNext = () => skipNext();
    _audioHandler.onSkipPrevious = () => skipPrevious();
  }

  final SherpaOnnxService _synth;
  final OpenReaderAudioHandler _audioHandler;

  // ── State ──────────────────────────────────────────────────────────────────
  final BehaviorSubject<TtsPlayerState> _stateSubject =
  BehaviorSubject.seeded(const TtsPlayerState());

  @override
  Stream<TtsPlayerState> get playerStateStream => _stateSubject.stream;

  TtsPlayerState get _state => _stateSubject.value;

  // ── Synthesis subscriptions ────────────────────────────────────────────────
  StreamSubscription<SynthesisResult>? _readySub;
  StreamSubscription<SynthesisError>? _errorSub;

  // Tracks which segments have been submitted to the Isolate so we don't
  // double-submit when the lookahead refills.
  final Set<int> _submittedIndices = {};

  // ── Article lifecycle ──────────────────────────────────────────────────────

  @override
  Future<void> loadArticle({
    required String articleText,
    required String articleTitle,
    String articleSourceUrl = '',
    int? articleId,
  }) async {
    // Cancel any in-flight synthesis from the previous article.
    await _cancelSynthesisSubscriptions();
    _submittedIndices.clear();

    final segments = _tokenise(articleText);

    if (segments.isEmpty) {
      _emit(_state.copyWith(
        status: TtsPlaybackStatus.error,
        errorMessage: 'No speakable text found in article.',
      ));
      return;
    }

    _emit(_state.copyWith(
      status: TtsPlaybackStatus.loading,
      segments: segments,
      activeSegmentIndex: 0,
      synthesisedCount: 0,
      articleTitle: articleTitle,
      articleSourceUrl: articleSourceUrl,
      articleId: articleId,
      errorMessage: null,
    ));

    // Wire up synthesis result handlers.
    _readySub = _synth.onSegmentReady.listen(_onSegmentReady);
    _errorSub = _synth.onSegmentError.listen(_onSegmentError);

    // Update lock screen / notification metadata.
    _audioHandler.updateMediaItem(
      MediaItem(
        id: 'current_article', // unikalne ID
        title: articleTitle,
        artist: articleSourceUrl,
        album: 'OpenReader',
      ),
    );

    // Kick off lookahead synthesis for the first N segments.
    _fillSynthesisQueue(fromIndex: 0);
  }

  @override
  Future<void> unloadArticle() async {
    await _cancelSynthesisSubscriptions();
    await _synth.clearTempFiles();
    await _audioHandler.stop();
    _submittedIndices.clear();
    _emit(const TtsPlayerState());
  }

  // ── Playback controls ──────────────────────────────────────────────────────

  @override
  Future<void> play() async {
    if (_state.status == TtsPlaybackStatus.completed) return;

    final activeSegment = _state.activeSegment;
    if (activeSegment == null) return;

    if (activeSegment.synthesisState == SegmentSynthesisState.ready) {
      await _audioHandler.playFile(activeSegment.audioFilePath!);
      _emit(_state.copyWith(status: TtsPlaybackStatus.playing));
    } else {
      // Segment not yet ready — switch to loading and wait.
      _emit(_state.copyWith(status: TtsPlaybackStatus.loading));
    }
  }

  @override
  Future<void> pause() async {
    await _audioHandler.pause();
    _emit(_state.copyWith(status: TtsPlaybackStatus.paused));
  }

  @override
  Future<void> skipNext() async {
    if (!_state.canSkipNext) return;
    await _advanceToSegment(_state.activeSegmentIndex + 1);
  }

  @override
  Future<void> skipPrevious() async {
    final position = _audioHandler.currentPosition;
    if (position.inMilliseconds > kPrevSegmentThresholdMs ||
        !_state.canSkipPrev) {
      // Restart current segment.
      await _advanceToSegment(_state.activeSegmentIndex);
    } else {
      await _advanceToSegment(_state.activeSegmentIndex - 1);
    }
  }

  @override
  Future<void> seekToSegment(int segmentIndex) async {
    if (segmentIndex < 0 || segmentIndex >= _state.segments.length) {
      throw TtsFailure('Segment index $segmentIndex is out of range.');
    }
    await _advanceToSegment(segmentIndex);
  }

  @override
  Future<void> setSpeed(double speed) async {
    final clamped = speed.clamp(0.5, 3.0);
    _synth.updateSpeed(clamped);

    // Invalidate all already-synthesised segments ahead — they were generated
    // at the old speed and must be re-synthesised.
    final updatedSegments = _state.segments.map((seg) {
      if (seg.index > _state.activeSegmentIndex &&
          seg.synthesisState != SegmentSynthesisState.pending) {
        return seg.copyWith(
          synthesisState: SegmentSynthesisState.pending,
          audioFilePath: null,
          audioDuration: null,
        );
      }
      return seg;
    }).toList();

    _submittedIndices
        .removeWhere((i) => i > _state.activeSegmentIndex);

    _emit(_state.copyWith(
      speed: clamped,
      segments: updatedSegments,
      synthesisedCount: _state.activeSegmentIndex + 1,
    ));

    // Refill the queue at new speed.
    _fillSynthesisQueue(fromIndex: _state.activeSegmentIndex + 1);
  }

  // ── Internal helpers ───────────────────────────────────────────────────────

  /// Jump to [index], stop current audio, start new segment if ready.
  Future<void> _advanceToSegment(int index) async {
    await _audioHandler.stop();
    _emit(_state.copyWith(activeSegmentIndex: index));

    final segment = _state.segments[index];

    if (segment.synthesisState == SegmentSynthesisState.ready) {
      await _audioHandler.playFile(segment.audioFilePath!);
      _emit(_state.copyWith(status: TtsPlaybackStatus.playing));
    } else {
      _emit(_state.copyWith(status: TtsPlaybackStatus.loading));
    }

    _fillSynthesisQueue(fromIndex: index + 1);
  }

  /// Submit up to [kLookaheadSegments] pending segments to the Isolate.
  void _fillSynthesisQueue({required int fromIndex}) {
    int submitted = 0;
    for (int i = fromIndex;
    i < _state.segments.length && submitted < kLookaheadSegments;
    i++) {
      if (!_submittedIndices.contains(i) &&
          _state.segments[i].synthesisState == SegmentSynthesisState.pending) {
        _markSegmentState(i, SegmentSynthesisState.synthesising);
        _synth.synthesize(
          segmentIndex: i,
          text: _state.segments[i].text,
        );
        _submittedIndices.add(i);
        submitted++;
      }
    }
  }

  void _onSegmentReady(SynthesisResult result) {
    final segments = List<SentenceSegment>.from(_state.segments);
    segments[result.segmentIndex] = segments[result.segmentIndex].copyWith(
      synthesisState: SegmentSynthesisState.ready,
      audioFilePath: result.wavFilePath,
      audioDuration: Duration(milliseconds: result.durationMs),
    );

    _emit(_state.copyWith(
      segments: segments,
      synthesisedCount: _state.synthesisedCount + 1,
    ));

    // If the player was waiting for this segment, start playing now.
    if (_state.status == TtsPlaybackStatus.loading &&
        result.segmentIndex == _state.activeSegmentIndex) {
      _audioHandler.playFile(result.wavFilePath).then((_) {
        _emit(_state.copyWith(status: TtsPlaybackStatus.playing));
      });
    }

    // Keep lookahead full.
    _fillSynthesisQueue(fromIndex: _state.synthesisedCount);
  }

  void _onSegmentError(SynthesisError error) {
    if (error.segmentIndex == -1) {
      // Engine-level failure.
      _emit(_state.copyWith(
        status: TtsPlaybackStatus.error,
        errorMessage: error.message,
      ));
      return;
    }

    // Mark the segment as errored and skip it.
    _markSegmentState(error.segmentIndex, SegmentSynthesisState.error);

    if (_state.activeSegmentIndex == error.segmentIndex) {
      // Auto-skip to next segment on error.
      if (_state.canSkipNext) {
        skipNext();
      } else {
        _emit(_state.copyWith(status: TtsPlaybackStatus.completed));
      }
    }
  }

  void _markSegmentState(int index, SegmentSynthesisState newState) {
    final segments = List<SentenceSegment>.from(_state.segments);
    segments[index] =
        segments[index].copyWith(synthesisState: newState);
    _emit(_state.copyWith(segments: segments));
  }

  void _emit(TtsPlayerState newState) {
    _stateSubject.add(newState);
    // Keep lock-screen / notification in sync.
    _audioHandler.syncPlaybackState(newState);
  }

  Future<void> _cancelSynthesisSubscriptions() async {
    await _readySub?.cancel();
    await _errorSub?.cancel();
    _readySub = null;
    _errorSub = null;
  }

  Future<void> dispose() async {
    await _cancelSynthesisSubscriptions();
    await _stateSubject.close();
  }
}