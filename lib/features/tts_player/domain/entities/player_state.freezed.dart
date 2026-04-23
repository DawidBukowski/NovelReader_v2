// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TtsPlayerState {
// ── Playback ───────────────────────────────────────────────────────────
  TtsPlaybackStatus get status => throw _privateConstructorUsedError;

  /// Index into [segments] for the sentence currently playing.
  /// -1 when no sentence is active (idle / completed).
  int get activeSegmentIndex => throw _privateConstructorUsedError;

  /// The full ordered list of sentence segments for the loaded article.
  List<SentenceSegment> get segments =>
      throw _privateConstructorUsedError; // ── Voice & Speed ─────────────────────────────────────────────────────
  /// Currently selected TTS voice. Null until user picks one.
  VoiceModel? get activeVoice => throw _privateConstructorUsedError;

  /// Synthesis + playback speed multiplier. Clamped to 0.5 – 3.0.
  double get speed =>
      throw _privateConstructorUsedError; // ── Article Metadata ──────────────────────────────────────────────────
  /// Isar ID of the article being read. Null for transient / unsaved reads.
  int? get articleId => throw _privateConstructorUsedError;

  /// Article title — shown in the player header and lock-screen.
  String get articleTitle => throw _privateConstructorUsedError;

  /// Source URL — shown beneath the title.
  String get articleSourceUrl =>
      throw _privateConstructorUsedError; // ── Progress (derived, but stored to avoid re-computation on every tick) ─
  /// Number of segments fully synthesised and ready.
  int get synthesisedCount =>
      throw _privateConstructorUsedError; // ── Error ─────────────────────────────────────────────────────────────
  /// Human-readable error message when [status] == [TtsPlaybackStatus.error].
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TtsPlayerStateCopyWith<TtsPlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TtsPlayerStateCopyWith<$Res> {
  factory $TtsPlayerStateCopyWith(
          TtsPlayerState value, $Res Function(TtsPlayerState) then) =
      _$TtsPlayerStateCopyWithImpl<$Res, TtsPlayerState>;
  @useResult
  $Res call(
      {TtsPlaybackStatus status,
      int activeSegmentIndex,
      List<SentenceSegment> segments,
      VoiceModel? activeVoice,
      double speed,
      int? articleId,
      String articleTitle,
      String articleSourceUrl,
      int synthesisedCount,
      String? errorMessage});

  $VoiceModelCopyWith<$Res>? get activeVoice;
}

/// @nodoc
class _$TtsPlayerStateCopyWithImpl<$Res, $Val extends TtsPlayerState>
    implements $TtsPlayerStateCopyWith<$Res> {
  _$TtsPlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? activeSegmentIndex = null,
    Object? segments = null,
    Object? activeVoice = freezed,
    Object? speed = null,
    Object? articleId = freezed,
    Object? articleTitle = null,
    Object? articleSourceUrl = null,
    Object? synthesisedCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TtsPlaybackStatus,
      activeSegmentIndex: null == activeSegmentIndex
          ? _value.activeSegmentIndex
          : activeSegmentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      segments: null == segments
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<SentenceSegment>,
      activeVoice: freezed == activeVoice
          ? _value.activeVoice
          : activeVoice // ignore: cast_nullable_to_non_nullable
              as VoiceModel?,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      articleId: freezed == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as int?,
      articleTitle: null == articleTitle
          ? _value.articleTitle
          : articleTitle // ignore: cast_nullable_to_non_nullable
              as String,
      articleSourceUrl: null == articleSourceUrl
          ? _value.articleSourceUrl
          : articleSourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      synthesisedCount: null == synthesisedCount
          ? _value.synthesisedCount
          : synthesisedCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VoiceModelCopyWith<$Res>? get activeVoice {
    if (_value.activeVoice == null) {
      return null;
    }

    return $VoiceModelCopyWith<$Res>(_value.activeVoice!, (value) {
      return _then(_value.copyWith(activeVoice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TtsPlayerStateImplCopyWith<$Res>
    implements $TtsPlayerStateCopyWith<$Res> {
  factory _$$TtsPlayerStateImplCopyWith(_$TtsPlayerStateImpl value,
          $Res Function(_$TtsPlayerStateImpl) then) =
      __$$TtsPlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TtsPlaybackStatus status,
      int activeSegmentIndex,
      List<SentenceSegment> segments,
      VoiceModel? activeVoice,
      double speed,
      int? articleId,
      String articleTitle,
      String articleSourceUrl,
      int synthesisedCount,
      String? errorMessage});

  @override
  $VoiceModelCopyWith<$Res>? get activeVoice;
}

/// @nodoc
class __$$TtsPlayerStateImplCopyWithImpl<$Res>
    extends _$TtsPlayerStateCopyWithImpl<$Res, _$TtsPlayerStateImpl>
    implements _$$TtsPlayerStateImplCopyWith<$Res> {
  __$$TtsPlayerStateImplCopyWithImpl(
      _$TtsPlayerStateImpl _value, $Res Function(_$TtsPlayerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? activeSegmentIndex = null,
    Object? segments = null,
    Object? activeVoice = freezed,
    Object? speed = null,
    Object? articleId = freezed,
    Object? articleTitle = null,
    Object? articleSourceUrl = null,
    Object? synthesisedCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$TtsPlayerStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TtsPlaybackStatus,
      activeSegmentIndex: null == activeSegmentIndex
          ? _value.activeSegmentIndex
          : activeSegmentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      segments: null == segments
          ? _value._segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<SentenceSegment>,
      activeVoice: freezed == activeVoice
          ? _value.activeVoice
          : activeVoice // ignore: cast_nullable_to_non_nullable
              as VoiceModel?,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      articleId: freezed == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as int?,
      articleTitle: null == articleTitle
          ? _value.articleTitle
          : articleTitle // ignore: cast_nullable_to_non_nullable
              as String,
      articleSourceUrl: null == articleSourceUrl
          ? _value.articleSourceUrl
          : articleSourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      synthesisedCount: null == synthesisedCount
          ? _value.synthesisedCount
          : synthesisedCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TtsPlayerStateImpl extends _TtsPlayerState {
  const _$TtsPlayerStateImpl(
      {this.status = TtsPlaybackStatus.idle,
      this.activeSegmentIndex = -1,
      final List<SentenceSegment> segments = const [],
      this.activeVoice,
      this.speed = 1.0,
      this.articleId,
      this.articleTitle = '',
      this.articleSourceUrl = '',
      this.synthesisedCount = 0,
      this.errorMessage})
      : _segments = segments,
        super._();

// ── Playback ───────────────────────────────────────────────────────────
  @override
  @JsonKey()
  final TtsPlaybackStatus status;

  /// Index into [segments] for the sentence currently playing.
  /// -1 when no sentence is active (idle / completed).
  @override
  @JsonKey()
  final int activeSegmentIndex;

  /// The full ordered list of sentence segments for the loaded article.
  final List<SentenceSegment> _segments;

  /// The full ordered list of sentence segments for the loaded article.
  @override
  @JsonKey()
  List<SentenceSegment> get segments {
    if (_segments is EqualUnmodifiableListView) return _segments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

// ── Voice & Speed ─────────────────────────────────────────────────────
  /// Currently selected TTS voice. Null until user picks one.
  @override
  final VoiceModel? activeVoice;

  /// Synthesis + playback speed multiplier. Clamped to 0.5 – 3.0.
  @override
  @JsonKey()
  final double speed;
// ── Article Metadata ──────────────────────────────────────────────────
  /// Isar ID of the article being read. Null for transient / unsaved reads.
  @override
  final int? articleId;

  /// Article title — shown in the player header and lock-screen.
  @override
  @JsonKey()
  final String articleTitle;

  /// Source URL — shown beneath the title.
  @override
  @JsonKey()
  final String articleSourceUrl;
// ── Progress (derived, but stored to avoid re-computation on every tick) ─
  /// Number of segments fully synthesised and ready.
  @override
  @JsonKey()
  final int synthesisedCount;
// ── Error ─────────────────────────────────────────────────────────────
  /// Human-readable error message when [status] == [TtsPlaybackStatus.error].
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TtsPlayerState(status: $status, activeSegmentIndex: $activeSegmentIndex, segments: $segments, activeVoice: $activeVoice, speed: $speed, articleId: $articleId, articleTitle: $articleTitle, articleSourceUrl: $articleSourceUrl, synthesisedCount: $synthesisedCount, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TtsPlayerStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.activeSegmentIndex, activeSegmentIndex) ||
                other.activeSegmentIndex == activeSegmentIndex) &&
            const DeepCollectionEquality().equals(other._segments, _segments) &&
            (identical(other.activeVoice, activeVoice) ||
                other.activeVoice == activeVoice) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId) &&
            (identical(other.articleTitle, articleTitle) ||
                other.articleTitle == articleTitle) &&
            (identical(other.articleSourceUrl, articleSourceUrl) ||
                other.articleSourceUrl == articleSourceUrl) &&
            (identical(other.synthesisedCount, synthesisedCount) ||
                other.synthesisedCount == synthesisedCount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      activeSegmentIndex,
      const DeepCollectionEquality().hash(_segments),
      activeVoice,
      speed,
      articleId,
      articleTitle,
      articleSourceUrl,
      synthesisedCount,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TtsPlayerStateImplCopyWith<_$TtsPlayerStateImpl> get copyWith =>
      __$$TtsPlayerStateImplCopyWithImpl<_$TtsPlayerStateImpl>(
          this, _$identity);
}

abstract class _TtsPlayerState extends TtsPlayerState {
  const factory _TtsPlayerState(
      {final TtsPlaybackStatus status,
      final int activeSegmentIndex,
      final List<SentenceSegment> segments,
      final VoiceModel? activeVoice,
      final double speed,
      final int? articleId,
      final String articleTitle,
      final String articleSourceUrl,
      final int synthesisedCount,
      final String? errorMessage}) = _$TtsPlayerStateImpl;
  const _TtsPlayerState._() : super._();

  @override // ── Playback ───────────────────────────────────────────────────────────
  TtsPlaybackStatus get status;
  @override

  /// Index into [segments] for the sentence currently playing.
  /// -1 when no sentence is active (idle / completed).
  int get activeSegmentIndex;
  @override

  /// The full ordered list of sentence segments for the loaded article.
  List<SentenceSegment> get segments;
  @override // ── Voice & Speed ─────────────────────────────────────────────────────
  /// Currently selected TTS voice. Null until user picks one.
  VoiceModel? get activeVoice;
  @override

  /// Synthesis + playback speed multiplier. Clamped to 0.5 – 3.0.
  double get speed;
  @override // ── Article Metadata ──────────────────────────────────────────────────
  /// Isar ID of the article being read. Null for transient / unsaved reads.
  int? get articleId;
  @override

  /// Article title — shown in the player header and lock-screen.
  String get articleTitle;
  @override

  /// Source URL — shown beneath the title.
  String get articleSourceUrl;
  @override // ── Progress (derived, but stored to avoid re-computation on every tick) ─
  /// Number of segments fully synthesised and ready.
  int get synthesisedCount;
  @override // ── Error ─────────────────────────────────────────────────────────────
  /// Human-readable error message when [status] == [TtsPlaybackStatus.error].
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$TtsPlayerStateImplCopyWith<_$TtsPlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
