# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run the app (debug)
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Analyze code (lint)
flutter analyze

# Regenerate code (Riverpod providers, Isar schemas, Freezed models, JSON)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation
dart run build_runner watch --delete-conflicting-outputs
```

## Architecture

Flutter app using **Clean Architecture** with feature modules under `lib/features/`. State is managed globally via **Riverpod**; navigation via **GoRouter** (`lib/core/router/`).

### Feature modules (`lib/features/`)

- **library** — saved articles list; persists to Isar via `SavedArticleDto`
- **tts_player** — core feature; TTS synthesis + audio playback
- **web_scraper** — fetches and parses a URL into plain text (Readability-style)
- **settings** — app settings screen

### TTS pipeline (tts_player)

1. `TtsRepositoryImpl` receives text and selected `VoiceModel`
2. `SherpaOnnxService` runs Sherpa-ONNX synthesis in a background **Dart Isolate** (prevents UI jank)
3. PCM audio segments are queued to `AudioServiceHandler` (extends `BaseAudioHandler`)
4. `audio_service` exposes a MediaSession for lock-screen / notification controls

### Code generation

Several files are **generated** and must not be edited by hand:
- `*.g.dart` — Isar schema + Riverpod providers + JSON serialization
- `*.freezed.dart` — Freezed immutable models

Run `build_runner` after changing any annotated class (`@riverpod`, `@collection`, `@freezed`, `@JsonSerializable`).

### Key providers (keepAlive)

- `isarProvider` — singleton Isar instance (`lib/core/database/`)
- `audioHandlerProvider` — singleton `AudioServiceHandler` (`lib/core/audio/`)
- `routerProvider` — GoRouter instance (`lib/core/router/`)

### Linting

`analysis_options.yaml` enables strict mode (`strict-casts`, `strict-raw-types`, `strict-inference`). `avoid_print`, `prefer_const_constructors`, `prefer_final_locals` are enforced — use `debugPrint` instead of `print`.

## Skills

Use `/flutter` for code generation, error diagnosis, and clean rebuild workflows.
Use `/git` for commits, branches, and PRs.
Use `/debugging` for systematic root cause analysis.
