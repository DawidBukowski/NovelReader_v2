// lib/main.dart
// =============================================================================

// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ runApp() fires immediately — Flutter draws its first frame.
  // AudioService initialises lazily inside audioHandlerProvider.
  runApp(const ProviderScope(child: OpenReaderApp()));
}

class OpenReaderApp extends ConsumerWidget {
  const OpenReaderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'OpenReader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B4CF5),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}