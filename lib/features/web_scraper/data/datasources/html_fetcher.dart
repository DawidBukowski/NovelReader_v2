// lib/features/web_scraper/data/datasources/html_fetcher.dart
// =============================================================================

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

class ScrapedContent {
  const ScrapedContent({
    required this.title,
    required this.plainText,
    required this.sourceUrl,
  });
  final String title;
  final String plainText;
  final String sourceUrl;
}

class HtmlFetcher {
  const HtmlFetcher();

  /// Fetch [url] and return article title + clean plain text.
  /// Throws [ScraperException] on network or parse failure.
  Future<ScrapedContent> fetch(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      throw ScraperException('Invalid URL: $url');
    }

    late http.Response response;
    try {
      response = await http
          .get(uri, headers: {'User-Agent': 'OpenReader/1.0'})
          .timeout(const Duration(seconds: 15));
    } catch (e) {
      throw ScraperException('Network error: $e');
    }

    if (response.statusCode != 200) {
      throw ScraperException('HTTP ${response.statusCode} for $url');
    }

    final body = utf8.decode(response.bodyBytes, allowMalformed: true);
    return _parse(body, url);
  }

  ScrapedContent _parse(String html, String sourceUrl) {
    final doc = html_parser.parse(html);

    // ── Title ──────────────────────────────────────────────────────────────
    final title = _extractTitle(doc);

    // ── Readability-style content extraction ───────────────────────────────
    // 1. Remove noise elements
    for (final tag in [
      'script', 'style', 'nav', 'header', 'footer',
      'aside', 'form', 'iframe', 'noscript', 'ads',
    ]) {
      doc.querySelectorAll(tag).forEach((e) => e.remove());
    }

    // 2. Score candidate elements by text density
    final candidates = doc.querySelectorAll(
      'article, [role="main"], main, .content, .post, .article, .entry',
    );

    String plainText;

    if (candidates.isNotEmpty) {
      // Use the highest-scoring semantic container
      final best = candidates.reduce((a, b) =>
      a.text.length > b.text.length ? a : b);
      plainText = _extractText(best);
    } else {
      // Fallback: score all <p>-heavy divs
      plainText = _fallbackExtract(doc);
    }

    if (plainText.trim().isEmpty) {
      throw ScraperException('No readable content found at this URL.');
    }

    return ScrapedContent(
      title: title,
      plainText: plainText.trim(),
      sourceUrl: sourceUrl,
    );
  }

  String _extractTitle(Document doc) {
    // Try og:title → <title> → h1
    final og = doc.querySelector('meta[property="og:title"]');
    if (og != null && og.attributes['content']?.isNotEmpty == true) {
      return og.attributes['content']!;
    }
    final titleEl = doc.querySelector('title');
    if (titleEl != null && titleEl.text.isNotEmpty) {
      return titleEl.text.trim();
    }
    return doc.querySelector('h1')?.text.trim() ?? 'Untitled';
  }

  String _extractText(Element element) {
    final buffer = StringBuffer();
    for (final node in element.querySelectorAll(
      'p, h1, h2, h3, h4, h5, h6, li, blockquote',
    )) {
      final text = node.text.trim();
      if (text.length > 20) {
        buffer.writeln(text);
        buffer.writeln();
      }
    }
    return buffer.toString();
  }

  String _fallbackExtract(Document doc) {
    // Score every block element by paragraph density
    final blocks = doc.querySelectorAll('div, section, td');
    if (blocks.isEmpty) return doc.body?.text ?? '';

    final scored = blocks.map((el) {
      final pCount = el.querySelectorAll('p').length;
      final textLen = el.text.length;
      return (el: el, score: pCount * 100 + textLen);
    }).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return _extractText(scored.first.el);
  }
}

class ScraperException implements Exception {
  const ScraperException(this.message);
  final String message;

  @override
  String toString() => 'ScraperException: $message';
}