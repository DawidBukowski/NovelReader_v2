import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:open_reader/features/web_scraper/data/datasources/html_fetcher.dart';
import 'package:open_reader/features/web_scraper/data/datasources/smart_fetcher.dart';

void main() {
  test('downloads HTML from the requested URL', () async {
    final result = await http.runWithClient(
      () => HtmlFetcher().fetch('  https://example.com/article  '),
      () => MockClient((request) async {
        expect(request.url, Uri.parse('https://example.com/article'));
        return http.Response(
          '<html><body>Article content</body></html>',
          200,
          headers: {'content-type': 'text/html; charset=utf-8'},
        );
      }),
    );

    expect(result, '<html><body>Article content</body></html>');
  });

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
      expect(
        HtmlFetcher.validateUrl('  https://example.com/article  ').host,
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

    test('rejects private and local IP addresses', () {
      for (final url in [
        'http://10.0.0.1',
        'http://172.16.0.1',
        'http://192.168.1.1',
        'http://127.0.0.1',
        'http://169.254.1.1',
        'http://[::1]',
        'http://[::]',
        'http://[fc00::1]',
        'http://[fe80::1]',
        'http://[::ffff:192.168.1.1]',
      ]) {
        expect(() => HtmlFetcher.validateUrl(url), throwsArgumentError);
      }
    });

    test('SmartFetcher rejects invalid URLs before fallback', () async {
      await expectLater(
        SmartFetcher().fetch('ftp://example.com'),
        throwsArgumentError,
      );
      await expectLater(
        SmartFetcher().fetch('http://127.0.0.1'),
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

  group('HtmlFetcher response handling', () {
    for (final statusCode in [404, 500]) {
      test('throws for HTTP $statusCode', () async {
        await expectLater(
          http.runWithClient(
                () => HtmlFetcher().fetch('https://example.com/article'),
                () => MockClient(
                  (_) async => http.Response(
                '<html>Error</html>',
                statusCode,
                headers: {'content-type': 'text/html'},
              ),
            ),
          ),
          throwsA(
            isA<Exception>().having(
                  (error) => error.toString(),
              'message',
              contains('HTTP $statusCode'),
            ),
          ),
        );
      });
    }

    test('throws when the HTML response is empty', () async {
      await expectLater(
        http.runWithClient(
              () => HtmlFetcher().fetch('https://example.com/article'),
              () => MockClient(
                (_) async => http.Response(
              ' \n\t',
              200,
              headers: {'content-type': 'text/html'},
            ),
          ),
        ),
        throwsA(
          isA<Exception>().having(
                (error) => error.toString(),
            'message',
            contains('Fetched page is empty.'),
          ),
        ),
      );
    });
  });
}
