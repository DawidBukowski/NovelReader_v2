// lib/features/tts_player/data/datasources/sherpa_onnx_isolate.dart
//
// ⚠️  This file runs ENTIRELY inside a background Dart Isolate.
//     It must NOT import any Flutter widgets, Riverpod providers, or
//     anything that touches the UI thread.
//     All sherpa_onnx synthesis happens here.
// =============================================================================

import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa;

import 'isolate_messages.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ISOLATE ENTRY POINT
// Must be a top-level function (not a closure) for Isolate.spawn().
// ─────────────────────────────────────────────────────────────────────────────

/// Entry point for the synthesis Isolate.
/// [rootSendPort] is the [SendPort] of the main isolate — used to send
/// responses back.
void sherpaOnnxIsolateEntryPoint(SendPort rootSendPort) {
  final receivePort = ReceivePort();

  // ① Immediately hand our SendPort back so the main isolate can send requests.
  rootSendPort.send({
    IsolateMessage.kType: IsolateMessage.kReady,
    'sendPort': receivePort.sendPort,
  });

  sherpa.OfflineTts? tts;
  double currentSpeed = 1.0;

  receivePort.listen((dynamic rawMessage) async {
    if (rawMessage is! Map) return;
    final msg = rawMessage as Map<String, dynamic>;
    final type = msg[IsolateMessage.kType] as String;

    switch (type) {
    // ── Bootstrap ──────────────────────────────────────────────────────────
      case IsolateMessage.kBootstrap:
        try {
          currentSpeed = (msg['speed'] as num).toDouble();
          final architecture = msg['architecture'] as String;
          tts = _createTtsEngine(
            architecture: architecture,
            onnxModelPath: msg['onnxModelPath'] as String,
            configJsonPath: msg['configJsonPath'] as String,
            speakerId: msg['speakerId'] as int,
          );
        } catch (e) {
          // If the engine fails to initialise, all subsequent synthesis
          // requests will fail gracefully via the null-check below.
          rootSendPort.send({
            IsolateMessage.kType: IsolateMessage.kSegmentError,
            'segmentIndex': -1,
            'error': 'Engine init failed: $e',
          });
        }

    // ── Synthesise one segment ─────────────────────────────────────────────
      case IsolateMessage.kSynthesize:
        final segmentIndex = msg['segmentIndex'] as int;
        final text = msg['text'] as String;
        final outputWavPath = msg['outputWavPath'] as String;

        if (tts == null) {
          rootSendPort.send({
            IsolateMessage.kType: IsolateMessage.kSegmentError,
            'segmentIndex': segmentIndex,
            'error': 'TTS engine not initialised',
          });
          return;
        }

        try {
          final audio = tts!.generate(
            text: text,
            sid: 0, // speakerId already baked into engine config
            speed: currentSpeed,
          );

          // audio.samples is a Float32List of PCM at audio.sampleRate Hz.
          final durationMs =
          ((audio.samples.length / audio.sampleRate) * 1000).round();

          _writeWav(
            path: outputWavPath,
            samples: audio.samples,
            sampleRate: audio.sampleRate,
          );

          rootSendPort.send({
            IsolateMessage.kType: IsolateMessage.kSegmentReady,
            'segmentIndex': segmentIndex,
            'wavFilePath': outputWavPath,
            'durationMs': durationMs,
          });
        } catch (e) {
          rootSendPort.send({
            IsolateMessage.kType: IsolateMessage.kSegmentError,
            'segmentIndex': segmentIndex,
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
// ENGINE FACTORY — maps VoiceArchitecture string to sherpa_onnx config
// ─────────────────────────────────────────────────────────────────────────────

sherpa.OfflineTts _createTtsEngine({
  required String architecture,
  required String onnxModelPath,
  required String configJsonPath,
  required int speakerId,
}) {
  switch (architecture) {
    case 'vits':
      return sherpa.OfflineTts(
        sherpa.OfflineTtsConfig(
          model: sherpa.OfflineTtsModelConfig(
            vits: sherpa.OfflineTtsVitsModelConfig(
              model: onnxModelPath,
              lexicon: '',       // Piper models embed the lexicon in the .onnx
              tokens: configJsonPath,
              dataDir: '',
              noiseScale: 0.667,
              noiseScaleW: 0.8,
              lengthScale: 1.0,  // speed is applied at generate() time
            ),
            numThreads: 2,
            debug: false,
            provider: 'cpu',
          ),
          ruleFsts: '',
          maxNumSentences: 1,
        ),
      );

    case 'kokoro':
      return sherpa.OfflineTts(
        sherpa.OfflineTtsConfig(
          model: sherpa.OfflineTtsModelConfig(
            kokoro: sherpa.OfflineTtsKokoroModelConfig(
              model: onnxModelPath,
              voices: configJsonPath,
              tokens: '',        // Kokoro tokens are embedded in voices file
              dataDir: '',
              lengthScale: 1.0,
            ),
            numThreads: 2,
            debug: false,
            provider: 'cpu',
          ),
          ruleFsts: '',
          maxNumSentences: 1,
        ),
      );

    case 'matcha':
      return sherpa.OfflineTts(
        sherpa.OfflineTtsConfig(
          model: sherpa.OfflineTtsModelConfig(
            matcha: sherpa.OfflineTtsMatchaModelConfig(
              acousticModel: onnxModelPath,
              vocoder: '', // Matcha requires a separate vocoder — path injected via configJsonPath field
              lexicon: '',
              tokens: configJsonPath,
              dataDir: '',
              noiseScale: 0.667,
              lengthScale: 1.0,
            ),
            numThreads: 2,
            debug: false,
            provider: 'cpu',
          ),
          ruleFsts: '',
          maxNumSentences: 1,
        ),
      );

    default:
      throw UnsupportedError('Unknown TTS architecture: $architecture');
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WAV WRITER — converts Float32 PCM to a valid 16-bit PCM WAV file
// ─────────────────────────────────────────────────────────────────────────────

void _writeWav({
  required String path,
  required Float32List samples,
  required int sampleRate,
}) {
  // Convert Float32 [-1.0, 1.0] → Int16 [-32768, 32767]
  final pcm16 = Int16List(samples.length);
  for (int i = 0; i < samples.length; i++) {
    final clamped = samples[i].clamp(-1.0, 1.0);
    pcm16[i] = (clamped * 32767).round();
  }

  final pcmBytes = pcm16.buffer.asUint8List();
  final dataSize = pcmBytes.length;
  const numChannels = 1;
  const bitsPerSample = 16;
  const audioFormat = 1; // PCM

  final header = ByteData(44);
  // RIFF chunk
  header.setUint8(0, 0x52); // R
  header.setUint8(1, 0x49); // I
  header.setUint8(2, 0x46); // F
  header.setUint8(3, 0x46); // F
  header.setUint32(4, 36 + dataSize, Endian.little); // ChunkSize
  header.setUint8(8, 0x57);  // W
  header.setUint8(9, 0x41);  // A
  header.setUint8(10, 0x56); // V
  header.setUint8(11, 0x45); // E
  // fmt sub-chunk
  header.setUint8(12, 0x66); // f
  header.setUint8(13, 0x6D); // m
  header.setUint8(14, 0x74); // t
  header.setUint8(15, 0x20); // (space)
  header.setUint32(16, 16, Endian.little);            // Subchunk1Size
  header.setUint16(20, audioFormat, Endian.little);   // AudioFormat
  header.setUint16(22, numChannels, Endian.little);   // NumChannels
  header.setUint32(24, sampleRate, Endian.little);    // SampleRate
  header.setUint32(28,
      sampleRate * numChannels * bitsPerSample ~/ 8, Endian.little); // ByteRate
  header.setUint16(32,
      numChannels * bitsPerSample ~/ 8, Endian.little); // BlockAlign
  header.setUint16(34, bitsPerSample, Endian.little); // BitsPerSample
  // data sub-chunk
  header.setUint8(36, 0x64); // d
  header.setUint8(37, 0x61); // a
  header.setUint8(38, 0x74); // t
  header.setUint8(39, 0x61); // a
  header.setUint32(40, dataSize, Endian.little);      // Subchunk2Size

  final file = File(path);
  final sink = file.openSync(mode: FileMode.write);
  sink.writeFromSync(header.buffer.asUint8List());
  sink.writeFromSync(pcmBytes);
  sink.closeSync();
}