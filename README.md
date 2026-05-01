TODO :
1. Polish error messages in _friendlyError (add_url_screen.dart, lines 33–41)
   All four user-facing strings are in Polish. The commit message even flags this as a known bug. Replace with English:
   String _friendlyError(Object e) {
   final msg = e.toString();
   if (msg.contains('JavaScript') || msg.contains('block bots')) {
   return 'Could not fetch content. This page may require JavaScript or block automated access.';
   }
   if (msg.contains('HTTP')) {
   return 'Failed to fetch the page (HTTP error). Please check the URL and try again.';
   }
   if (msg.contains('empty')) {
   return 'The page returned no content.';
   }
   return 'Failed to fetch and save the article. Please try a different URL.';
   }

2. Missing mounted guard in catch block (add_url_screen.dart, line 63)
   The finally block already has if (mounted), but the catch block is missing it. If the user navigates away during a slow fetch, this throws setState() called after dispose().
   } catch (e) {
   if (mounted) setState(() => _errorMessage = _friendlyError(e));
   }

  ---
Security — Fix Soon

3. No URL validation in HtmlFetcher.fetch() (html_fetcher.dart, line 5)
   Uri.parse(url) throws an unhandled FormatException on malformed URLs. More importantly, the data layer accepts any URL including http:// and private IPs. The form validator in the UI provides no protection when HtmlFetcher is called directly. Replace with:
   final uri = Uri.tryParse(url);
   if (uri == null || !uri.hasScheme || !uri.scheme.startsWith('http')) {
   throw ArgumentError('Invalid or non-HTTP URL: $url');
   }

  ---
Architecture — Fix Soon

4. Presentation layer constructs data-source objects directly
   scraper_providers.dart instantiates HtmlFetcher() and ReadabilityParser() inline. scraper_repository.dart exists but is empty. This violates Clean Architecture — providers should depend on the abstract repository interface, not concrete data-source classes. Fill in the repository interface and move the
   construction behind it (consistent with how library feature handles this).

5. Fragile string-matching in _friendlyError
   _friendlyError matches on raw exception message strings (msg.contains('HTTP')). If the wording in HtmlFetcher or ReadabilityParser ever changes, the mapping silently breaks. Define a typed exception hierarchy in the domain layer (ScraperException, HttpStatusException, etc.) and use is-checks instead.

  ---
Warnings — Fix When Convenient

6. Positional record return type in ReadabilityParser.parse()
   (String title, String body) — the positions can be accidentally swapped at the call site with no compile error. Use a named record:
   ({String title, String body}) parse(String rawHtml) { ... }

7. Noise removal could strip the main content node
   _removeNoise removes elements whose class/id matches noise keywords (e.g. related, social). If a page wraps its main content in an element with a mixed class like class="entry-content related", it gets removed before _findContentNode can find it. Guard _removeNoise to skip elements that match
   _preferredContentSelectors.

8. TimeoutException reaches the generic fallback
   A 20-second timeout will produce a TimeoutException, but none of the _friendlyError branches match it — the user sees the generic message. Add a branch or catch it in HtmlFetcher and rethrow as a domain exception.
9. unused_import w lib/features/tts_player/... — to jedyne „czyste” ostrzeżenia z ręcznego kodu.
10. surfaceVariant → surfaceContainerHighest i withOpacity → withValues() przy okazji refaktoru UI.

