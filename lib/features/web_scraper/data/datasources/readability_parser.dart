// lib/features/web_scraper/data/datasources/readability_parser.dart
// A pure-Dart Readability-style article extractor using the html package.
// =============================================================================

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

class ReadabilityParser {
  static const _blockTags = {
    'p', 'div', 'article', 'section', 'h1', 'h2', 'h3',
    'h4', 'h5', 'h6', 'li', 'td', 'blockquote', 'pre',
  };

  static const _noiseTags = {
    'script', 'style', 'nav', 'header', 'footer', 'aside',
    'form', 'button', 'iframe', 'figure', 'figcaption',
    'advertisement', 'ad',
  };

  static const _noiseClasses = {
    'nav', 'menu', 'sidebar', 'footer', 'header', 'ad',
    'advertisement', 'cookie', 'popup', 'modal', 'banner',
    'related', 'share', 'social', 'comment', 'newsletter',
  };

  /// Returns a (title, plainText) tuple extracted from raw HTML.
  (String title, String body) parse(String rawHtml) {
    final doc = html_parser.parse(rawHtml);

    final title = _extractTitle(doc);
    _removeNoise(doc);

    final candidate = _findContentNode(doc);
    final text = _extractText(candidate ?? doc.body!);

    return (title, text.trim());
  }

  String _extractTitle(Document doc) {
    // Prefer <meta property="og:title"> then <title> then first <h1>.
    final ogTitle = doc
        .querySelector('meta[property="og:title"]')
        ?.attributes['content'];
    if (ogTitle != null && ogTitle.trim().isNotEmpty) return ogTitle.trim();

    final titleTag = doc.querySelector('title')?.text;
    if (titleTag != null && titleTag.trim().isNotEmpty) {
      // Strip site name suffix (e.g. "Article Title | Site Name")
      return titleTag.split(RegExp(r'[|\-–—]')).first.trim();
    }

    return doc.querySelector('h1')?.text.trim() ?? 'Untitled';
  }

  void _removeNoise(Document doc) {
    for (final tag in _noiseTags) {
      doc.querySelectorAll(tag).forEach((el) => el.remove());
    }
    // Remove elements whose class/id contains noise keywords.
    doc.querySelectorAll('[class],[id]').forEach((el) {
      final combined =
      '${el.attributes['class'] ?? ''} ${el.attributes['id'] ?? ''}'
          .toLowerCase();
      if (_noiseClasses.any((n) => combined.contains(n))) {
        el.remove();
      }
    });
  }

  /// Score block elements and pick the one with the most text content.
  Element? _findContentNode(Document doc) {
    Element? bestEl;
    int bestScore = 0;

    for (final tag in ['article', 'main', '[role="main"]']) {
      final el = doc.querySelector(tag);
      if (el != null) return el; // semantic tags win immediately
    }

    for (final el in doc.querySelectorAll('div,section')) {
      final text = el.text.trim();
      final wordCount = text.split(RegExp(r'\s+')).length;
      final linkDensity = _linkDensity(el, text.length);
      final score = (wordCount * (1 - linkDensity)).round();
      if (score > bestScore) {
        bestScore = score;
        bestEl = el;
      }
    }

    return bestScore > 100 ? bestEl : null;
  }

  double _linkDensity(Element el, int totalLen) {
    if (totalLen == 0) return 0;
    final linkText = el
        .querySelectorAll('a')
        .map((a) => a.text.length)
        .fold(0, (a, b) => a + b);
    return linkText / totalLen;
  }

  String _extractText(Element root) {
    final buffer = StringBuffer();
    _walk(root, buffer);
    // Collapse multiple blank lines into one.
    return buffer
        .toString()
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }

  void _walk(Element el, StringBuffer buf) {
    for (final node in el.nodes) {
      if (node is Text) {
        final t = node.text.replaceAll(RegExp(r'\s+'), ' ').trim();
        if (t.isNotEmpty) buf.write('$t ');
      } else if (node is Element) {
        final tag = node.localName ?? '';
        if (_blockTags.contains(tag)) {
          buf.write('\n');
          _walk(node, buf);
          buf.write('\n');
        } else {
          _walk(node, buf);
        }
      }
    }
  }
}

