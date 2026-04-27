// lib/features/tts_player/data/datasources/sherpa_onnx_service.dart

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/voice_model.dart';
import 'isolate_messages.dart';
import 'sherpa_onnx_isolate.dart';

const int kLookaheadSegments = 3;

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

class SynthesisError {
  const SynthesisError({
    required this.segmentIndex,
    required this.message,
  });
  final int segmentIndex;
  final String message;
}

class SherpaOnnxService {
  SherpaOnnxService();

  Isolate? _isolate;
  SendPort? _isolateSendPort;
  ReceivePort? _receivePort;
  StreamSubscription<dynamic>? _receiveSubscription;

  final _resultController =
  StreamController<SynthesisResult>.broadcast();
  final _errorController =
  StreamController<SynthesisError>.broadcast();

  Stream<SynthesisResult> get onSegmentReady => _resultController.stream;
  Stream<SynthesisError> get onSegmentError => _errorController.stream;

  bool _isInitialised = false;
  String? _cachedTempDir;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  Future<void> initialise(VoiceModel voice) async {
    assert(voice.status == VoiceStatus.local);
    assert(voice.onnxModelPath != null && voice.configJsonPath != null);

    await dispose();

    _receivePort = ReceivePort();
    final completer = Completer<SendPort>();

    // Pre-compute tempDir before spawning so the Isolate gets it immediately.
    final tempDir = await _ensureTempDir();

    // The voiceDir is the parent folder of the .onnx file — some Piper
    // models need espeak-ng-data which lives beside the model files.
    final voiceDir = p.dirname(voice.onnxModelPath!);

    _receiveSubscription = _receivePort!.listen((dynamic raw) {
      if (raw is! Map) return;
      final msg = raw as Map<String, dynamic>;
      final type = msg[IsolateMessage.kType] as String;

      switch (type) {
        case IsolateMessage.kReady:
          final port = msg['sendPort'] as SendPort;
          completer.complete(port);
          // Bootstrap immediately with full config.
          port.send({
            IsolateMessage.kType: IsolateMessage.kBootstrap,
            'onnxModelPath': voice.onnxModelPath,
            'configJsonPath': voice.configJsonPath,
            'voiceDir': voiceDir,     // ← NEW: for espeak-ng-data lookup
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

  void updateSpeed(double speed) {
    if (!_isInitialised) return;
    _isolateSendPort!.send({
      IsolateMessage.kType: IsolateMessage.kUpdateSpeed,
      'speed': speed,
    });
  }

  // ── Cleanup ────────────────────────────────────────────────────────────────

  Future<void> deleteTempFile(String wavPath) async {
    try {
      final f = File(wavPath);
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  Future<void> clearTempFiles() async {
    try {
      final dir = Directory(await _ensureTempDir());
      await for (final e in dir.list()) {
        if (e is File && e.path.endsWith('.wav')) await e.delete();
      }
    } catch (_) {}
  }

  Future<void> dispose() async {
    if (_isolateSendPort != null) {
      _isolateSendPort!
          .send({IsolateMessage.kType: IsolateMessage.kDispose});
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
          'SherpaOnnxService not initialised. Call initialise(voice) first.');
    }
  }

  Future<String> _ensureTempDir() async {
    if (_cachedTempDir != null) return _cachedTempDir!;
    final base = await getTemporaryDirectory();
    final dir = Directory(p.join(base.path, 'open_reader_tts'));
    await dir.create(recursive: true);
    _cachedTempDir = dir.path;
    return _cachedTempDir!;
  }

  Future<String> _tempWavPath(int segmentIndex) async {
    final dir = await _ensureTempDir();
    final ts = DateTime.now().millisecondsSinceEpoch;
    return p.join(dir, 'seg_${segmentIndex}_$ts.wav');
  }
}