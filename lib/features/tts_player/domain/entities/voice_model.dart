import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_model.freezed.dart';
part 'voice_model.g.dart';

/// Where the voice currently lives on the device (or not yet).
enum VoiceStatus {
  /// Listed in the remote catalogue but not downloaded.
  remote,

  /// Currently being downloaded (0.0 – 1.0 progress tracked separately).
  downloading,

  /// Fully available on-device inside ApplicationDocumentsDirectory.
  local,
}

/// Supported TTS model architectures that sherpa_onnx can load.
/// Adding a new architecture only requires a new enum value + a
/// factory switch in [SherpaOnnxService] — no domain changes needed.
enum VoiceArchitecture {
  /// Piper (VITS-based) — fast, high-quality, widely available.
  vits,

  /// Kokoro — ultra-high quality, slower synthesis.
  kokoro,

  /// Matcha-TTS — diffusion-based, best prosody.
  matcha,
}

/// A single TTS voice/model the user can use for playback.
///
/// Immutable value object. Persisted in Isar via [VoiceModelDto].
@freezed
class VoiceModel with _$VoiceModel {
  const factory VoiceModel({
    /// Stable identifier — used as the Isar key and folder name on disk.
    /// Format: "<lang>_<name>_<quality>" e.g. "en_amy_medium"
    required String id,

    /// Human-readable display name, e.g. "Amy (English, Medium)".
    required String displayName,

    /// BCP-47 language tag, e.g. "en-US", "pl-PL", "de-DE".
    required String language,

    /// Flag emoji for quick visual identification in the voice picker.
    required String flagEmoji,

    /// Model architecture — determines which sherpa_onnx loader to use.
    required VoiceArchitecture architecture,

    /// Absolute path to the `.onnx` acoustic model file.
    /// Null when [status] is [VoiceStatus.remote].
    String? onnxModelPath,

    /// Absolute path to the companion `.json` config/tokens file.
    /// Null when [status] is [VoiceStatus.remote].
    String? configJsonPath,

    /// For multi-speaker models: the speaker index to synthesise with.
    /// Defaults to 0 (first / only speaker).
    @Default(0) int speakerId,

    /// Approximate download size in bytes. Used for download UI.
    required int sizeBytes,

    /// Download URL for the remote zip. Null for user-imported voices.
    String? remoteZipUrl,

    /// Current availability status.
    @Default(VoiceStatus.remote) VoiceStatus status,

    /// Whether this is the active voice used for TTS synthesis.
    @Default(false) bool isSelected,

    /// True when the user imported this voice manually (not from catalogue).
    @Default(false) bool isCustomImport,

    /// Quality rating shown in the UI (1–5). Sourced from remote JSON.
    @Default(3) int qualityRating,
  }) = _VoiceModel;

  factory VoiceModel.fromJson(Map<String, dynamic> json) =>
      _$VoiceModelFromJson(json);
}