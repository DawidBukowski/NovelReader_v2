#!/usr/bin/env bash
# =============================================================================
# OpenReader — Folder Structure Scaffold Script
# Run from the Flutter project root: bash scaffold.sh
# =============================================================================
set -euo pipefail

echo "🏗️  Scaffolding OpenReader project structure..."

# ─────────────────────────────────────────────────────────────────────────────
# HELPER: create a directory + a .gitkeep so it's tracked by Git
# ─────────────────────────────────────────────────────────────────────────────
mkd() {
  mkdir -p "$1"
  touch "$1/.gitkeep"
}

# =============================================================================
# STATIC ASSETS
# =============================================================================
mkd assets/images
mkd assets/icons

# =============================================================================
# LIB ROOT
# =============================================================================

# ── main.dart ─────────────────────────────────────────────────────────────────
cat > lib/main.dart << 'DART'
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
DART

# =============================================================================
# CORE
# =============================================================================
# core/ holds cross-cutting concerns shared by all features.

mkd lib/core/router
mkd lib/core/error
mkd lib/core/utils
mkd lib/core/audio                 # AudioServiceHandler (background audio glue)
mkd lib/core/database              # Isar instance provider
mkd lib/core/theme
mkd lib/core/network               # Base HTTP client / interceptors

cat > lib/core/router/app_router.dart << 'DART'
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/library',
    routes: [
      // TODO(step-5): Add feature routes
    ],
  );
}
DART

cat > lib/core/error/failures.dart << 'DART'
/// Typed failure hierarchy — returned in Either<Failure, T> from repositories.
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class TtsFailure extends Failure {
  const TtsFailure(super.message);
}

class VoiceImportFailure extends Failure {
  const VoiceImportFailure(super.message);
}

class ScraperFailure extends Failure {
  const ScraperFailure(super.message);
}
DART

# =============================================================================
# FEATURE: LIBRARY
# =============================================================================

# data/
mkd lib/features/library/data/datasources
mkd lib/features/library/data/models
mkd lib/features/library/data/repositories

# domain/
mkd lib/features/library/domain/entities
mkd lib/features/library/domain/repositories
mkd lib/features/library/domain/usecases

# presentation/
mkd lib/features/library/presentation/screens
mkd lib/features/library/presentation/widgets
mkd lib/features/library/presentation/providers

# Placeholder files
touch lib/features/library/domain/entities/saved_article.dart
touch lib/features/library/domain/repositories/library_repository.dart
touch lib/features/library/presentation/screens/library_screen.dart

# =============================================================================
# FEATURE: TTS_PLAYER
# =============================================================================

# data/
mkd lib/features/tts_player/data/datasources   # SherpaOnnxService (Isolate)
mkd lib/features/tts_player/data/models        # VoiceModelDto, PlayerStateDto
mkd lib/features/tts_player/data/repositories  # TtsRepositoryImpl
mkd lib/features/tts_player/data/audio         # AudioServiceHandler impl

# domain/
mkd lib/features/tts_player/domain/entities    # VoiceModel, PlayerState, SentenceSegment
mkd lib/features/tts_player/domain/repositories
mkd lib/features/tts_player/domain/usecases

# presentation/
mkd lib/features/tts_player/presentation/screens  # PlayerScreen, VoiceManagerScreen
mkd lib/features/tts_player/presentation/widgets  # KaraokeView, SpeedSlider, Controls
mkd lib/features/tts_player/presentation/providers

# Placeholder files
touch lib/features/tts_player/domain/entities/voice_model.dart
touch lib/features/tts_player/domain/entities/player_state.dart
touch lib/features/tts_player/domain/entities/sentence_segment.dart
touch lib/features/tts_player/domain/repositories/tts_repository.dart
touch lib/features/tts_player/domain/repositories/voice_repository.dart
touch lib/features/tts_player/presentation/screens/player_screen.dart
touch lib/features/tts_player/presentation/screens/voice_manager_screen.dart

# =============================================================================
# FEATURE: WEB_SCRAPER
# =============================================================================

mkd lib/features/web_scraper/data/datasources   # HttpHtmlFetcher
mkd lib/features/web_scraper/data/models
mkd lib/features/web_scraper/data/repositories  # ScraperRepositoryImpl

mkd lib/features/web_scraper/domain/entities    # ScrapedArticle
mkd lib/features/web_scraper/domain/repositories
mkd lib/features/web_scraper/domain/usecases    # FetchAndParseArticleUseCase

mkd lib/features/web_scraper/presentation/screens
mkd lib/features/web_scraper/presentation/providers

touch lib/features/web_scraper/domain/entities/scraped_article.dart
touch lib/features/web_scraper/domain/repositories/scraper_repository.dart

# =============================================================================
# FEATURE: VOICE_MANAGER (sub-feature; lives inside tts_player)
# Kept inside tts_player to avoid circular deps with TTS domain entities.
# =============================================================================
mkd lib/features/tts_player/data/voice_manager   # DownloadService, ImportService

# =============================================================================
# FEATURE: SETTINGS
# =============================================================================

mkd lib/features/settings/data
mkd lib/features/settings/domain
mkd lib/features/settings/presentation/screens
mkd lib/features/settings/presentation/providers

touch lib/features/settings/presentation/screens/settings_screen.dart

# =============================================================================
# TEST MIRRORS
# =============================================================================
mkd test/features/library/domain
mkd test/features/library/data
mkd test/features/tts_player/domain
mkd test/features/tts_player/data
mkd test/features/web_scraper/domain
mkd test/core

# =============================================================================
# ANALYSIS OPTIONS (strict mode)
# =============================================================================
cat > analysis_options.yaml << 'YAML'
include: package:flutter_lints/flutter.yaml

analyzer:
  plugins:
    - custom_lint
  errors:
    invalid_annotation_target: ignore   # suppresses @riverpod on private ctors
  language:
    strict-casts: true
    strict-raw-types: true
    strict-inference: true

linter:
  rules:
    avoid_print: true
    prefer_const_constructors: true
    prefer_const_declarations: true
    prefer_final_locals: true
    use_super_parameters: true
    sort_pub_dependencies: false        # managed manually by layer
YAML

# =============================================================================
# DONE
# =============================================================================
echo ""
echo "✅  Folder structure created successfully!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  NEXT STEPS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  1. Install dependencies:"
echo "     flutter pub get"
echo ""
echo "  2. Run code generation (watch mode during development):"
echo "     dart run build_runner watch --delete-conflicting-outputs"
echo ""
echo "  3. One-shot generation (CI / before commit):"
echo "     dart run build_runner build --delete-conflicting-outputs"
echo ""
echo "  4. Add Android permissions to android/app/src/main/AndroidManifest.xml:"
echo "     <uses-permission android:name=\"android.permission.INTERNET\" />"
echo "     <uses-permission android:name=\"android.permission.FOREGROUND_SERVICE\" />"
echo "     <uses-permission android:name=\"android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK\" />"
echo "     <uses-permission android:name=\"android.permission.WAKE_LOCK\" />"
echo "     <uses-permission android:name=\"android.permission.RECEIVE_BOOT_COMPLETED\" />"
echo ""
echo "  5. Add iOS permissions to ios/Runner/Info.plist:"
echo "     UIBackgroundModes → audio"
echo ""
echo "  6. Confirm STEP 1 complete → proceed to STEP 2 (Domain Layer)."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"