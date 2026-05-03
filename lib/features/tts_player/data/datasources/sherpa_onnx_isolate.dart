// lib/features/tts_player/data/datasources/sherpa_onnx_isolate.dart

import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa;

import 'isolate_messages.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY POINT
// ─────────────────────────────────────────────────────────────────────────────

void sherpaOnnxIsolateEntryPoint(SendPort rootSendPort) {
  final receivePort = ReceivePort();

  rootSendPort.send({
    IsolateMessage.kType: IsolateMessage.kReady,
    'sendPort': receivePort.sendPort,
  });

  sherpa.OfflineTts? tts;
  double currentSpeed = 1.0;

  receivePort.listen((dynamic raw) {
    if (raw is! Map) return;
    final msg = raw as Map<String, dynamic>;
    final type = msg[IsolateMessage.kType] as String;

    switch (type) {
    // ── Bootstrap ──────────────────────────────────────────────────────────
      case IsolateMessage.kBootstrap:
        try {
          sherpa.initBindings();
          currentSpeed = (msg['speed'] as num).toDouble();
          tts = _buildEngine(
            architecture: msg['architecture'] as String,
            onnxModelPath: msg['onnxModelPath'] as String,
            configJsonPath: msg['configJsonPath'] as String,
            voiceDir: msg['voiceDir'] as String,
            speakerId: msg['speakerId'] as int,
          );
        } catch (e, st) {
          rootSendPort.send({
            IsolateMessage.kType: IsolateMessage.kSegmentError,
            'segmentIndex': -1,
            'error': 'Engine init failed: $e\n$st',
          });
        }

    // ── Synthesise ─────────────────────────────────────────────────────────
      case IsolateMessage.kSynthesize:
        final idx = msg['segmentIndex'] as int;
        final text = msg['text'] as String;
        final outPath = msg['outputWavPath'] as String;

        if (tts == null) {
          rootSendPort.send({
            IsolateMessage.kType: IsolateMessage.kSegmentError,
            'segmentIndex': idx,
            'error': 'TTS engine not initialised',
          });
          return;
        }

        try {
          // lengthScale = 1/speed (lower = faster).
          final lengthScale =
          (1.0 / currentSpeed.clamp(0.5, 3.0));

          final audio = tts!.generate(
            text: text,
            sid: 0,
            speed: lengthScale,  // sherpa-onnx uses "speed" as lengthScale
          );

          final durationMs =
          ((audio.samples.length / audio.sampleRate) * 1000)
              .round();

          _writeWav(
            path: outPath,
            samples: audio.samples,
            sampleRate: audio.sampleRate,
          );

          rootSendPort.send({
            IsolateMessage.kType: IsolateMessage.kSegmentReady,
            'segmentIndex': idx,
            'wavFilePath': outPath,
            'durationMs': durationMs,
          });
        } catch (e) {
          rootSendPort.send({
            IsolateMessage.kType: IsolateMessage.kSegmentError,
            'segmentIndex': idx,
            'error': e.toString(),
          });
        }

    // ── Speed update ───────────────────────────────────────────────────────
      case IsolateMessage.kUpdateSpeed:
        currentSpeed = (msg['speed'] as num).toDouble();

    // ── Dispose ────────────────────────────────────────────────────────────
      case IsolateMessage.kDispose:
        tts?.free();
        tts = null;
        receivePort.close();
    }
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// ENGINE FACTORY
// ─────────────────────────────────────────────────────────────────────────────

sherpa.OfflineTts _buildEngine({
  required String architecture,
  required String onnxModelPath,
  required String configJsonPath,  // = .onnx.json (tokens file for Piper)
  required String voiceDir,
  required int speakerId,
}) {
  // espeak-ng-data is extracted alongside the model files.
  // It may or may not exist — Piper models that use phoneme IDs don't need it.
  final espeakDataDir = '${voiceDir}/espeak-ng-data';
  final hasEspeak = Directory(espeakDataDir).existsSync();

  switch (architecture) {
    case 'vits':
      return sherpa.OfflineTts(
        sherpa.OfflineTtsConfig(
          model: sherpa.OfflineTtsModelConfig(
            vits: sherpa.OfflineTtsVitsModelConfig(
              model: onnxModelPath,
              lexicon: '',              // Piper doesn't use a separate lexicon
              tokens: configJsonPath,   // .onnx.json is the tokens file
              dataDir: hasEspeak ? espeakDataDir : '',
              noiseScale: 0.667,
              noiseScaleW: 0.8,
              lengthScale: 1.0,        // overridden per-utterance in generate()
            ),
            numThreads: 2,
            debug: false,
            provider: 'cpu',
          ),
          ruleFsts: '',
        ),
      );

    case 'kokoro':
      return sherpa.OfflineTts(
        sherpa.OfflineTtsConfig(
          model: sherpa.OfflineTtsModelConfig(
            kokoro: sherpa.OfflineTtsKokoroModelConfig(
              model: onnxModelPath,
              voices: configJsonPath,
              tokens: '',
              dataDir: hasEspeak ? espeakDataDir : '',
              lengthScale: 1.0,
            ),
            numThreads: 2,
            debug: false,
            provider: 'cpu',
          ),
          ruleFsts: '',
        ),
      );

    case 'matcha':
      return sherpa.OfflineTts(
        sherpa.OfflineTtsConfig(
          model: sherpa.OfflineTtsModelConfig(
            matcha: sherpa.OfflineTtsMatchaModelConfig(
              acousticModel: onnxModelPath,
              vocoder: '',
              lexicon: '',
              tokens: configJsonPath,
              dataDir: hasEspeak ? espeakDataDir : '',
              noiseScale: 0.667,
              lengthScale: 1.0,
            ),
            numThreads: 2,
            debug: false,
            provider: 'cpu',
          ),
          ruleFsts: '',
        ),
      );

    default:
      throw UnsupportedError('Unknown architecture: $architecture');
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WAV WRITER
// ─────────────────────────────────────────────────────────────────────────────

void _writeWav({
  required String path,
  required Float32List samples,
  required int sampleRate,
}) {
  final pcm16 = Int16List(samples.length);
  for (int i = 0; i < samples.length; i++) {
    pcm16[i] = (samples[i].clamp(-1.0, 1.0) * 32767).round();
  }

  final pcmBytes = pcm16.buffer.asUint8List();
  final dataSize = pcmBytes.length;
  const numChannels = 1;
  const bitsPerSample = 16;

  final header = ByteData(44);
  void setStr(int offset, String s) {
    for (int i = 0; i < s.length; i++) {
      header.setUint8(offset + i, s.codeUnitAt(i));
    }
  }

  setStr(0, 'RIFF');
  header.setUint32(4, 36 + dataSize, Endian.little);
  setStr(8, 'WAVE');
  setStr(12, 'fmt ');
  header.setUint32(16, 16, Endian.little);
  header.setUint16(20, 1, Endian.little);               // PCM
  header.setUint16(22, numChannels, Endian.little);
  header.setUint32(24, sampleRate, Endian.little);
  header.setUint32(
      28, sampleRate * numChannels * bitsPerSample ~/ 8, Endian.little);
  header.setUint16(32, numChannels * bitsPerSample ~/ 8, Endian.little);
  header.setUint16(34, bitsPerSample, Endian.little);
  setStr(36, 'data');
  header.setUint32(40, dataSize, Endian.little);

  final sink = File(path).openSync(mode: FileMode.write);
  sink.writeFromSync(header.buffer.asUint8List());
  sink.writeFromSync(pcmBytes);
  sink.closeSync();
}