// =============================================================================
// lib/features/tts_player/domain/repositories/voice_repository.dart
// =============================================================================
//
// Contract for everything related to voice model management:
//   - Listing available voices (remote catalogue + local)
//   - Downloading from remote
//   - Importing user-supplied zip
//   - Deleting / selecting a voice
// =============================================================================

/// Interface for managing TTS voice model assets.
///
/// Implementation in [tts_player/data/repositories/voice_repository_impl.dart]
/// uses [http] for remote downloads, [archive] for zip extraction,
/// and [path_provider] for on-disk storage.
abstract interface class VoiceRepository {
  // ── Catalogue ─────────────────────────────────────────────────────────────

  /// Fetch the curated remote voice catalogue JSON and merge with locally
  /// stored voices. Returns a list ordered by: selected → local → remote.
  ///
  /// Network errors produce a [NetworkFailure]; the local list is always
  /// returned even when offline.
  Future<List<VoiceModel>> getAvailableVoices();

  /// Stream that emits the full updated [VoiceModel] list whenever:
  ///   - a download completes or fails
  ///   - a voice is deleted or imported
  ///   - the selected voice changes
  Stream<List<VoiceModel>> get voiceListStream;

  // ── Download ───────────────────────────────────────────────────────────────

  /// Download the remote zip for [voiceId], extract `.onnx` + `.json` to
  ///   `<ApplicationDocumentsDirectory>/voices/<voiceId>/`
  /// and update the voice status to [VoiceStatus.local].
  ///
  /// Progress (0.0 – 1.0) is emitted via [downloadProgressStream].
  Future<void> downloadVoice(String voiceId);

  /// Per-voice download progress stream. Key = voiceId, value = 0.0 – 1.0.
  /// Completes (and removes the key) when download finishes or fails.
  Stream<Map<String, double>> get downloadProgressStream;

  /// Cancel an in-progress download. No-op if [voiceId] is not downloading.
  Future<void> cancelDownload(String voiceId);

  // ── Import ─────────────────────────────────────────────────────────────────

  /// Import a user-supplied `.zip` file containing:
  ///   - exactly one `.onnx` model file
  ///   - exactly one `.json` config/tokens file
  ///
  /// The zip is extracted to `<ApplicationDocumentsDirectory>/voices/<id>/`
  /// where `id` is derived from the `.onnx` filename (snake_case, sanitised).
  ///
  /// Emits a [VoiceImportFailure] if the zip is malformed or missing files.
  Future<VoiceModel> importVoiceFromZip(String zipFilePath);

  // ── Selection & deletion ──────────────────────────────────────────────────

  /// Mark [voiceId] as the active voice. Persisted to local preferences.
  /// Triggers a new emission on [voiceListStream].
  Future<void> selectVoice(String voiceId);

  /// Delete the on-disk files for [voiceId] and set its status back to
  /// [VoiceStatus.remote] (or remove it entirely if it was a custom import).
  Future<void> deleteVoice(String voiceId);

  // ── Persistence ───────────────────────────────────────────────────────────

  /// Retrieve the currently selected [VoiceModel]. Returns null when no
  /// voice has been selected yet (first-launch state).
  Future<VoiceModel?> getSelectedVoice();
}

