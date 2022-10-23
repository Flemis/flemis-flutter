import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flemis/mobile/controller/default.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mobile/my_app_mobile.dart' if (dart.library.html) 'web/my_app_web.dart'
    as my_app;

List<CameraDescription>? cameras;
Future<void> main() async {
  //Get.put<DefaultController>(DefaultController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  try {
    // WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Error in fetching the cameras: $e');
  }
  runApp(const my_app.MyApp());
}
