import 'html_fetcher.dart';
import 'readability_parser.dart';
import 'webview_fetcher.dart';

/// Tries a fast HTTP fetch first; falls back to a headless WebView when the
/// HTTP response has too little extractable content (JS-rendered pages) or
/// when the server rejects the plain HTTP request outright.
class SmartFetcher {
  Future<String> fetch(String url) async {
    try {
      final html = await HtmlFetcher().fetch(url);
      final (_, body) = ReadabilityParser().parse(html);
      // 300-char threshold: below this the content is likely a shell page
      // with no real article text (e.g. a JS-only SPA or a bot-detection wall).
      if (body.length >= 300) return html;
    } catch (_) {
      // HTTP fetch failed or parser found too little content — fall through.
    }
    return WebViewFetcher().fetch(url);
  }
}