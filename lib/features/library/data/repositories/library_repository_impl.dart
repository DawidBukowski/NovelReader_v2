// lib/features/library/data/repositories/library_repository_impl.dart

import 'package:isar/isar.dart';

import '../../domain/entities/saved_article.dart';
import '../../domain/repositories/library_repository.dart';
import '../models/saved_article_dto.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  const LibraryRepositoryImpl(this._isar);
  final Isar _isar;

  @override
  Future<List<SavedArticle>> getAllArticles() async {
    final dtos = await _isar.savedArticleDtos
        .where()
        .sortBySavedAtDesc()
        .findAll();
    return dtos.map((d) => d.toDomain()).toList();
  }

  @override
  Future<SavedArticle?> getArticleById(int id) async {
    final dto = await _isar.savedArticleDtos.get(id);
    return dto?.toDomain();
  }

  @override
  Future<int> saveArticle(SavedArticle article) async {
    late int id;
    await _isar.writeTxn(() async {
      id = await _isar.savedArticleDtos.put(SavedArticleDto.fromDomain(article));
    });
    return id;
  }

  @override
  Future<void> updateProgress(int id, double progress, int lastSegmentIndex) async {
    await _isar.writeTxn(() async {
      final dto = await _isar.savedArticleDtos.get(id);
      if (dto == null) return;
      dto.readProgress = progress;
      dto.lastSegmentIndex = lastSegmentIndex;
      await _isar.savedArticleDtos.put(dto);
    });
  }

  @override
  Future<void> deleteArticle(int id) async {
    await _isar.writeTxn(() async {
      await _isar.savedArticleDtos.delete(id);
    });
  }
}