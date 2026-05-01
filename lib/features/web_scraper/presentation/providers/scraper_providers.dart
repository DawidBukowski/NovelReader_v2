// lib/features/web_scraper/presentation/providers/scraper_providers.dart
// =============================================================================

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/readability_parser.dart';
import '../../data/datasources/smart_fetcher.dart';
import '../../../library/domain/entities/saved_article.dart';
import '../../../library/presentation/providers/library_providers.dart';

part 'scraper_providers.g.dart';

@riverpod
class FetchAndSaveArticleUseCase extends _$FetchAndSaveArticleUseCase {
  @override
  void build() {}

  Future<int> fetchAndSave(String url) async {
    final html = await SmartFetcher().fetch(url);
    final (title, body) = ReadabilityParser().parse(html);

    if (body.length < 100) {
      throw Exception(
        'Could not extract article content. The page may require JavaScript or block bots.',
      );
    }

    final wordCount = body.split(RegExp(r'\s+')).length;
    final article = SavedArticle(
      id: 0,
      title: title,
      sourceUrl: url,
      plainText: body,
      savedAt: DateTime.now(),
      estimatedReadMinutes: (wordCount / 200).ceil(),
    );

    final repo = await ref.read(libraryRepositoryProvider.future);
    final id = await repo.saveArticle(article);
    ref.invalidate(savedArticlesProvider);
    return id;
  }
}
