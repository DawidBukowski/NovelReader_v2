import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:open_reader/main.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: OpenReaderApp()),
    );

    expect(find.byType(OpenReaderApp), findsOneWidget);
  });
}
