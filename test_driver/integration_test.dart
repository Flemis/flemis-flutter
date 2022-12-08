import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
/* outra forma de fazer o integration test mais completo */
/* 
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final FlutterDriver driver = await FlutterDriver.connect();
  await integrationDriver(
    driver: driver,
    onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
      // Return false if the screenshot is invalid.
      return true;
    },
  );
} */