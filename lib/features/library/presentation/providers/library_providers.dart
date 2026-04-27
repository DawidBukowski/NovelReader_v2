// lib/features/library/presentation/providers/library_providers.dart
// =============================================================================

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_provider.dart';
import '../../data/repositories/library_repository_impl.dart';
import '../../domain/entities/saved_article.dart';
import '../../domain/repositories/library_repository.dart';

part 'library_providers.g.dart';

@riverpod
Future<LibraryRepository> libraryRepository(LibraryRepositoryRef ref) async {
  final isar = await ref.watch(isarProvider.future);
  return LibraryRepositoryImpl(isar);
}

@riverpod
Future<List<SavedArticle>> savedArticles(SavedArticlesRef ref) async {
  final repo = await ref.watch(libraryRepositoryProvider.future);
  return repo.getAllArticles();
}

@riverpod
Future<SavedArticle?> articleById(ArticleByIdRef ref, int id) async {
  final repo = await ref.watch(libraryRepositoryProvider.future);
  return repo.getArticleById(id);
}

@riverpod
class DeleteArticleUseCase extends _$DeleteArticleUseCase {
  @override
  void build() {}

  Future<void> delete(int id) async {
    final repo = await ref.read(libraryRepositoryProvider.future);
    await repo.deleteArticle(id);
    ref.invalidate(savedArticlesProvider);
  }
}