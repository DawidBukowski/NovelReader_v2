// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoiceModelImpl _$$VoiceModelImplFromJson(Map<String, dynamic> json) =>
    _$VoiceModelImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      language: json['language'] as String,
      flagEmoji: json['flagEmoji'] as String,
      architecture:
          $enumDecode(_$VoiceArchitectureEnumMap, json['architecture']),
      onnxModelPath: json['onnxModelPath'] as String?,
      configJsonPath: json['configJsonPath'] as String?,
      speakerId: (json['speakerId'] as num?)?.toInt() ?? 0,
      sizeBytes: (json['sizeBytes'] as num).toInt(),
      remoteZipUrl: json['remoteZipUrl'] as String?,
      status: $enumDecodeNullable(_$VoiceStatusEnumMap, json['status']) ??
          VoiceStatus.remote,
      isSelected: json['isSelected'] as bool? ?? false,
      isCustomImport: json['isCustomImport'] as bool? ?? false,
      qualityRating: (json['qualityRating'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$$VoiceModelImplToJson(_$VoiceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'language': instance.language,
      'flagEmoji': instance.flagEmoji,
      'architecture': _$VoiceArchitectureEnumMap[instance.architecture]!,
      'onnxModelPath': instance.onnxModelPath,
      'configJsonPath': instance.configJsonPath,
      'speakerId': instance.speakerId,
      'sizeBytes': instance.sizeBytes,
      'remoteZipUrl': instance.remoteZipUrl,
      'status': _$VoiceStatusEnumMap[instance.status]!,
      'isSelected': instance.isSelected,
      'isCustomImport': instance.isCustomImport,
      'qualityRating': instance.qualityRating,
    };

const _$VoiceArchitectureEnumMap = {
  VoiceArchitecture.vits: 'vits',
  VoiceArchitecture.kokoro: 'kokoro',
  VoiceArchitecture.matcha: 'matcha',
};

const _$VoiceStatusEnumMap = {
  VoiceStatus.remote: 'remote',
  VoiceStatus.downloading: 'downloading',
  VoiceStatus.local: 'local',
};
