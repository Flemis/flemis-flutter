import 'package:flemis/mobile/data/mobile_db.dart';

class ThemeRepository {
  Future<void> saveDarkTheme(String jsonValue) async {
    await DatabaseMobile.save(jsonValue, "darkTheme");
  }

  Future<bool> readDarkTheme() async {
    var isCached = await DatabaseMobile.getByKey("darkTheme");
    if (isCached != null && isCached == "true") {
      return true;
    } else {
      return false;
    }
  }
}
