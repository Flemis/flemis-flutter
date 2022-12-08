import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flemis/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (WidgetTester tester) async {
      await app.main();

      await tester.pumpAndSettle();

      // Verifies that the counter starts at 0.

      expect(find.text('0'), findsOneWidget);

      // Finds the floating action button to tap on.

      final Finder fab = find.byTooltip('Increment');

      // Emulates a tap on the floating action button.

      await tester.tap(fab);

      // Triggers a frame.

      await tester.pumpAndSettle();

      // Verifies if the counter increments by 1.

      expect(find.text('1'), findsOneWidget);
    });
  });
}
/* alternativa de forma mais completa */

/* 
void main() {
  final IntegrationTestWidgetsFlutterBinding binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Take a screenshot.
    await binding.takeScreenshot('platform_name');

    // Verify that platform is retrieved.
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.data!
                .startsWith('Platform: ${html.window.navigator.platform}\n'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('verify screenshot', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Multiple methods can take screenshots. Screenshots are taken with the
    // same order the methods run.
    await binding.takeScreenshot('platform_name_2');
  });
}



 */
