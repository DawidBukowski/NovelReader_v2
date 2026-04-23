// lib/features/tts_player/data/datasources/isolate_messages.dart
//
// All messages that cross the Isolate boundary must be sendable via SendPort,
// which means: primitives, lists, maps, and SendPort itself only.
// No custom classes with methods — plain data containers only.
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// BOOTSTRAP — sent once when the Isolate is first spawned
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:isolate';

/// Bootstraps the sherpa_onnx engine inside the Isolate.
/// Sent as the very first message after the Isolate sends back its [SendPort].
class IsolateBootstrapMessage {
  const IsolateBootstrapMessage({
    required this.onnxModelPath,
    required this.configJsonPath,
    required this.speakerId,
    required this.speed,
    required this.tempDirPath,
    required this.architecture, // 'vits' | 'kokoro' | 'matcha'
  });

  final String onnxModelPath;
  final String configJsonPath;
  final int speakerId;
  final double speed;
  final String tempDirPath;
  final String architecture;
}

// ─────────────────────────────────────────────────────────────────────────────
// REQUESTS — main isolate → synthesis isolate
// ─────────────────────────────────────────────────────────────────────────────

/// Synthesise a single sentence segment and write to a WAV file.
class SynthesizeRequest {
  const SynthesizeRequest({
    required this.segmentIndex,
    required this.text,
    required this.outputWavPath, // pre-computed temp path, avoids path_provider in isolate
  });

  final int segmentIndex;
  final String text;
  final String outputWavPath;
}

/// Update the synthesis speed. Queued segments are re-synthesised on next run.
class UpdateSpeedRequest {
  const UpdateSpeedRequest(this.speed);
  final double speed;
}

/// Cancel all pending synthesis work and shut the isolate down cleanly.
class DisposeRequest {
  const DisposeRequest();
}

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSES — synthesis isolate → main isolate
// ─────────────────────────────────────────────────────────────────────────────

/// Sent once when the Isolate is ready to accept [SynthesizeRequest]s.
class IsolateReadyResponse {
  const IsolateReadyResponse(this.sendPort);
  final SendPort sendPort; // main thread uses this to send requests
}

/// Sent when a segment's WAV file has been written successfully.
class SegmentReadyResponse {
  const SegmentReadyResponse({
    required this.segmentIndex,
    required this.wavFilePath,
    required this.durationMs,
  });

  final int segmentIndex;
  final String wavFilePath;
  final int durationMs;
}

/// Sent when synthesis fails for a specific segment.
class SegmentErrorResponse {
  const SegmentErrorResponse({
    required this.segmentIndex,
    required this.error,
  });

  final int segmentIndex;
  final String error;
}

// Dart isolates can only send primitives + SendPort via SendPort.send().
// We use a convention: wrap every message in a Map<String, dynamic> with
// a 'type' discriminator. The helpers below handle the boxing/unboxing.

// ─────────────────────────────────────────────────────────────────────────────
// SENDPORT WRAPPER — keeps isolate.dart dependency-free from dart:isolate
// ─────────────────────────────────────────────────────────────────────────────

// ignore: avoid_classes_with_only_static_members
class IsolateMessage {
  static const String kType = 'type';

  // Request types
  static const String kBootstrap = 'bootstrap';
  static const String kSynthesize = 'synthesize';
  static const String kUpdateSpeed = 'update_speed';
  static const String kDispose = 'dispose';

  // Response types
  static const String kReady = 'ready';
  static const String kSegmentReady = 'segment_ready';
  static const String kSegmentError = 'segment_error';
}