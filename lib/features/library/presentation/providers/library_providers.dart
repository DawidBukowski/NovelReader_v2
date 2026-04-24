// lib/features/library/presentation/providers/library_providers.dart

import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_provider.dart';
import '../../data/models/saved_article_dto.dart';

part 'library_providers.g.dart';

// ── List of all saved articles (newest first) ─────────────────────────────────

@riverpod
Future<List<SavedArticleDto>> savedArticles(SavedArticlesRef ref) async {
  final isar = await ref.watch(isarProvider.future);
  return isar.savedArticleDtos
      .where()
      .sortByDateAddedDesc()
      .findAll();
}

// ── Save a new article ────────────────────────────────────────────────────────

@riverpod
class ArticleSaver extends _$ArticleSaver {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<int> save({
    required String title,
    required String content,
    required String sourceUrl,
  }) async {
    state = const AsyncLoading();
    final isar = await ref.read(isarProvider.future);
    final dto = SavedArticleDto()
      ..title = title
      ..content = content
      ..sourceUrl = sourceUrl
      ..dateAdded = DateTime.now().toIso8601String()
      ..wordCount = content.split(RegExp(r'\s+')).length
      ..lastSegmentIndex = 0;

    late int id;
    await isar.writeTxn(() async {
      id = await isar.savedArticleDtos.put(dto);
    });

    ref.invalidate(savedArticlesProvider);
    state = const AsyncData(null);
    return id;
  }
}

// ── Delete an article ─────────────────────────────────────────────────────────

@riverpod
class ArticleDeleter extends _$ArticleDeleter {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> delete(int id) async {
    final isar = await ref.read(isarProvider.future);
    await isar.writeTxn(() async {
      await isar.savedArticleDtos.delete(id);
    });
    ref.invalidate(savedArticlesProvider);
  }
}

// ── Update reading progress ───────────────────────────────────────────────────

@riverpod
Future<void> updateProgress(
    UpdateProgressRef ref, {
      required int articleId,
      required int segmentIndex,
    }) async {
  final isar = await ref.read(isarProvider.future);
  await isar.writeTxn(() async {
    final dto = await isar.savedArticleDtos.get(articleId);
    if (dto != null) {
      dto.lastSegmentIndex = segmentIndex;
      await isar.savedArticleDtos.put(dto);
    }
  });
}