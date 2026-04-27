// lib/features/tts_player/data/models/voice_model_dto.dart


import 'package:isar/isar.dart';
import '../../domain/entities/voice_model.dart';

part 'voice_model_dto.g.dart';

@collection
class VoiceModelDto {
  VoiceModelDto();

  // Isar auto-ID. We also store the domain [id] string separately.
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id; // domain identifier, e.g. "en_amy_medium"

  late String displayName;
  late String language;
  late String flagEmoji;
  late String architectureName; // raw string of VoiceArchitecture.name
  String? onnxModelPath;
  String? configJsonPath;
  late int speakerId;
  late int sizeBytes;
  String? remoteZipUrl;
  late String statusName; // raw string of VoiceStatus.name
  late bool isSelected;
  late bool isCustomImport;
  late int qualityRating;

  // ── Domain ↔ DTO conversion ────────────────────────────────────────────────

  factory VoiceModelDto.fromDomain(VoiceModel model) => VoiceModelDto()
    ..id = model.id
    ..displayName = model.displayName
    ..language = model.language
    ..flagEmoji = model.flagEmoji
    ..architectureName = model.architecture.name
    ..onnxModelPath = model.onnxModelPath
    ..configJsonPath = model.configJsonPath
    ..speakerId = model.speakerId
    ..sizeBytes = model.sizeBytes
    ..remoteZipUrl = model.remoteZipUrl
    ..statusName = model.status.name
    ..isSelected = model.isSelected
    ..isCustomImport = model.isCustomImport
    ..qualityRating = model.qualityRating;

  VoiceModel toDomain() => VoiceModel(
    id: id,
    displayName: displayName,
    language: language,
    flagEmoji: flagEmoji,
    architecture: VoiceArchitecture.values.byName(architectureName),
    onnxModelPath: onnxModelPath,
    configJsonPath: configJsonPath,
    speakerId: speakerId,
    sizeBytes: sizeBytes,
    remoteZipUrl: remoteZipUrl,
    status: VoiceStatus.values.byName(statusName),
    isSelected: isSelected,
    isCustomImport: isCustomImport,
    qualityRating: qualityRating,
  );
}