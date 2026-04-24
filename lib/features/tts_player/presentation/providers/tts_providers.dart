// lib/features/tts_player/presentation/providers/tts_providers.dart
//
// Complete Riverpod provider graph for the tts_player feature.
//
// Dependency tree (top = most fundamental):
//
//   isarProvider  audioHandlerProvider
//        │               │
//        ▼               ▼
//  voiceRepositoryProvider   sherpaOnnxServiceProvider
//        │                           │
//        ▼                           ▼
//              ttsRepositoryProvider
//                       │
//           ┌───────────┼────────────┐
//           ▼           ▼            ▼
//  playerStateProvider  selectedVoiceProvider  ...useCaseProviders
//           │
//           ▼
//      PlayerScreen / VoiceManagerScreen
//
// =============================================================================

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/audio/audio_handler_provider.dart';
import '../../../../core/database/isar_provider.dart';
import '../../data/datasources/sherpa_onnx_service.dart';
import '../../data/repositories/tts_repository_impl.dart';
import '../../data/repositories/voice_repository_impl.dart';
import '../../domain/entities/player_state.dart';
import '../../domain/entities/voice_model.dart';
import '../../domain/repositories/tts_repository.dart';
import '../../domain/repositories/voice_repository.dart';
import '../../domain/usecases/usecases.dart';

part 'tts_providers.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// INFRASTRUCTURE PROVIDERS
// ─────────────────────────────────────────────────────────────────────────────

/// The sherpa_onnx synthesis service.
/// keepAlive: true — the Isolate must survive screen navigation.
@Riverpod(keepAlive: true)
SherpaOnnxService sherpaOnnxService(SherpaOnnxServiceRef ref) {
  final service = SherpaOnnxService();

  // Dispose the Isolate if somehow this provider is ever invalidated.
  ref.onDispose(service.dispose);

  return service;
}

/// Voice management repository (download, import, persist).
@Riverpod(keepAlive: true)
Future<VoiceRepository> voiceRepository(VoiceRepositoryRef ref) async {
  final isar = await ref.watch(isarProvider.future);
  return VoiceRepositoryImpl(isar: isar);
}

/// TTS playback repository — the synthesis + state pipeline.
/// keepAlive: true — must not reset mid-playback on navigation.
@Riverpod(keepAlive: true)
Future<TtsRepository> ttsRepository(TtsRepositoryRef ref) async {
  final synthService = ref.watch(sherpaOnnxServiceProvider);

  // ✅ await the future — AudioService may still be initialising
  final audioHandler = await ref.watch(audioHandlerProvider.future);

  audioHandler.setupListeners();

  final impl = TtsRepositoryImpl(
    synthesisService: synthService,
    audioHandler: audioHandler,
  );

  audioHandler.onPlayCompleted = () => impl.skipNext();
  audioHandler.onSkipNext = () => impl.skipNext();
  audioHandler.onSkipPrevious = () => impl.skipPrevious();

  ref.onDispose(impl.dispose);
  return impl;
}

// ─────────────────────────────────────────────────────────────────────────────
// STATE PROVIDERS  (what the UI directly watches)
// ─────────────────────────────────────────────────────────────────────────────

/// Live [TtsPlayerState] stream — the single source of truth for the player UI.
/// Rebuilds the player screen only when the state object itself changes
/// (Freezed equality prevents spurious rebuilds).
@riverpod
Stream<TtsPlayerState> playerState(PlayerStateRef ref) async* {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  yield* repo.playerStateStream;
}

/// The currently selected [VoiceModel], or null on first launch.
/// Watched by the player header and the voice picker button.
@riverpod
Future<VoiceModel?> selectedVoice(SelectedVoiceRef ref) async {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  return repo.getSelectedVoice();
}

/// Full voice list — merges remote catalogue with local models.
/// Refreshed by calling `ref.invalidate(voiceListProvider)` after
/// any download / import / delete action.
@riverpod
Future<List<VoiceModel>> voiceList(VoiceListRef ref) async {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  return repo.getAvailableVoices();
}

/// Live download progress map: voiceId → 0.0–1.0.
/// Only emits when a download is actually in progress.
@riverpod
Stream<Map<String, double>> downloadProgress(DownloadProgressRef ref) async* {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  yield* repo.downloadProgressStream;
}

// ─────────────────────────────────────────────────────────────────────────────
// USE-CASE PROVIDERS
// These are thin; they exist so the UI never imports repository concretions.
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
Future<LoadArticleUseCase> loadArticleUseCase(LoadArticleUseCaseRef ref) async {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  return LoadArticleUseCase(repo);
}

@riverpod
Future<PlayUseCase> playUseCase(PlayUseCaseRef ref) async {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  return PlayUseCase(repo);
}

@riverpod
Future<PauseUseCase> pauseUseCase(PauseUseCaseRef ref) async {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  return PauseUseCase(repo);
}

@riverpod
Future<SkipNextUseCase> skipNextUseCase(SkipNextUseCaseRef ref) async {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  return SkipNextUseCase(repo);
}

@riverpod
Future<SkipPreviousUseCase> skipPreviousUseCase(
    SkipPreviousUseCaseRef ref) async {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  return SkipPreviousUseCase(repo);
}

@riverpod
Future<SeekToSegmentUseCase> seekToSegmentUseCase(
    SeekToSegmentUseCaseRef ref) async {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  return SeekToSegmentUseCase(repo);
}

@riverpod
Future<SetSpeedUseCase> setSpeedUseCase(SetSpeedUseCaseRef ref) async {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  return SetSpeedUseCase(repo);
}

@riverpod
Future<DownloadVoiceUseCase> downloadVoiceUseCase(
    DownloadVoiceUseCaseRef ref) async {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  return DownloadVoiceUseCase(repo);
}

@riverpod
Future<ImportVoiceFromZipUseCase> importVoiceFromZipUseCase(
    ImportVoiceFromZipUseCaseRef ref) async {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  return ImportVoiceFromZipUseCase(repo);
}

@riverpod
Future<SelectVoiceUseCase> selectVoiceUseCase(
    SelectVoiceUseCaseRef ref) async {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  return SelectVoiceUseCase(repo);
}

@riverpod
Future<DeleteVoiceUseCase> deleteVoiceUseCase(
    DeleteVoiceUseCaseRef ref) async {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  return DeleteVoiceUseCase(repo);
}