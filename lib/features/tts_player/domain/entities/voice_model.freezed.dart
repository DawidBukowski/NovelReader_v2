// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoiceModel _$VoiceModelFromJson(Map<String, dynamic> json) {
  return _VoiceModel.fromJson(json);
}

/// @nodoc
mixin _$VoiceModel {
  /// Stable identifier — used as the Isar key and folder name on disk.
  /// Format: "<lang>_<name>_<quality>" e.g. "en_amy_medium"
  String get id => throw _privateConstructorUsedError;

  /// Human-readable display name, e.g. "Amy (English, Medium)".
  String get displayName => throw _privateConstructorUsedError;

  /// BCP-47 language tag, e.g. "en-US", "pl-PL", "de-DE".
  String get language => throw _privateConstructorUsedError;

  /// Flag emoji for quick visual identification in the voice picker.
  String get flagEmoji => throw _privateConstructorUsedError;

  /// Model architecture — determines which sherpa_onnx loader to use.
  VoiceArchitecture get architecture => throw _privateConstructorUsedError;

  /// Absolute path to the `.onnx` acoustic model file.
  /// Null when [status] is [VoiceStatus.remote].
  String? get onnxModelPath => throw _privateConstructorUsedError;

  /// Absolute path to the companion `.json` config/tokens file.
  /// Null when [status] is [VoiceStatus.remote].
  String? get configJsonPath => throw _privateConstructorUsedError;

  /// For multi-speaker models: the speaker index to synthesise with.
  /// Defaults to 0 (first / only speaker).
  int get speakerId => throw _privateConstructorUsedError;

  /// Approximate download size in bytes. Used for download UI.
  int get sizeBytes => throw _privateConstructorUsedError;

  /// Download URL for the remote zip. Null for user-imported voices.
  String? get remoteZipUrl => throw _privateConstructorUsedError;

  /// Current availability status.
  VoiceStatus get status => throw _privateConstructorUsedError;

  /// Whether this is the active voice used for TTS synthesis.
  bool get isSelected => throw _privateConstructorUsedError;

  /// True when the user imported this voice manually (not from catalogue).
  bool get isCustomImport => throw _privateConstructorUsedError;

  /// Quality rating shown in the UI (1–5). Sourced from remote JSON.
  int get qualityRating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoiceModelCopyWith<VoiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceModelCopyWith<$Res> {
  factory $VoiceModelCopyWith(
          VoiceModel value, $Res Function(VoiceModel) then) =
      _$VoiceModelCopyWithImpl<$Res, VoiceModel>;
  @useResult
  $Res call(
      {String id,
      String displayName,
      String language,
      String flagEmoji,
      VoiceArchitecture architecture,
      String? onnxModelPath,
      String? configJsonPath,
      int speakerId,
      int sizeBytes,
      String? remoteZipUrl,
      VoiceStatus status,
      bool isSelected,
      bool isCustomImport,
      int qualityRating});
}

/// @nodoc
class _$VoiceModelCopyWithImpl<$Res, $Val extends VoiceModel>
    implements $VoiceModelCopyWith<$Res> {
  _$VoiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? language = null,
    Object? flagEmoji = null,
    Object? architecture = null,
    Object? onnxModelPath = freezed,
    Object? configJsonPath = freezed,
    Object? speakerId = null,
    Object? sizeBytes = null,
    Object? remoteZipUrl = freezed,
    Object? status = null,
    Object? isSelected = null,
    Object? isCustomImport = null,
    Object? qualityRating = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      flagEmoji: null == flagEmoji
          ? _value.flagEmoji
          : flagEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      architecture: null == architecture
          ? _value.architecture
          : architecture // ignore: cast_nullable_to_non_nullable
              as VoiceArchitecture,
      onnxModelPath: freezed == onnxModelPath
          ? _value.onnxModelPath
          : onnxModelPath // ignore: cast_nullable_to_non_nullable
              as String?,
      configJsonPath: freezed == configJsonPath
          ? _value.configJsonPath
          : configJsonPath // ignore: cast_nullable_to_non_nullable
              as String?,
      speakerId: null == speakerId
          ? _value.speakerId
          : speakerId // ignore: cast_nullable_to_non_nullable
              as int,
      sizeBytes: null == sizeBytes
          ? _value.sizeBytes
          : sizeBytes // ignore: cast_nullable_to_non_nullable
              as int,
      remoteZipUrl: freezed == remoteZipUrl
          ? _value.remoteZipUrl
          : remoteZipUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VoiceStatus,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      isCustomImport: null == isCustomImport
          ? _value.isCustomImport
          : isCustomImport // ignore: cast_nullable_to_non_nullable
              as bool,
      qualityRating: null == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoiceModelImplCopyWith<$Res>
    implements $VoiceModelCopyWith<$Res> {
  factory _$$VoiceModelImplCopyWith(
          _$VoiceModelImpl value, $Res Function(_$VoiceModelImpl) then) =
      __$$VoiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String displayName,
      String language,
      String flagEmoji,
      VoiceArchitecture architecture,
      String? onnxModelPath,
      String? configJsonPath,
      int speakerId,
      int sizeBytes,
      String? remoteZipUrl,
      VoiceStatus status,
      bool isSelected,
      bool isCustomImport,
      int qualityRating});
}

/// @nodoc
class __$$VoiceModelImplCopyWithImpl<$Res>
    extends _$VoiceModelCopyWithImpl<$Res, _$VoiceModelImpl>
    implements _$$VoiceModelImplCopyWith<$Res> {
  __$$VoiceModelImplCopyWithImpl(
      _$VoiceModelImpl _value, $Res Function(_$VoiceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? language = null,
    Object? flagEmoji = null,
    Object? architecture = null,
    Object? onnxModelPath = freezed,
    Object? configJsonPath = freezed,
    Object? speakerId = null,
    Object? sizeBytes = null,
    Object? remoteZipUrl = freezed,
    Object? status = null,
    Object? isSelected = null,
    Object? isCustomImport = null,
    Object? qualityRating = null,
  }) {
    return _then(_$VoiceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      flagEmoji: null == flagEmoji
          ? _value.flagEmoji
          : flagEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      architecture: null == architecture
          ? _value.architecture
          : architecture // ignore: cast_nullable_to_non_nullable
              as VoiceArchitecture,
      onnxModelPath: freezed == onnxModelPath
          ? _value.onnxModelPath
          : onnxModelPath // ignore: cast_nullable_to_non_nullable
              as String?,
      configJsonPath: freezed == configJsonPath
          ? _value.configJsonPath
          : configJsonPath // ignore: cast_nullable_to_non_nullable
              as String?,
      speakerId: null == speakerId
          ? _value.speakerId
          : speakerId // ignore: cast_nullable_to_non_nullable
              as int,
      sizeBytes: null == sizeBytes
          ? _value.sizeBytes
          : sizeBytes // ignore: cast_nullable_to_non_nullable
              as int,
      remoteZipUrl: freezed == remoteZipUrl
          ? _value.remoteZipUrl
          : remoteZipUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VoiceStatus,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      isCustomImport: null == isCustomImport
          ? _value.isCustomImport
          : isCustomImport // ignore: cast_nullable_to_non_nullable
              as bool,
      qualityRating: null == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoiceModelImpl implements _VoiceModel {
  const _$VoiceModelImpl(
      {required this.id,
      required this.displayName,
      required this.language,
      required this.flagEmoji,
      required this.architecture,
      this.onnxModelPath,
      this.configJsonPath,
      this.speakerId = 0,
      required this.sizeBytes,
      this.remoteZipUrl,
      this.status = VoiceStatus.remote,
      this.isSelected = false,
      this.isCustomImport = false,
      this.qualityRating = 3});

  factory _$VoiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoiceModelImplFromJson(json);

  /// Stable identifier — used as the Isar key and folder name on disk.
  /// Format: "<lang>_<name>_<quality>" e.g. "en_amy_medium"
  @override
  final String id;

  /// Human-readable display name, e.g. "Amy (English, Medium)".
  @override
  final String displayName;

  /// BCP-47 language tag, e.g. "en-US", "pl-PL", "de-DE".
  @override
  final String language;

  /// Flag emoji for quick visual identification in the voice picker.
  @override
  final String flagEmoji;

  /// Model architecture — determines which sherpa_onnx loader to use.
  @override
  final VoiceArchitecture architecture;

  /// Absolute path to the `.onnx` acoustic model file.
  /// Null when [status] is [VoiceStatus.remote].
  @override
  final String? onnxModelPath;

  /// Absolute path to the companion `.json` config/tokens file.
  /// Null when [status] is [VoiceStatus.remote].
  @override
  final String? configJsonPath;

  /// For multi-speaker models: the speaker index to synthesise with.
  /// Defaults to 0 (first / only speaker).
  @override
  @JsonKey()
  final int speakerId;

  /// Approximate download size in bytes. Used for download UI.
  @override
  final int sizeBytes;

  /// Download URL for the remote zip. Null for user-imported voices.
  @override
  final String? remoteZipUrl;

  /// Current availability status.
  @override
  @JsonKey()
  final VoiceStatus status;

  /// Whether this is the active voice used for TTS synthesis.
  @override
  @JsonKey()
  final bool isSelected;

  /// True when the user imported this voice manually (not from catalogue).
  @override
  @JsonKey()
  final bool isCustomImport;

  /// Quality rating shown in the UI (1–5). Sourced from remote JSON.
  @override
  @JsonKey()
  final int qualityRating;

  @override
  String toString() {
    return 'VoiceModel(id: $id, displayName: $displayName, language: $language, flagEmoji: $flagEmoji, architecture: $architecture, onnxModelPath: $onnxModelPath, configJsonPath: $configJsonPath, speakerId: $speakerId, sizeBytes: $sizeBytes, remoteZipUrl: $remoteZipUrl, status: $status, isSelected: $isSelected, isCustomImport: $isCustomImport, qualityRating: $qualityRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.flagEmoji, flagEmoji) ||
                other.flagEmoji == flagEmoji) &&
            (identical(other.architecture, architecture) ||
                other.architecture == architecture) &&
            (identical(other.onnxModelPath, onnxModelPath) ||
                other.onnxModelPath == onnxModelPath) &&
            (identical(other.configJsonPath, configJsonPath) ||
                other.configJsonPath == configJsonPath) &&
            (identical(other.speakerId, speakerId) ||
                other.speakerId == speakerId) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.remoteZipUrl, remoteZipUrl) ||
                other.remoteZipUrl == remoteZipUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected) &&
            (identical(other.isCustomImport, isCustomImport) ||
                other.isCustomImport == isCustomImport) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayName,
      language,
      flagEmoji,
      architecture,
      onnxModelPath,
      configJsonPath,
      speakerId,
      sizeBytes,
      remoteZipUrl,
      status,
      isSelected,
      isCustomImport,
      qualityRating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceModelImplCopyWith<_$VoiceModelImpl> get copyWith =>
      __$$VoiceModelImplCopyWithImpl<_$VoiceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoiceModelImplToJson(
      this,
    );
  }
}

abstract class _VoiceModel implements VoiceModel {
  const factory _VoiceModel(
      {required final String id,
      required final String displayName,
      required final String language,
      required final String flagEmoji,
      required final VoiceArchitecture architecture,
      final String? onnxModelPath,
      final String? configJsonPath,
      final int speakerId,
      required final int sizeBytes,
      final String? remoteZipUrl,
      final VoiceStatus status,
      final bool isSelected,
      final bool isCustomImport,
      final int qualityRating}) = _$VoiceModelImpl;

  factory _VoiceModel.fromJson(Map<String, dynamic> json) =
      _$VoiceModelImpl.fromJson;

  @override

  /// Stable identifier — used as the Isar key and folder name on disk.
  /// Format: "<lang>_<name>_<quality>" e.g. "en_amy_medium"
  String get id;
  @override

  /// Human-readable display name, e.g. "Amy (English, Medium)".
  String get displayName;
  @override

  /// BCP-47 language tag, e.g. "en-US", "pl-PL", "de-DE".
  String get language;
  @override

  /// Flag emoji for quick visual identification in the voice picker.
  String get flagEmoji;
  @override

  /// Model architecture — determines which sherpa_onnx loader to use.
  VoiceArchitecture get architecture;
  @override

  /// Absolute path to the `.onnx` acoustic model file.
  /// Null when [status] is [VoiceStatus.remote].
  String? get onnxModelPath;
  @override

  /// Absolute path to the companion `.json` config/tokens file.
  /// Null when [status] is [VoiceStatus.remote].
  String? get configJsonPath;
  @override

  /// For multi-speaker models: the speaker index to synthesise with.
  /// Defaults to 0 (first / only speaker).
  int get speakerId;
  @override

  /// Approximate download size in bytes. Used for download UI.
  int get sizeBytes;
  @override

  /// Download URL for the remote zip. Null for user-imported voices.
  String? get remoteZipUrl;
  @override

  /// Current availability status.
  VoiceStatus get status;
  @override

  /// Whether this is the active voice used for TTS synthesis.
  bool get isSelected;
  @override

  /// True when the user imported this voice manually (not from catalogue).
  bool get isCustomImport;
  @override

  /// Quality rating shown in the UI (1–5). Sourced from remote JSON.
  int get qualityRating;
  @override
  @JsonKey(ignore: true)
  _$$VoiceModelImplCopyWith<_$VoiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
