import 'package:flemis/mobile/data/mobile_db.dart';

class CameraRepository {
  CameraRepository();

  Future<void> save(bool isPermissionGranted) async {
    await DatabaseMobile.save(
        isPermissionGranted.toString(), "isCameraPermissionGranted");
  }

  Future<bool?> read() async {
    var permissionString =
        DatabaseMobile.getByKey("isCameraPermissionGranted")
            .toString()
            .toLowerCase();
    if (permissionString == "false" ||
        permissionString.isEmpty ||
        permissionString == "") {
      return false;
    } else if (permissionString == "true") {
      return true;
    } else {
      return false;
    }
  }
}
