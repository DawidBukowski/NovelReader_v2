// lib/core/router/app_router.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/library/presentation/screens/library_screen.dart';
import '../../features/tts_player/presentation/screens/player_screen.dart';
import '../../features/tts_player/presentation/screens/voice_manager_screen.dart';
import '../../features/web_scraper/presentation/screens/add_url_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';


part 'app_router.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ROUTE NAMES — single source of truth, used for push/pop calls
// ─────────────────────────────────────────────────────────────────────────────

abstract final class AppRoutes {
  static const library = '/library';
  static const player = '/player';
  static const voiceManager = '/voice-manager';
  static const addUrl = '/add-url';
  static const settings = '/settings';
}

// ─────────────────────────────────────────────────────────────────────────────
// ROUTER PROVIDER
// ─────────────────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.library,
    debugLogDiagnostics: false, // flip to true while debugging navigation
    routes: [
      // ── Library (home) ────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.library,
        name: 'library',
        builder: (context, state) => const LibraryScreen(),
      ),

      // ── Player ────────────────────────────────────────────────────────────
      // Receives an optional articleId query param when opening a saved article.
      // When opened from a fresh URL scrape, articleId is null.
      GoRoute(
        path: AppRoutes.player,
        name: 'player',
        builder: (context, state) {
          final articleId =
          int.tryParse(state.uri.queryParameters['articleId'] ?? '');
          return PlayerScreen(articleId: articleId);
        },
      ),

      // ── Voice Manager ─────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.voiceManager,
        name: 'voiceManager',
        builder: (context, state) => const VoiceManagerScreen(),
      ),

      // ── Add URL / Web Scraper ─────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.addUrl,
        name: 'addUrl',
        builder: (context, state) => const AddUrlScreen(),
      ),

      // ── Settings ──────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],

    // Global error page — shown for unknown routes or navigation errors.
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}