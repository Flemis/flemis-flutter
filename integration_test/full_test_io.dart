import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flemis/main.dart' as app;

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('verify text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await app.main();

    // Trace the timeline of the following operation. The timeline result will
    // be written to `build/integration_response_data.json` with the key
    // `timeline`.
    await binding.traceAction(() async {
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify that platform version is retrieved.
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Text &&
              (widget.data!
                      .startsWith('Platform: ${Platform.operatingSystem}') ||
                  widget.data!.startsWith('Platform: ${Platform.isIOS}')),
        ),
        findsOneWidget,
      );
    });
  });
}






/* alternativa ao teste de forma mais completa */
/* 


void main() {
  final IntegrationTestWidgetsFlutterBinding binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify text', (WidgetTester tester) async {
    // Build our app.
    app.main();

    // Pump a frame.
    await tester.pumpAndSettle();

    // Verify that platform version is retrieved.
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.data!.startsWith('Platform: ${Platform.operatingSystem}'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('verify screenshot', (WidgetTester tester) async {
    // Build our app.
    app.main();

    // On Android, this is required prior to taking the screenshot.
    await binding.convertFlutterSurfaceToImage();

    // Pump a frame before taking the screenshot.
    await tester.pumpAndSettle();
    final List<int> firstPng = await binding.takeScreenshot('first');
    expect(firstPng.isNotEmpty, isTrue);

    // Pump another frame before taking the screenshot.
    await tester.pumpAndSettle();
    final List<int> secondPng = await binding.takeScreenshot('second');
    expect(secondPng.isNotEmpty, isTrue);

    expect(listEquals(firstPng, secondPng), isTrue);
  });
}


 */
