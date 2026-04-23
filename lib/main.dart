import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(step-6): Initialize Isar & AudioService before runApp
  runApp(
    const ProviderScope(
      child: OpenReaderApp(),
    ),
  );
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
