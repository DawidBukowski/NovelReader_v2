// lib/features/library/data/models/saved_article_dto.dart

import 'package:isar/isar.dart';

part 'saved_article_dto.g.dart';

@collection
class SavedArticleDto {
  SavedArticleDto();

  Id id = Isar.autoIncrement;

  late String title;
  late String content;        // full plain text
  late String sourceUrl;
  late String dateAdded;      // ISO-8601 string

  @Index()
  late int wordCount;

  // Progress: last segment index the user reached
  int lastSegmentIndex = 0;
}