import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

class ReadabilityParser {
  static const _blockTags = {
    'p',
    'div',
    'article',
    'section',
    'h1',
    'h2',
    'h3',
    'h4',
    'h5',
    'h6',
    'li',
    'td',
    'blockquote',
    'pre',
  };

  static const _noiseTags = {
    'script',
    'style',
    'nav',
    'header',
    'footer',
    'aside',
    'form',
    'button',
    'iframe',
    'figure',
    'figcaption',
    'advertisement',
    'ad',
  };

  static const _noiseClasses = {
    'nav',
    'menu',
    'sidebar',
    'footer',
    'header',
    'ad',
    'advertisement',
    'cookie',
    'popup',
    'modal',
    'banner',
    'related',
    'share',
    'social',
    'comment',
    'newsletter',
  };

  static const _preferredContentSelectors = [
    'article',
    'main',
    '[role="main"]',
    '.entry-content',
    '.post-content',
    '.chapter-content',
    '.chapter-body',
    '.reading-content',
    '#chapter-content',
    '#content',
    '.content',
  ];

  (String title, String body) parse(String rawHtml) {
    final doc = html_parser.parse(rawHtml);

    final title = _extractTitle(doc);
    _removeNoise(doc);

    final candidate = _findContentNode(doc);
    final root = candidate ?? doc.body ?? doc.documentElement;
    if (root == null) {
      throw Exception('Could not parse HTML document body.');
    }

    var text = _extractText(root);
    if (text.length < 300) {
      final fallback = _extractFromParagraphs(doc);
      if (fallback.length > text.length) {
        text = fallback;
      }
    }

    final normalized = text.trim();
    if (normalized.length < 120) {
      throw Exception(
        'Could not extract article content. The page may require JavaScript or block bots.',
      );
    }

    return (title, normalized);
  }

  String _extractTitle(Document doc) {
    final ogTitle =
        doc.querySelector('meta[property="og:title"]')?.attributes['content'];
    if (ogTitle != null && ogTitle.trim().isNotEmpty) return ogTitle.trim();

    final titleTag = doc.querySelector('title')?.text;
    if (titleTag != null && titleTag.trim().isNotEmpty) {
      return titleTag.split(RegExp(r'[|\-–—]')).first.trim();
    }

    return doc.querySelector('h1')?.text.trim() ?? 'Untitled';
  }

  void _removeNoise(Document doc) {
    for (final tag in _noiseTags) {
      for (final el in doc.querySelectorAll(tag)) {
        el.remove();
      }
    }

    for (final el in doc.querySelectorAll('[class],[id]')) {
      final combined =
          '${el.attributes['class'] ?? ''} ${el.attributes['id'] ?? ''}'
              .toLowerCase();
      if (_noiseClasses.any((n) => combined.contains(n))) {
        el.remove();
      }
    }
  }

  Element? _findContentNode(Document doc) {
    for (final selector in _preferredContentSelectors) {
      final el = doc.querySelector(selector);
      if (el == null) continue;
      final t = el.text.trim();
      if (t.length >= 200) return el;
    }

    Element? bestEl;
    int bestScore = 0;

    for (final el in doc.querySelectorAll('div,section')) {
      final text = el.text.trim();
      if (text.isEmpty) continue;
      final wordCount = text.split(RegExp(r'\s+')).length;
      final linkDensity = _linkDensity(el, text.length);
      final score = (wordCount * (1 - linkDensity)).round();
      if (score > bestScore) {
        bestScore = score;
        bestEl = el;
      }
    }

    return bestScore > 60 ? bestEl : null;
  }

  double _linkDensity(Element el, int totalLen) {
    if (totalLen == 0) return 0;
    final linkTextLen = el
        .querySelectorAll('a')
        .map((a) => a.text.length)
        .fold<int>(0, (a, b) => a + b);
    return linkTextLen / totalLen;
  }

  String _extractFromParagraphs(Document doc) {
    final paragraphs = doc
        .querySelectorAll('p')
        .map((p) => p.text.replaceAll(RegExp(r'\s+'), ' ').trim())
        .where((t) => t.length > 40)
        .toList();

    return paragraphs.join('\n\n').trim();
  }

  String _extractText(Element root) {
    final buffer = StringBuffer();
    _walk(root, buffer);
    return buffer.toString().replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
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