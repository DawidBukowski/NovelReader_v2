// lib/core/audio/audio_handler_provider.dart

import 'package:audio_service/audio_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/tts_player/data/audio/audio_service_handler.dart';

part 'audio_handler_provider.g.dart';

@Riverpod(keepAlive: true)
Future<OpenReaderAudioHandler> audioHandler(AudioHandlerRef ref) async {
  // This runs after Flutter's first frame — no blocking main() anymore.
  return AudioService.init(
    builder: () => OpenReaderAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.yourorg.openreader.audio',
      androidNotificationChannelName: 'OpenReader',
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: false,
    ),
  );
}