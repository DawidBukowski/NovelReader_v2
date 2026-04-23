// lib/features/tts_player/data/datasources/sherpa_onnx_service.dart
//
// Manages the lifecycle of the synthesis Isolate and exposes a clean
// async API to the rest of the data layer.
// The main thread never calls sherpa_onnx directly.
// =============================================================================

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/voice_model.dart';
import 'isolate_messages.dart';
import 'sherpa_onnx_isolate.dart';

/// How many segments to synthesise ahead of the currently playing one.
/// Keeps playback gapless without loading too many WAV files into memory.
const int kLookaheadSegments = 3;

/// Result emitted for each successfully synthesised segment.
class SynthesisResult {
  const SynthesisResult({
    required this.segmentIndex,
    required this.wavFilePath,
    required this.durationMs,
  });

  final int segmentIndex;
  final String wavFilePath;
  final int durationMs;
}

/// Failure emitted when a segment could not be synthesised.
class SynthesisError {
  const SynthesisError({
    required this.segmentIndex,
    required this.message,
  });

  final int segmentIndex;
  final String message;
}

// ─────────────────────────────────────────────────────────────────────────────
// SERVICE
// ─────────────────────────────────────────────────────────────────────────────

class SherpaOnnxService {
  SherpaOnnxService();

  // Internal isolate state
  Isolate? _isolate;
  SendPort? _isolateSendPort;
  ReceivePort? _receivePort;
  StreamSubscription<dynamic>? _receiveSubscription;

  // Output streams
  final _resultController =
  StreamController<SynthesisResult>.broadcast();
  final _errorController =
  StreamController<SynthesisError>.broadcast();

  Stream<SynthesisResult> get onSegmentReady => _resultController.stream;
  Stream<SynthesisError> get onSegmentError => _errorController.stream;

  bool _isInitialised = false;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  /// Spawn the synthesis Isolate and load the given [voice] model.
  /// Must be called before [synthesize]. Calling again replaces the engine.
  Future<void> initialise(VoiceModel voice) async {
    assert(
    voice.status == VoiceStatus.local,
    'Cannot initialise SherpaOnnxService with a voice that is not local.',
    );
    assert(
    voice.onnxModelPath != null && voice.configJsonPath != null,
    'Voice model paths must not be null for a local voice.',
    );

    // Tear down any existing isolate first.
    await dispose();

    _receivePort = ReceivePort();
    final completer = Completer<SendPort>();

    _receiveSubscription =
        _receivePort!.listen((dynamic rawMessage) {
          if (rawMessage is! Map) return;
          final msg = rawMessage as Map<String, dynamic>;
          final type = msg[IsolateMessage.kType] as String;

          switch (type) {
            case IsolateMessage.kReady:
            // The isolate sent back its SendPort — bootstrap it now.
              final isolateSendPort = msg['sendPort'] as SendPort;
              completer.complete(isolateSendPort);
              final tempDir = _tempDirPathSync();
              isolateSendPort.send({
                IsolateMessage.kType: IsolateMessage.kBootstrap,
                'onnxModelPath': voice.onnxModelPath,
                'configJsonPath': voice.configJsonPath,
                'speakerId': voice.speakerId,
                'speed': 1.0,
                'tempDirPath': tempDir,
                'architecture': voice.architecture.name,
              });

            case IsolateMessage.kSegmentReady:
              _resultController.add(SynthesisResult(
                segmentIndex: msg['segmentIndex'] as int,
                wavFilePath: msg['wavFilePath'] as String,
                durationMs: msg['durationMs'] as int,
              ));

            case IsolateMessage.kSegmentError:
              _errorController.add(SynthesisError(
                segmentIndex: msg['segmentIndex'] as int,
                message: msg['error'] as String,
              ));
          }
        });

    _isolate = await Isolate.spawn(
      sherpaOnnxIsolateEntryPoint,
      _receivePort!.sendPort,
      debugName: 'SherpaOnnxSynthesisIsolate',
    );

    _isolateSendPort = await completer.future;
    _isInitialised = true;
  }

  // ── Synthesis ──────────────────────────────────────────────────────────────

  /// Enqueue a segment for synthesis. The result arrives on [onSegmentReady].
  /// Throws [StateError] if the service has not been initialised.
  Future<void> synthesize({
    required int segmentIndex,
    required String text,
  }) async {
    _assertInitialised();
    final wavPath = await _tempWavPath(segmentIndex);
    _isolateSendPort!.send({
      IsolateMessage.kType: IsolateMessage.kSynthesize,
      'segmentIndex': segmentIndex,
      'text': text,
      'outputWavPath': wavPath,
    });
  }

  /// Notify the Isolate of a speed change.
  /// Already-queued segment files will be discarded by [TtsRepositoryImpl]
  /// and re-requested at the new speed.
  void updateSpeed(double speed) {
    if (!_isInitialised) return;
    _isolateSendPort!.send({
      IsolateMessage.kType: IsolateMessage.kUpdateSpeed,
      'speed': speed,
    });
  }

  // ── Cleanup ────────────────────────────────────────────────────────────────

  /// Delete a specific WAV temp file after it has been played.
  Future<void> deleteTempFile(String wavPath) async {
    try {
      final file = File(wavPath);
      if (await file.exists()) await file.delete();
    } catch (_) {
      // Non-fatal: temp files will be cleaned up on next app launch.
    }
  }

  /// Delete all temp WAV files (called on unload or voice change).
  Future<void> clearTempFiles() async {
    try {
      final dir = Directory(await _tempDirPath());
      if (await dir.exists()) {
        await for (final entity in dir.list()) {
          if (entity is File && entity.path.endsWith('.wav')) {
            await entity.delete();
          }
        }
      }
    } catch (_) {}
  }

  /// Gracefully shut down the Isolate and release all resources.
  Future<void> dispose() async {
    if (_isolateSendPort != null) {
      _isolateSendPort!.send({IsolateMessage.kType: IsolateMessage.kDispose});
    }
    await _receiveSubscription?.cancel();
    _receivePort?.close();
    _isolate?.kill(priority: Isolate.beforeNextEvent);
    _isolate = null;
    _isolateSendPort = null;
    _receivePort = null;
    _isInitialised = false;
    await clearTempFiles();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  void _assertInitialised() {
    if (!_isInitialised) {
      throw StateError(
        'SherpaOnnxService has not been initialised. '
            'Call initialise(voice) before synthesize().',
      );
    }
  }

  /// Temp directory path — synchronous version used during Isolate bootstrap
  /// where we can't await. The directory is guaranteed to exist by
  /// [_ensureTempDir] called during [initialise].
  String _tempDirPathSync() {
    // We cache this from the first async call during initialise().
    return _cachedTempDir ?? '/tmp/open_reader_tts';
  }

  String? _cachedTempDir;

  Future<String> _tempDirPath() async {
    if (_cachedTempDir != null) return _cachedTempDir!;
    final base = await getTemporaryDirectory();
    final dir = Directory(p.join(base.path, 'open_reader_tts'));
    await dir.create(recursive: true);
    _cachedTempDir = dir.path;
    return _cachedTempDir!;
  }

  Future<String> _tempWavPath(int segmentIndex) async {
    final dir = await _tempDirPath();
    // Timestamp prefix prevents stale file collisions across sessions.
    final ts = DateTime.now().millisecondsSinceEpoch;
    return p.join(dir, 'seg_${segmentIndex}_$ts.wav');
  }
}