// lib/features/library/domain/entities/saved_article.dart
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_article.freezed.dart';

@freezed
class SavedArticle with _$SavedArticle {
  const factory SavedArticle({
    required int id,
    required String title,
    required String sourceUrl,
    required String plainText,
    required DateTime savedAt,

    /// 0.0 – 1.0 read progress (updated when player advances).
    @Default(0.0) double readProgress,

    /// Last segment index the user reached.
    @Default(0) int lastSegmentIndex,

    /// Derived field: estimated read time at avg 200 wpm.
    @Default(0) int estimatedReadMinutes,
  }) = _SavedArticle;

  const SavedArticle._();

  bool get isStarted => readProgress > 0.0;
  bool get isFinished => readProgress >= 1.0;
}