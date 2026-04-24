// lib/features/web_scraper/presentation/screens/add_url_screen.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/router/app_router.dart';
import '../../../library/presentation/providers/library_providers.dart';
import '../../data/datasources/html_fetcher.dart';

part 'add_url_screen.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PROVIDER
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class UrlScraper extends _$UrlScraper {
  @override
  AsyncValue<ScrapedContent?> build() => const AsyncData(null);

  Future<void> scrape(String url) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () async => const HtmlFetcher().fetch(url),
    );
  }

  void reset() => state = const AsyncData(null);
}

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class AddUrlScreen extends ConsumerStatefulWidget {
  const AddUrlScreen({super.key});

  @override
  ConsumerState<AddUrlScreen> createState() => _AddUrlScreenState();
}

class _AddUrlScreenState extends ConsumerState<AddUrlScreen> {
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _urlController.dispose();
    ref.read(urlScraperProvider.notifier).reset();
    super.dispose();
  }

  Future<void> _onFetch() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref
        .read(urlScraperProvider.notifier)
        .scrape(_urlController.text.trim());
  }

  Future<void> _onSaveAndRead(ScrapedContent content) async {
    final articleId = await ref.read(articleSaverProvider.notifier).save(
      title: content.title,
      content: content.plainText,
      sourceUrl: content.sourceUrl,
    );

    if (!mounted) return;
    context.go('${AppRoutes.player}?articleId=$articleId');
  }

  @override
  Widget build(BuildContext context) {
    final scraperState = ref.watch(urlScraperProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Article')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── URL field ─────────────────────────────────────────────────
              TextFormField(
                controller: _urlController,
                keyboardType: TextInputType.url,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Article URL',
                  hintText: 'https://example.com/article',
                  prefixIcon: const Icon(Icons.link),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: _urlController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _urlController.clear();
                      ref
                          .read(urlScraperProvider.notifier)
                          .reset();
                      setState(() {});
                    },
                  )
                      : null,
                ),
                onChanged: (_) => setState(() {}),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Please enter a URL';
                  }
                  final uri = Uri.tryParse(v.trim());
                  if (uri == null || !uri.hasScheme) {
                    return 'Enter a valid URL starting with https://';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Fetch button ──────────────────────────────────────────────
              FilledButton.icon(
                onPressed:
                scraperState.isLoading ? null : _onFetch,
                icon: scraperState.isLoading
                    ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
                    : const Icon(Icons.download_outlined),
                label: Text(scraperState.isLoading
                    ? 'Fetching…'
                    : 'Fetch Article'),
              ),

              const SizedBox(height: 24),

              // ── Result ────────────────────────────────────────────────────
              scraperState.when(
                loading: () => const SizedBox.shrink(),
                error: (e, _) => _ErrorCard(message: e.toString()),
                data: (content) => content == null
                    ? const SizedBox.shrink()
                    : _PreviewCard(
                  content: content,
                  onSaveAndRead: () => _onSaveAndRead(content),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({
    required this.content,
    required this.onSaveAndRead,
  });

  final ScrapedContent content;
  final VoidCallback onSaveAndRead;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final words = content.plainText.split(RegExp(r'\s+')).length;
    final readMins = (words / 200).ceil();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.green),
                const SizedBox(width: 8),
                Text('Article found',
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content.title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              '$words words · ~$readMins min read',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              // Show a snippet
              content.plainText.length > 180
                  ? '${content.plainText.substring(0, 180)}…'
                  : content.plainText,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onSaveAndRead,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Save & Read Aloud'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.error_outline,
                color: theme.colorScheme.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message.replaceAll('ScraperException: ', ''),
                style: TextStyle(
                    color: theme.colorScheme.onErrorContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}