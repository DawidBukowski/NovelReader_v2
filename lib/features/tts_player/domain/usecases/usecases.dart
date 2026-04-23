// =============================================================================
// lib/features/tts_player/domain/usecases/
// =============================================================================
//
// Use cases are thin orchestrators. Each class does exactly ONE thing.
// They take repository interfaces as constructor arguments (injected by
// Riverpod providers in the presentation layer) — never concrete types.
//
// For simple read/pass-through operations we keep the call() operator
// pattern so they read like `ref.watch(loadArticleUseCaseProvider)(params)`.
// =============================================================================

import '../entities/player_state.dart';
import '../entities/voice_model.dart';
import '../repositories/tts_repository.dart';
import '../repositories/voice_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PLAYBACK USE CASES
// ─────────────────────────────────────────────────────────────────────────────

/// Load a plain-text article into the synthesis pipeline.
/// Called after a web scrape or when the user opens a saved article.
class LoadArticleUseCase {
  const LoadArticleUseCase(this._repository);
  final TtsRepository _repository;

  Future<void> call({
    required String text,
    required String title,
    String sourceUrl = '',
    int? articleId,
  }) =>
      _repository.loadArticle(
        articleText: text,
        articleTitle: title,
        articleSourceUrl: sourceUrl,
        articleId: articleId,
      );
}

/// Begin or resume audio playback.
class PlayUseCase {
  const PlayUseCase(this._repository);
  final TtsRepository _repository;

  Future<void> call() => _repository.play();
}

/// Pause audio playback (synthesis pipeline keeps running in background).
class PauseUseCase {
  const PauseUseCase(this._repository);
  final TtsRepository _repository;

  Future<void> call() => _repository.pause();
}

/// Advance to the next sentence segment.
class SkipNextUseCase {
  const SkipNextUseCase(this._repository);
  final TtsRepository _repository;

  Future<void> call() => _repository.skipNext();
}

/// Jump back to the previous sentence segment (or restart current).
class SkipPreviousUseCase {
  const SkipPreviousUseCase(this._repository);
  final TtsRepository _repository;

  Future<void> call() => _repository.skipPrevious();
}

/// Seek directly to a specific segment by index.
class SeekToSegmentUseCase {
  const SeekToSegmentUseCase(this._repository);
  final TtsRepository _repository;

  Future<void> call(int index) => _repository.seekToSegment(index);
}

/// Update synthesis + playback speed (0.5 – 3.0).
class SetSpeedUseCase {
  const SetSpeedUseCase(this._repository);
  final TtsRepository _repository;

  Future<void> call(double speed) => _repository.setSpeed(speed);
}

/// Watch the live player state — wired to a Riverpod StreamProvider.
class WatchPlayerStateUseCase {
  const WatchPlayerStateUseCase(this._repository);
  final TtsRepository _repository;

  Stream<TtsPlayerState> call() => _repository.playerStateStream;
}

// ─────────────────────────────────────────────────────────────────────────────
// VOICE MANAGEMENT USE CASES
// ─────────────────────────────────────────────────────────────────────────────

/// Fetch the merged remote+local voice catalogue.
class GetAvailableVoicesUseCase {
  const GetAvailableVoicesUseCase(this._repository);
  final VoiceRepository _repository;

  Future<List<VoiceModel>> call() => _repository.getAvailableVoices();
}

/// Watch the voice list for real-time download/status updates.
class WatchVoiceListUseCase {
  const WatchVoiceListUseCase(this._repository);
  final VoiceRepository _repository;

  Stream<List<VoiceModel>> call() => _repository.voiceListStream;
}

/// Start downloading a remote voice by ID.
class DownloadVoiceUseCase {
  const DownloadVoiceUseCase(this._repository);
  final VoiceRepository _repository;

  Future<void> call(String voiceId) => _repository.downloadVoice(voiceId);
}

/// Watch per-voice download progress (map of voiceId → 0.0–1.0).
class WatchDownloadProgressUseCase {
  const WatchDownloadProgressUseCase(this._repository);
  final VoiceRepository _repository;

  Stream<Map<String, double>> call() => _repository.downloadProgressStream;
}

/// Import a user-supplied zip file containing .onnx + .json model files.
class ImportVoiceFromZipUseCase {
  const ImportVoiceFromZipUseCase(this._repository);
  final VoiceRepository _repository;

  Future<VoiceModel> call(String zipFilePath) =>
      _repository.importVoiceFromZip(zipFilePath);
}

/// Set a downloaded voice as the active synthesis voice.
class SelectVoiceUseCase {
  const SelectVoiceUseCase(this._repository);
  final VoiceRepository _repository;

  Future<void> call(String voiceId) => _repository.selectVoice(voiceId);
}

/// Remove a downloaded voice from disk.
class DeleteVoiceUseCase {
  const DeleteVoiceUseCase(this._repository);
  final VoiceRepository _repository;

  Future<void> call(String voiceId) => _repository.deleteVoice(voiceId);
}