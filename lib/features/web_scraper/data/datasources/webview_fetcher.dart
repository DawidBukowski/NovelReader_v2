import 'dart:async';
import 'dart:ui';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewFetcher {
  // Mobile Chrome UA — indistinguishable from a real Android browser.
  static const _userAgent =
      'Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/124.0.6367.82 Mobile Safari/537.36';

  Future<String> fetch(String url) async {
    final completer = Completer<String>();
    HeadlessInAppWebView? webView;

    webView = HeadlessInAppWebView(
      initialSize: const Size(1366, 768),
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        userAgent: _userAgent,
        mediaPlaybackRequiresUserGesture: false,
      ),
      onLoadStop: (controller, _) async {
        if (completer.isCompleted) return;
        // Extra buffer for lazy-loaded / async JS content rendering.
        await Future<void>.delayed(const Duration(milliseconds: 2500));
        if (completer.isCompleted) return;
        try {
          final html =
              (await controller.evaluateJavascript(
                source: 'document.documentElement.outerHTML',
              ))?.toString() ??
              '';
          if (html.length > 200) {
            completer.complete(html);
          } else {
            completer.completeError(
              Exception('WebView returned empty HTML content.'),
            );
          }
        } catch (e) {
          if (!completer.isCompleted) completer.completeError(e);
        }
      },
      onReceivedError: (controller, request, error) {
        // Only fail on main-frame errors; sub-resource failures are ignorable.
        if (request.isForMainFrame == true && !completer.isCompleted) {
          completer.completeError(
            Exception('Could not load page: ${error.description}'),
          );
        }
      },
    );

    try {
      await webView.run();
      return await completer.future.timeout(const Duration(seconds: 45));
    } finally {
      await webView.dispose();
    }
  }
}