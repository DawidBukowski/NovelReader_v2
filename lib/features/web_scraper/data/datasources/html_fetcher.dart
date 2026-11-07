import 'package:http/http.dart' as http;

class HtmlFetcher {
  static Uri validateUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null ||
        (uri.scheme.toLowerCase() != 'http' &&
            uri.scheme.toLowerCase() != 'https') ||
        uri.host.isEmpty) {
      throw ArgumentError('Invalid or non-HTTP URL: $url');
    }
    return uri;
  }

  Future<String> fetch(String url) async {
    final uri = validateUrl(url);

    final response = await http.get(
      uri,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
        'Cache-Control': 'no-cache',
      },
    ).timeout(const Duration(seconds: 20));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to fetch URL (HTTP ${response.statusCode})');
    }

    final contentType = response.headers['content-type'] ?? '';
    if (!contentType.toLowerCase().contains('text/html')) {
      throw Exception('URL did not return HTML content.');
    }

    if (response.body.trim().isEmpty) {
      throw Exception('Fetched page is empty.');
    }

    return response.body;
  }
}