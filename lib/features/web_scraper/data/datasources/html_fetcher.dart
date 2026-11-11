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

    final ipv4 = _parseIpv4(address);
    if (ipv4 != null) return _isNonPublicIpv4(ipv4);

    final zoneIndex = address.indexOf('%');
    if (zoneIndex != -1) address = address.substring(0, zoneIndex);
    final ipv6 = _parseIpv6(address);
    if (ipv6 == null) return false;

    if (ipv6.every((part) => part == 0) ||
        (ipv6.take(7).every((part) => part == 0) && ipv6.last == 1)) {
      return true;
    }
    if ((ipv6[0] & 0xfe00) == 0xfc00 || (ipv6[0] & 0xffc0) == 0xfe80) {
      return true;
    }

    final isIpv4Mapped =
        ipv6.take(5).every((part) => part == 0) && ipv6[5] == 0xffff;
    final isIpv4Compatible = ipv6.take(6).every((part) => part == 0);
    if (isIpv4Mapped || isIpv4Compatible) {
      final embeddedIpv4 = [
        ipv6[6] >> 8,
        ipv6[6] & 0xff,
        ipv6[7] >> 8,
        ipv6[7] & 0xff,
      ];
      return _isNonPublicIpv4(embeddedIpv4);
    }
    return false;
  }

  static List<int>? _parseIpv4(String host) {
    final parts = host.split('.');
    if (parts.length != 4) return null;

    final address = <int>[];
    for (final part in parts) {
      final octet = int.tryParse(part);
      if (octet == null || octet < 0 || octet > 255) return null;
      address.add(octet);
    }
    return address;
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

  static List<int>? _parseIpv6(String address) {
    if (!address.contains(':')) return null;

    var normalized = address;
    final lastColon = normalized.lastIndexOf(':');
    final ipv4Tail = normalized.substring(lastColon + 1);
    if (ipv4Tail.contains('.')) {
      final ipv4 = _parseIpv4(ipv4Tail);
      if (ipv4 == null) return null;
      final high = (ipv4[0] << 8) | ipv4[1];
      final low = (ipv4[2] << 8) | ipv4[3];
      normalized = '${normalized.substring(0, lastColon + 1)}'
          '${high.toRadixString(16)}:${low.toRadixString(16)}';
    }

    final hasCompression = normalized.contains('::');
    if (hasCompression &&
        normalized.indexOf('::') != normalized.lastIndexOf('::')) {
      return null;
    }

    final halves = normalized.split('::');
    List<int>? parseHalf(String half) {
      if (half.isEmpty) return <int>[];
      final parts = half.split(':');
      final values = <int>[];
      for (final part in parts) {
        if (part.isEmpty || part.length > 4) return null;
        final value = int.tryParse(part, radix: 16);
        if (value == null) return null;
        values.add(value);
      }
      return values;
    }

    final left = parseHalf(halves[0]);
    final right = halves.length == 2 ? parseHalf(halves[1]) : <int>[];
    if (left == null || right == null) return null;

    if (!hasCompression) {
      return left.length == 8 ? left : null;
    }

    final zeroCount = 8 - left.length - right.length;
    if (zeroCount < 1) return null;
    return [...left, ...List<int>.filled(zeroCount, 0), ...right];
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