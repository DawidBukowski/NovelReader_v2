import 'dart:io';

import 'package:http/http.dart' as http;

class HtmlFetcher {
  static Uri validateUrl(String url) {
    final trimmedUrl = url.trim();
    final uri = Uri.tryParse(trimmedUrl);
    if (uri == null ||
        (uri.scheme.toLowerCase() != 'http' &&
            uri.scheme.toLowerCase() != 'https') ||
        uri.host.isEmpty ||
        _isNonPublicIpAddress(uri.host)) {
      throw ArgumentError(
        'URL must use HTTP(S), include a host, and not target a private IP.',
      );
    }
    return uri;
  }

  static bool _isNonPublicIpAddress(String host) {
    var address = host.toLowerCase();
    if (address.startsWith('[') && address.endsWith(']')) {
      address = address.substring(1, address.length - 1);
    }

    final zoneIndex = address.indexOf('%');
    if (zoneIndex != -1) address = address.substring(0, zoneIndex);
    final ipAddress = InternetAddress.tryParse(address);
    if (ipAddress == null) return false;

    final bytes = ipAddress.rawAddress;
    if (bytes.length == 4) return _isNonPublicIpv4(bytes);

    if (bytes.every((part) => part == 0) ||
        (bytes.take(15).every((part) => part == 0) && bytes.last == 1)) {
      return true;
    }
    if ((bytes[0] & 0xfe) == 0xfc ||
        ((bytes[0] & 0xff) == 0xfe && (bytes[1] & 0xc0) == 0x80)) {
      return true;
    }

    final isIpv4Mapped =
        bytes.take(10).every((part) => part == 0) &&
        bytes[10] == 0xff &&
        bytes[11] == 0xff;
    final isIpv4Compatible = bytes.take(12).every((part) => part == 0);
    if (isIpv4Mapped || isIpv4Compatible) {
      final embeddedIpv4 = bytes.sublist(12);
      return _isNonPublicIpv4(embeddedIpv4);
    }
    return false;
  }

  static bool _isNonPublicIpv4(List<int> address) {
    final first = address[0];
    final second = address[1];
    return first == 0 ||
        first == 10 ||
        first == 127 ||
        (first == 100 && second >= 64 && second <= 127) ||
        (first == 169 && second == 254) ||
        (first == 172 && second >= 16 && second <= 31) ||
        (first == 192 && second == 168);
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