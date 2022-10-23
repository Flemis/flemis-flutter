import 'dart:convert';

import '../data/mobile_db.dart';

class AppVersionRepository {
  Future<void> save(String appVersion) async {
    await DatabaseMobile.save(json.encode(appVersion), "app-version");
  }
}
