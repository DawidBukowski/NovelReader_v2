// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentence_segment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SentenceSegment {
  /// Zero-based index in the full segment list. Used as the cursor.
  int get index => throw _privateConstructorUsedError;

  /// The raw text of this sentence as it appears in the article.
  String get text => throw _privateConstructorUsedError;

  /// Character offset of the first character in the original full text.
  /// Enables precise caret positioning for scroll-to-active behaviour.
  int get startOffset => throw _privateConstructorUsedError;

  /// Character offset one past the last character (exclusive end).
  int get endOffset => throw _privateConstructorUsedError;

  /// Synthesis state for this individual segment.
  SegmentSynthesisState get synthesisState =>
      throw _privateConstructorUsedError;

  /// Path to the pre-synthesised WAV/PCM file for this segment.
  /// Non-null only when [synthesisState] is [SegmentSynthesisState.ready].
  /// Files are written to a temp directory and deleted after playback.
  String? get audioFilePath => throw _privateConstructorUsedError;

  /// Duration of the synthesised audio. Available once synthesis completes.
  Duration? get audioDuration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SentenceSegmentCopyWith<SentenceSegment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentenceSegmentCopyWith<$Res> {
  factory $SentenceSegmentCopyWith(
          SentenceSegment value, $Res Function(SentenceSegment) then) =
      _$SentenceSegmentCopyWithImpl<$Res, SentenceSegment>;
  @useResult
  $Res call(
      {int index,
      String text,
      int startOffset,
      int endOffset,
      SegmentSynthesisState synthesisState,
      String? audioFilePath,
      Duration? audioDuration});
}

/// @nodoc
class _$SentenceSegmentCopyWithImpl<$Res, $Val extends SentenceSegment>
    implements $SentenceSegmentCopyWith<$Res> {
  _$SentenceSegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? text = null,
    Object? startOffset = null,
    Object? endOffset = null,
    Object? synthesisState = null,
    Object? audioFilePath = freezed,
    Object? audioDuration = freezed,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      startOffset: null == startOffset
          ? _value.startOffset
          : startOffset // ignore: cast_nullable_to_non_nullable
              as int,
      endOffset: null == endOffset
          ? _value.endOffset
          : endOffset // ignore: cast_nullable_to_non_nullable
              as int,
      synthesisState: null == synthesisState
          ? _value.synthesisState
          : synthesisState // ignore: cast_nullable_to_non_nullable
              as SegmentSynthesisState,
      audioFilePath: freezed == audioFilePath
          ? _value.audioFilePath
          : audioFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      audioDuration: freezed == audioDuration
          ? _value.audioDuration
          : audioDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentenceSegmentImplCopyWith<$Res>
    implements $SentenceSegmentCopyWith<$Res> {
  factory _$$SentenceSegmentImplCopyWith(_$SentenceSegmentImpl value,
          $Res Function(_$SentenceSegmentImpl) then) =
      __$$SentenceSegmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int index,
      String text,
      int startOffset,
      int endOffset,
      SegmentSynthesisState synthesisState,
      String? audioFilePath,
      Duration? audioDuration});
}

/// @nodoc
class __$$SentenceSegmentImplCopyWithImpl<$Res>
    extends _$SentenceSegmentCopyWithImpl<$Res, _$SentenceSegmentImpl>
    implements _$$SentenceSegmentImplCopyWith<$Res> {
  __$$SentenceSegmentImplCopyWithImpl(
      _$SentenceSegmentImpl _value, $Res Function(_$SentenceSegmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? text = null,
    Object? startOffset = null,
    Object? endOffset = null,
    Object? synthesisState = null,
    Object? audioFilePath = freezed,
    Object? audioDuration = freezed,
  }) {
    return _then(_$SentenceSegmentImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      startOffset: null == startOffset
          ? _value.startOffset
          : startOffset // ignore: cast_nullable_to_non_nullable
              as int,
      endOffset: null == endOffset
          ? _value.endOffset
          : endOffset // ignore: cast_nullable_to_non_nullable
              as int,
      synthesisState: null == synthesisState
          ? _value.synthesisState
          : synthesisState // ignore: cast_nullable_to_non_nullable
              as SegmentSynthesisState,
      audioFilePath: freezed == audioFilePath
          ? _value.audioFilePath
          : audioFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      audioDuration: freezed == audioDuration
          ? _value.audioDuration
          : audioDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$SentenceSegmentImpl implements _SentenceSegment {
  const _$SentenceSegmentImpl(
      {required this.index,
      required this.text,
      required this.startOffset,
      required this.endOffset,
      this.synthesisState = SegmentSynthesisState.pending,
      this.audioFilePath,
      this.audioDuration});

  /// Zero-based index in the full segment list. Used as the cursor.
  @override
  final int index;

  /// The raw text of this sentence as it appears in the article.
  @override
  final String text;

  /// Character offset of the first character in the original full text.
  /// Enables precise caret positioning for scroll-to-active behaviour.
  @override
  final int startOffset;

  /// Character offset one past the last character (exclusive end).
  @override
  final int endOffset;

  /// Synthesis state for this individual segment.
  @override
  @JsonKey()
  final SegmentSynthesisState synthesisState;

  /// Path to the pre-synthesised WAV/PCM file for this segment.
  /// Non-null only when [synthesisState] is [SegmentSynthesisState.ready].
  /// Files are written to a temp directory and deleted after playback.
  @override
  final String? audioFilePath;

  /// Duration of the synthesised audio. Available once synthesis completes.
  @override
  final Duration? audioDuration;

  @override
  String toString() {
    return 'SentenceSegment(index: $index, text: $text, startOffset: $startOffset, endOffset: $endOffset, synthesisState: $synthesisState, audioFilePath: $audioFilePath, audioDuration: $audioDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceSegmentImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.startOffset, startOffset) ||
                other.startOffset == startOffset) &&
            (identical(other.endOffset, endOffset) ||
                other.endOffset == endOffset) &&
            (identical(other.synthesisState, synthesisState) ||
                other.synthesisState == synthesisState) &&
            (identical(other.audioFilePath, audioFilePath) ||
                other.audioFilePath == audioFilePath) &&
            (identical(other.audioDuration, audioDuration) ||
                other.audioDuration == audioDuration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, text, startOffset,
      endOffset, synthesisState, audioFilePath, audioDuration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SentenceSegmentImplCopyWith<_$SentenceSegmentImpl> get copyWith =>
      __$$SentenceSegmentImplCopyWithImpl<_$SentenceSegmentImpl>(
          this, _$identity);
}

abstract class _SentenceSegment implements SentenceSegment {
  const factory _SentenceSegment(
      {required final int index,
      required final String text,
      required final int startOffset,
      required final int endOffset,
      final SegmentSynthesisState synthesisState,
      final String? audioFilePath,
      final Duration? audioDuration}) = _$SentenceSegmentImpl;

  @override

  /// Zero-based index in the full segment list. Used as the cursor.
  int get index;
  @override

  /// The raw text of this sentence as it appears in the article.
  String get text;
  @override

  /// Character offset of the first character in the original full text.
  /// Enables precise caret positioning for scroll-to-active behaviour.
  int get startOffset;
  @override

  /// Character offset one past the last character (exclusive end).
  int get endOffset;
  @override

  /// Synthesis state for this individual segment.
  SegmentSynthesisState get synthesisState;
  @override

  /// Path to the pre-synthesised WAV/PCM file for this segment.
  /// Non-null only when [synthesisState] is [SegmentSynthesisState.ready].
  /// Files are written to a temp directory and deleted after playback.
  String? get audioFilePath;
  @override

  /// Duration of the synthesised audio. Available once synthesis completes.
  Duration? get audioDuration;
  @override
  @JsonKey(ignore: true)
  _$$SentenceSegmentImplCopyWith<_$SentenceSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
