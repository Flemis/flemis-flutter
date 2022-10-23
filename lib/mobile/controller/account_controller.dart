import 'package:flemis/mobile/services/user_service.dart';
import 'package:flemis/mobile/ui/widgets/components/alerts/error_alert.dart';
import 'package:flemis/mobile/ui/widgets/components/alerts/loading_alert.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../models/user.dart';

class AccountController {
  AccountController({this.context});
  final BuildContext? context;
  UserService userService = UserService();
  TextEditingController? userNameController = TextEditingController(text: "");
  TextEditingController? passwordController = TextEditingController(text: "");
  TextEditingController? firstNameController = TextEditingController(text: "");
  TextEditingController? lastNameController = TextEditingController(text: "");
  TextEditingController? userBioController = TextEditingController(text: "");
  TextEditingController? newEmailController = TextEditingController(text: "");
  TextEditingController? birthdayController =
      MaskedTextController(mask: "00/00/0000", text: "");

  Future<dynamic> getProfileInfo(String userId) async {
    return await userService
        .fetchProfileData(userId)
        .catchError((error, stacktrace) {
      return error;
    }).then((serviceResult) async {
      if (serviceResult.status >= 200 && serviceResult.status <= 299) {
        User user = serviceResult.result;
        return user;
      } else {
        return Future.error(serviceResult.message.toString());
      }
    });
  }

  Future<void> updateProfile(Map<String, dynamic> body,
      {Map<String, dynamic>? file}) async {
    AppNavigator navigator = AppNavigator(context: context!);

    LoadingAlert.showAlert(context!);
    final serviceResult = await userService.updateProfile(body, file);
    LoadingAlert.close(context: context!);
    print(serviceResult.status);
    if (serviceResult.status >= 200 && serviceResult.status <= 299) {
      userNameController!.clear();
      firstNameController!.clear();
      lastNameController!.clear();
      userBioController!.clear();
      newEmailController!.clear();
      birthdayController!.clear();
      navigator.backPage();
    } else {
      ErrorAlert.showAlert(context!, serviceResult.message!);
      userNameController!.clear();
      firstNameController!.clear();
      lastNameController!.clear();
      userBioController!.clear();
      newEmailController!.clear();
      birthdayController!.clear();
      ErrorAlert.close(context: context!);
    }
  }
}
