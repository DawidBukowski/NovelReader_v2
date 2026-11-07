import 'package:flutter_test/flutter_test.dart';
import 'package:open_reader/features/web_scraper/data/datasources/html_fetcher.dart';
import 'package:open_reader/features/web_scraper/data/datasources/smart_fetcher.dart';

void main() {
  group('HtmlFetcher URL validation', () {
    test('accepts HTTP and HTTPS URLs with a host', () {
      expect(
        HtmlFetcher.validateUrl('http://example.com').scheme,
        'http',
      );
      expect(
        HtmlFetcher.validateUrl('https://example.com/article').host,
        'example.com',
      );
    });

    test('rejects malformed, non-HTTP, and hostless URLs', () {
      for (final url in [
        'not a URL',
        'ftp://example.com',
        'http://',
        'https:example.com',
      ]) {
        expect(() => HtmlFetcher.validateUrl(url), throwsArgumentError);
      }
    });

    test('SmartFetcher rejects invalid URLs before fallback', () async {
      await expectLater(
        SmartFetcher().fetch('ftp://example.com'),
        throwsArgumentError,
      );
    });

    test('HtmlFetcher rejects invalid URLs before making a request', () async {
      await expectLater(
        HtmlFetcher().fetch('not a URL'),
        throwsArgumentError,
      );
    });
  });
}
