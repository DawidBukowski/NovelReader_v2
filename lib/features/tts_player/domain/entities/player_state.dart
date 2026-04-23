import 'package:freezed_annotation/freezed_annotation.dart';
import 'sentence_segment.dart';
import 'voice_model.dart';

part 'player_state.freezed.dart';

/// Top-level playback status of the TTS player.
enum TtsPlaybackStatus {
  /// No article loaded. Initial / reset state.
  idle,

  /// Segments have been parsed; synthesis pipeline is warming up.
  loading,

  /// Audio is actively playing.
  playing,

  /// User paused playback. Synthesis pipeline may still be running ahead.
  paused,

  /// Reached the last segment. Player is stopped but article is still loaded.
  completed,

  /// An unrecoverable error occurred (shown in UI with error message).
  error,
}

/// The single source of truth for everything the Player UI needs to render.
///
/// Exposed as a [StateNotifier] / [Notifier] state via Riverpod.
/// The [AudioServiceHandler] mirrors a subset of this into [PlaybackState]
/// for the lock-screen / notification controls.
@freezed
class TtsPlayerState with _$TtsPlayerState {
  const factory TtsPlayerState({
    // ── Playback ───────────────────────────────────────────────────────────

    @Default(TtsPlaybackStatus.idle) TtsPlaybackStatus status,

    /// Index into [segments] for the sentence currently playing.
    /// -1 when no sentence is active (idle / completed).
    @Default(-1) int activeSegmentIndex,

    /// The full ordered list of sentence segments for the loaded article.
    @Default([]) List<SentenceSegment> segments,

    // ── Voice & Speed ─────────────────────────────────────────────────────

    /// Currently selected TTS voice. Null until user picks one.
    VoiceModel? activeVoice,

    /// Synthesis + playback speed multiplier. Clamped to 0.5 – 3.0.
    @Default(1.0) double speed,

    // ── Article Metadata ──────────────────────────────────────────────────

    /// Isar ID of the article being read. Null for transient / unsaved reads.
    int? articleId,

    /// Article title — shown in the player header and lock-screen.
    @Default('') String articleTitle,

    /// Source URL — shown beneath the title.
    @Default('') String articleSourceUrl,

    // ── Progress (derived, but stored to avoid re-computation on every tick) ─

    /// Number of segments fully synthesised and ready.
    @Default(0) int synthesisedCount,

    // ── Error ─────────────────────────────────────────────────────────────

    /// Human-readable error message when [status] == [TtsPlaybackStatus.error].
    String? errorMessage,
  }) = _TtsPlayerState;

  // Private constructor required by freezed for custom getters.
  const TtsPlayerState._();

  // ── Computed helpers ────────────────────────────────────────────────────

  /// True when there is a next sentence to skip to.
  bool get canSkipNext =>
      segments.isNotEmpty && activeSegmentIndex < segments.length - 1;

  /// True when there is a previous sentence to jump back to.
  bool get canSkipPrev => activeSegmentIndex > 0;

  /// Fractional read progress 0.0 – 1.0 based on active segment position.
  double get readProgress => segments.isEmpty
      ? 0.0
      : (activeSegmentIndex + 1) / segments.length;

  /// The segment currently being spoken. Null when idle.
  SentenceSegment? get activeSegment =>
      activeSegmentIndex >= 0 && activeSegmentIndex < segments.length
          ? segments[activeSegmentIndex]
          : null;

  /// Synthesis pipeline fill: how many segments are buffered ahead.
  int get bufferAhead => synthesisedCount - (activeSegmentIndex + 1);
}