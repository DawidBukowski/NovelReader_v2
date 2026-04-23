import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'package:audio_service/audio_service.dart';
//import 'core/audio/audio_handler_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final audioHandler = await AudioService.init(
    builder: () => OpenReaderAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.yourapp.openreader.audio',
      androidNotificationChannelName: 'OpenReader Playback',
      androidNotificationOngoing: true,
    ),
  );
  runApp(ProviderScope(
    overrides: [audioHandlerProvider.overrideWithValue(audioHandler)],
    child: const OpenReaderApp(),
  ));
}

class OpenReaderApp extends ConsumerWidget {
  const OpenReaderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'OpenReader',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
