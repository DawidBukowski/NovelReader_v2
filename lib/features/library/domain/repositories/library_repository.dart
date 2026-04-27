// lib/features/library/domain/repositories/library_repository.dart
// =============================================================================

import '../entities/saved_article.dart';

abstract interface class LibraryRepository {
  Future<List<SavedArticle>> getAllArticles();
  Future<SavedArticle?> getArticleById(int id);
  Future<int> saveArticle(SavedArticle article);
  Future<void> updateProgress(int id, double progress, int lastSegmentIndex);
  Future<void> deleteArticle(int id);
}
