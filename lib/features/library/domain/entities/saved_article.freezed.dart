// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SavedArticle {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get sourceUrl => throw _privateConstructorUsedError;
  String get plainText => throw _privateConstructorUsedError;
  DateTime get savedAt => throw _privateConstructorUsedError;

  /// 0.0 – 1.0 read progress (updated when player advances).
  double get readProgress => throw _privateConstructorUsedError;

  /// Last segment index the user reached.
  int get lastSegmentIndex => throw _privateConstructorUsedError;

  /// Derived field: estimated read time at avg 200 wpm.
  int get estimatedReadMinutes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SavedArticleCopyWith<SavedArticle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedArticleCopyWith<$Res> {
  factory $SavedArticleCopyWith(
          SavedArticle value, $Res Function(SavedArticle) then) =
      _$SavedArticleCopyWithImpl<$Res, SavedArticle>;
  @useResult
  $Res call(
      {int id,
      String title,
      String sourceUrl,
      String plainText,
      DateTime savedAt,
      double readProgress,
      int lastSegmentIndex,
      int estimatedReadMinutes});
}

/// @nodoc
class _$SavedArticleCopyWithImpl<$Res, $Val extends SavedArticle>
    implements $SavedArticleCopyWith<$Res> {
  _$SavedArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? sourceUrl = null,
    Object? plainText = null,
    Object? savedAt = null,
    Object? readProgress = null,
    Object? lastSegmentIndex = null,
    Object? estimatedReadMinutes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      plainText: null == plainText
          ? _value.plainText
          : plainText // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _value.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readProgress: null == readProgress
          ? _value.readProgress
          : readProgress // ignore: cast_nullable_to_non_nullable
              as double,
      lastSegmentIndex: null == lastSegmentIndex
          ? _value.lastSegmentIndex
          : lastSegmentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedReadMinutes: null == estimatedReadMinutes
          ? _value.estimatedReadMinutes
          : estimatedReadMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavedArticleImplCopyWith<$Res>
    implements $SavedArticleCopyWith<$Res> {
  factory _$$SavedArticleImplCopyWith(
          _$SavedArticleImpl value, $Res Function(_$SavedArticleImpl) then) =
      __$$SavedArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String sourceUrl,
      String plainText,
      DateTime savedAt,
      double readProgress,
      int lastSegmentIndex,
      int estimatedReadMinutes});
}

/// @nodoc
class __$$SavedArticleImplCopyWithImpl<$Res>
    extends _$SavedArticleCopyWithImpl<$Res, _$SavedArticleImpl>
    implements _$$SavedArticleImplCopyWith<$Res> {
  __$$SavedArticleImplCopyWithImpl(
      _$SavedArticleImpl _value, $Res Function(_$SavedArticleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? sourceUrl = null,
    Object? plainText = null,
    Object? savedAt = null,
    Object? readProgress = null,
    Object? lastSegmentIndex = null,
    Object? estimatedReadMinutes = null,
  }) {
    return _then(_$SavedArticleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      plainText: null == plainText
          ? _value.plainText
          : plainText // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _value.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readProgress: null == readProgress
          ? _value.readProgress
          : readProgress // ignore: cast_nullable_to_non_nullable
              as double,
      lastSegmentIndex: null == lastSegmentIndex
          ? _value.lastSegmentIndex
          : lastSegmentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedReadMinutes: null == estimatedReadMinutes
          ? _value.estimatedReadMinutes
          : estimatedReadMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SavedArticleImpl extends _SavedArticle {
  const _$SavedArticleImpl(
      {required this.id,
      required this.title,
      required this.sourceUrl,
      required this.plainText,
      required this.savedAt,
      this.readProgress = 0.0,
      this.lastSegmentIndex = 0,
      this.estimatedReadMinutes = 0})
      : super._();

  @override
  final int id;
  @override
  final String title;
  @override
  final String sourceUrl;
  @override
  final String plainText;
  @override
  final DateTime savedAt;

  /// 0.0 – 1.0 read progress (updated when player advances).
  @override
  @JsonKey()
  final double readProgress;

  /// Last segment index the user reached.
  @override
  @JsonKey()
  final int lastSegmentIndex;

  /// Derived field: estimated read time at avg 200 wpm.
  @override
  @JsonKey()
  final int estimatedReadMinutes;

  @override
  String toString() {
    return 'SavedArticle(id: $id, title: $title, sourceUrl: $sourceUrl, plainText: $plainText, savedAt: $savedAt, readProgress: $readProgress, lastSegmentIndex: $lastSegmentIndex, estimatedReadMinutes: $estimatedReadMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.plainText, plainText) ||
                other.plainText == plainText) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            (identical(other.readProgress, readProgress) ||
                other.readProgress == readProgress) &&
            (identical(other.lastSegmentIndex, lastSegmentIndex) ||
                other.lastSegmentIndex == lastSegmentIndex) &&
            (identical(other.estimatedReadMinutes, estimatedReadMinutes) ||
                other.estimatedReadMinutes == estimatedReadMinutes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, sourceUrl, plainText,
      savedAt, readProgress, lastSegmentIndex, estimatedReadMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedArticleImplCopyWith<_$SavedArticleImpl> get copyWith =>
      __$$SavedArticleImplCopyWithImpl<_$SavedArticleImpl>(this, _$identity);
}

abstract class _SavedArticle extends SavedArticle {
  const factory _SavedArticle(
      {required final int id,
      required final String title,
      required final String sourceUrl,
      required final String plainText,
      required final DateTime savedAt,
      final double readProgress,
      final int lastSegmentIndex,
      final int estimatedReadMinutes}) = _$SavedArticleImpl;
  const _SavedArticle._() : super._();

  @override
  int get id;
  @override
  String get title;
  @override
  String get sourceUrl;
  @override
  String get plainText;
  @override
  DateTime get savedAt;
  @override

  /// 0.0 – 1.0 read progress (updated when player advances).
  double get readProgress;
  @override

  /// Last segment index the user reached.
  int get lastSegmentIndex;
  @override

  /// Derived field: estimated read time at avg 200 wpm.
  int get estimatedReadMinutes;
  @override
  @JsonKey(ignore: true)
  _$$SavedArticleImplCopyWith<_$SavedArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
