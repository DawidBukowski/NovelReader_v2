// =============================================================================
// lib/features/tts_player/domain/repositories/tts_repository.dart
// =============================================================================
//
// Contract between the Domain layer and the Data layer for TTS synthesis.
// The presentation layer NEVER imports anything from data/.
// The data layer (SherpaOnnxService) implements this interface.
//
// Error handling convention:
//   All methods return [Either<Failure, T>] from the `fpdart` package
//   (add fpdart: ^1.1.0 to pubspec if not already present — it pairs
//    naturally with Clean Architecture and Riverpod).
//   Alternatively, use a Result<T> typedef until fpdart is added.
// =============================================================================

import '../entities/sentence_segment.dart';
import '../entities/player_state.dart';
import '../entities/voice_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// TTS REPOSITORY
// Owns: synthesis pipeline, playback control, speed, sentence segmentation.
// ─────────────────────────────────────────────────────────────────────────────

/// Interface for the core TTS synthesis and playback pipeline.
///
/// Implementations run sherpa_onnx inside a Dart [Isolate] so the UI thread
/// is never blocked during synthesis. Playback delegates to [just_audio]
/// via the [AudioServiceHandler] in [core/audio/].
abstract interface class TtsRepository {
  // ── Session lifecycle ──────────────────────────────────────────────────────

  /// Load [articleText] into the player:
  ///   1. Split text into [SentenceSegment] list (sentence tokeniser).
  ///   2. Emit an initial [TtsPlayerState] with status = loading.
  ///   3. Begin background synthesis pipeline (first N segments eagerly).
  ///
  /// [articleId] and [articleTitle] are metadata for lock-screen display.
  Future<void> loadArticle({
    required String articleText,
    required String articleTitle,
    String articleSourceUrl,
    int? articleId,
  });

  /// Immediately stop playback, cancel pending synthesis tasks, and reset
  /// state to [TtsPlaybackStatus.idle]. Temp audio files are deleted.
  Future<void> unloadArticle();

  // ── Playback controls ─────────────────────────────────────────────────────

  /// Start or resume playback from the [activeSegmentIndex].
  Future<void> play();

  /// Pause playback. Synthesis pipeline continues buffering in background.
  Future<void> pause();

  /// Jump to the next [SentenceSegment]. Pauses then resumes at n+1.
  Future<void> skipNext();

  /// Jump to the previous [SentenceSegment] or the beginning of the current
  /// one if more than [kPrevSegmentThresholdMs] milliseconds have played.
  Future<void> skipPrevious();

  /// Seek directly to [segmentIndex]. Bounds-checked; throws [TtsFailure]
  /// if index is out of range.
  Future<void> seekToSegment(int segmentIndex);

  // ── Speed ─────────────────────────────────────────────────────────────────

  /// Update synthesis speed. Clamped to [0.5, 3.0].
  /// Already-synthesised segments ahead in the queue are discarded and
  /// re-synthesised at the new speed to maintain consistency.
  Future<void> setSpeed(double speed);

  // ── State stream ──────────────────────────────────────────────────────────

  /// Continuous stream of [TtsPlayerState] updates.
  /// The Riverpod [StreamProvider] for the player screen listens to this.
  Stream<TtsPlayerState> get playerStateStream;
}

// Threshold: if the user hits "previous" after this many ms into a segment,
// we restart the current segment instead of jumping to the previous one.
const int kPrevSegmentThresholdMs = 2000;


