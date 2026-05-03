// lib/features/tts_player/presentation/providers/tts_providers.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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
// INFRASTRUCTURE
// ─────────────────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
SherpaOnnxService sherpaOnnxService(SherpaOnnxServiceRef ref) {
  final service = SherpaOnnxService();
  ref.onDispose(service.dispose);
  return service;
}

@Riverpod(keepAlive: true)
Future<VoiceRepository> voiceRepository(VoiceRepositoryRef ref) async {
  final isar = await ref.watch(isarProvider.future);
  return VoiceRepositoryImpl(isar: isar);
}

@Riverpod(keepAlive: true)
Future<TtsRepository> ttsRepository(TtsRepositoryRef ref) async {
  final synthService = ref.watch(sherpaOnnxServiceProvider);
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

  // ── Auto-init the Isolate with the currently selected voice ──────────────
  // This runs once on first build. When the user changes voice,
  // selectVoiceUseCase calls _reinitialiseEngine() directly (see below).
  final voice = await ref.read(selectedVoiceProvider.future);
  if (voice != null && voice.status == VoiceStatus.local) {
    await synthService.initialise(voice);
  }

  return impl;
}

// ─────────────────────────────────────────────────────────────────────────────
// STATE STREAMS
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
Stream<TtsPlayerState> playerState(PlayerStateRef ref) async* {
  final repo = await ref.watch(ttsRepositoryProvider.future);
  yield* repo.playerStateStream;
}

@riverpod
Future<VoiceModel?> selectedVoice(SelectedVoiceRef ref) async {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  return repo.getSelectedVoice();
}

@riverpod
Future<List<VoiceModel>> voiceList(VoiceListRef ref) async {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  return repo.getAvailableVoices();
}

@riverpod
Stream<Map<String, double>> downloadProgress(DownloadProgressRef ref) async* {
  final repo = await ref.watch(voiceRepositoryProvider.future);
  yield* repo.downloadProgressStream;
}

// ─────────────────────────────────────────────────────────────────────────────
// ENGINE REINIT — called by SelectVoiceUseCase after user picks a new voice
// ─────────────────────────────────────────────────────────────────────────────

/// Call this after selectVoice() so the Isolate loads the new model.
Future<void> reinitialiseEngine(WidgetRef ref) async {
  final voice = await ref.read(selectedVoiceProvider.future);
  if (voice == null || voice.status != VoiceStatus.local) return;
  final service = ref.read(sherpaOnnxServiceProvider);
  await service.initialise(voice);
}

// ─────────────────────────────────────────────────────────────────────────────
// USE-CASE PROVIDERS
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