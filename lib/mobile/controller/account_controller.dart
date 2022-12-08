import 'package:flemis/mobile/data/mobile_db.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/services/user_service.dart';
import 'package:flemis/mobile/ui/widgets/components/alerts/error_alert.dart';
import 'package:flemis/mobile/ui/widgets/components/alerts/loading_alert.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

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
    final serviceResult = await userService.updateProfile(body, file: file);
    LoadingAlert.close(context: context!);

    if (serviceResult.status >= 200 && serviceResult.status <= 299) {
      userNameController!.clear();
      firstNameController!.clear();
      lastNameController!.clear();
      userBioController!.clear();
      newEmailController!.clear();
      birthdayController!.clear();
      navigator.backPage();
    } else {
      userNameController!.clear();
      firstNameController!.clear();
      lastNameController!.clear();
      userBioController!.clear();
      newEmailController!.clear();
      birthdayController!.clear();
      ErrorAlert.showAlert(context!, serviceResult.message!);
      Future.delayed(const Duration(seconds: 2), () {
        return ErrorAlert.close(context: context!);
      });
    }
  }

  Future<void> deleteAccount(String userId) async {
    Manager manager = context!.read<Manager>();
    AppNavigator navigator = AppNavigator(context: context!);
    await userService.deleteAccount(userId).catchError((error, strack) {
      return error;
    }).then((response) async {
      if (response.status >= 200 && response.status <= 299) {
        manager.user == null;
        manager.setCurrentPage(2);
        await DatabaseMobile.deleteAll();

        navigator.goToLogin();
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<void> logout() async {
    Manager manager = context!.read<Manager>();
    manager.user == null;
    manager.setCurrentPage(2);
    await DatabaseMobile.deleteAll();
    AppNavigator navigator = AppNavigator(context: context!);
    navigator.goToLogin();
  }
}
