// lib/features/web_scraper/presentation/screens/add_url_screen.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../providers/scraper_providers.dart';

class AddUrlScreen extends ConsumerStatefulWidget {
  const AddUrlScreen({super.key});

  @override
  ConsumerState<AddUrlScreen> createState() => _AddUrlScreenState();
}

class _AddUrlScreenState extends ConsumerState<AddUrlScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _friendlyError(Object e) {
    final msg = e.toString();
    if (msg.contains('JavaScript') || msg.contains('block bots')) {
      return 'Nie udało się pobrać treści. Ta strona może wymagać JavaScript lub blokować boty.';
    }
    if (msg.contains('HTTP')) {
      return 'Nie udało się pobrać strony (błąd HTTP).';
    }
    if (msg.contains('empty')) {
      return 'Strona zwróciła pustą treść.';
    }
    return 'Nie udało się pobrać i zapisać artykułu.';
  }

  Future<void> _fetch() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final articleId = await ref
          .read(fetchAndSaveArticleUseCaseProvider.notifier)
          .fetchAndSave(_controller.text.trim());

      if (mounted) {
        context.pushReplacement(
          '${AppRoutes.player}?articleId=$articleId',
        );
      }
    } catch (e) {
      setState(() => _errorMessage = _friendlyError(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Article')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Paste a URL',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'OpenReader will fetch the article text and save it to your library.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.url,
                autofocus: true,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'https://example.com/article',
                  prefixIcon: const Icon(Icons.link_rounded),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _controller.clear()),
                  )
                      : null,
                ),
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a URL';
                  }
                  final uri = Uri.tryParse(value.trim());
                  if (uri == null ||
                      (!uri.scheme.startsWith('http'))) {
                    return 'Please enter a valid URL starting with http(s)://';
                  }
                  return null;
                },
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          color: theme.colorScheme.onErrorContainer,
                          size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _isLoading ? null : _fetch,
                icon: _isLoading
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.download_rounded),
                label: Text(_isLoading ? 'Fetching…' : 'Fetch & Save'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}