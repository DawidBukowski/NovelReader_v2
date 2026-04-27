import 'package:http/http.dart' as http;

class HtmlFetcher {
  Future<String> fetch(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      'User-Agent': 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 Chrome/120 Mobile Safari/537.36',
      'Accept': 'text/html,application/xhtml+xml',
    }).timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch URL (HTTP ${response.statusCode})');
    }
    return response.body;
  }
}