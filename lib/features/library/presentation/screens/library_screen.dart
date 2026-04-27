// lib/features/library/presentation/screens/library_screen.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';
import '../../../library/domain/entities/saved_article.dart';
import '../providers/library_providers.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(savedArticlesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'OpenReader',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -0.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            color: theme.colorScheme.outlineVariant,
          ),
        ),
      ),
      body: articlesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(message: e.toString()),
        data: (articles) => articles.isEmpty
            ? _EmptyState(onAddTap: () => context.push(AppRoutes.addUrl))
            : _ArticleList(articles: articles),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addUrl),
        icon: const Icon(Icons.add_link_rounded),
        label: const Text('Add URL'),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ARTICLE LIST
// ─────────────────────────────────────────────────────────────────────────────

class _ArticleList extends ConsumerWidget {
  const _ArticleList({required this.articles});
  final List<SavedArticle> articles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      itemCount: articles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 0),
      itemBuilder: (context, index) {
        final article = articles[index];
        return _ArticleTile(article: article);
      },
    );
  }
}

class _ArticleTile extends ConsumerWidget {
  const _ArticleTile({required this.article});
  final SavedArticle article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('MMM d, yyyy').format(article.savedAt);

    return Slidable(
      key: ValueKey(article.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) => _confirmDelete(context, ref, article),
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            icon: Icons.delete_outline_rounded,
            label: 'Delete',
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(12),
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.push(
          '${AppRoutes.player}?articleId=${article.id}',
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator dot
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: _ProgressDot(progress: article.readProgress),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.sourceUrl.isNotEmpty
                          ? _cleanUrl(article.sourceUrl)
                          : 'Imported',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$dateStr · ${article.estimatedReadMinutes} min read',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _cleanUrl(String url) {
    return url
        .replaceFirst('https://', '')
        .replaceFirst('http://', '')
        .replaceFirst('www.', '');
  }

  Future<void> _confirmDelete(
      BuildContext context,
      WidgetRef ref,
      SavedArticle article,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete article?'),
        content: Text(
          '"${article.title}" will be permanently removed from your library.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(deleteArticleUseCaseProvider.notifier)
          .delete(article.id);
      ref.invalidate(savedArticlesProvider);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROGRESS DOT — small visual showing how far the user has read
// ─────────────────────────────────────────────────────────────────────────────

class _ProgressDot extends StatelessWidget {
  const _ProgressDot({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = progress >= 1.0
        ? theme.colorScheme.primary
        : progress > 0
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceVariant;

    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.colorScheme.outline,
          width: 1.5,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// EMPTY STATE
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAddTap});
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_stories_outlined,
              size: 72,
              color: theme.colorScheme.outlineVariant,
            ),
            const SizedBox(height: 20),
            Text(
              'Your library is empty',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Paste a URL to fetch an article and start listening with AI voices.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: onAddTap,
              icon: const Icon(Icons.add_link_rounded),
              label: const Text('Add your first article'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ERROR VIEW
// ─────────────────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}