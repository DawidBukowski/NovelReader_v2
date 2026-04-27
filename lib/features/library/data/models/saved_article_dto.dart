// lib/features/library/data/models/saved_article_dto.dart
// =============================================================================

import 'package:isar/isar.dart';

import '../../domain/entities/saved_article.dart';

part 'saved_article_dto.g.dart';

@collection
class SavedArticleDto {
  SavedArticleDto();

  Id id = Isar.autoIncrement;

  late String title;
  late String sourceUrl;

  @Index(type: IndexType.value)
  late DateTime savedAt;

  late String plainText;
  late double readProgress;
  late int lastSegmentIndex;
  late int estimatedReadMinutes;

  factory SavedArticleDto.fromDomain(SavedArticle article) =>
      SavedArticleDto()
        ..id = article.id == 0 ? Isar.autoIncrement : article.id
        ..title = article.title
        ..sourceUrl = article.sourceUrl
        ..plainText = article.plainText
        ..savedAt = article.savedAt
        ..readProgress = article.readProgress
        ..lastSegmentIndex = article.lastSegmentIndex
        ..estimatedReadMinutes = article.estimatedReadMinutes;

  SavedArticle toDomain() => SavedArticle(
    id: id,
    title: title,
    sourceUrl: sourceUrl,
    plainText: plainText,
    savedAt: savedAt,
    readProgress: readProgress,
    lastSegmentIndex: lastSegmentIndex,
    estimatedReadMinutes: estimatedReadMinutes,
  );
}