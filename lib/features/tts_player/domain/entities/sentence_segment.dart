import 'package:freezed_annotation/freezed_annotation.dart';

part 'sentence_segment.freezed.dart';

/// A single sentence (or natural speech chunk) extracted from the article text.
///
/// The text is split into segments BEFORE synthesis begins so the UI can
/// render the full article with karaoke highlighting from the start.
///
/// Synthesis happens sentence-by-sentence inside an Isolate:
///   Article text → [SentenceSegment] list → sherpa_onnx PCM → just_audio
@freezed
class SentenceSegment with _$SentenceSegment {
  const factory SentenceSegment({
    /// Zero-based index in the full segment list. Used as the cursor.
    required int index,

    /// The raw text of this sentence as it appears in the article.
    required String text,

    /// Character offset of the first character in the original full text.
    /// Enables precise caret positioning for scroll-to-active behaviour.
    required int startOffset,

    /// Character offset one past the last character (exclusive end).
    required int endOffset,

    /// Synthesis state for this individual segment.
    @Default(SegmentSynthesisState.pending)
    SegmentSynthesisState synthesisState,

    /// Path to the pre-synthesised WAV/PCM file for this segment.
    /// Non-null only when [synthesisState] is [SegmentSynthesisState.ready].
    /// Files are written to a temp directory and deleted after playback.
    String? audioFilePath,

    /// Duration of the synthesised audio. Available once synthesis completes.
    Duration? audioDuration,
  }) = _SentenceSegment;

// No fromJson — SentenceSegment is runtime-only, never persisted.
}

/// Synthesis lifecycle for a single [SentenceSegment].
enum SegmentSynthesisState {
  /// Not yet submitted to the synthesis Isolate.
  pending,

  /// Currently being synthesised in the background Isolate.
  synthesising,

  /// PCM audio is ready; [SentenceSegment.audioFilePath] is populated.
  ready,

  /// Synthesis failed for this segment (will be skipped or retried).
  error,
}