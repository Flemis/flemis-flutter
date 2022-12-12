import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/repository/user_repository.dart';
import 'package:flemis/mobile/services/auth_service.dart';
import 'package:flemis/mobile/ui/widgets/components/alerts/error_alert.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/widgets/components/alerts/loading_alert.dart';

class AuthController {
  AuthController({this.context});
  final BuildContext? context;
  AuthService authService = AuthService();
  TextEditingController userNameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController firstNameController = TextEditingController(text: "");
  UserRepository userRepository = UserRepository();

  Future<void> login(String username, String password) async {
    AppNavigator navigator = AppNavigator(context: context!);
    Manager manager = context!.read<Manager>();
    LoadingAlert.showAlert(context!);
    await authService.login({
      username.contains("@") && username.contains(".com")
          ? "email"
          : "username": username,
      "password": password
    }).catchError((error, stack) {
      return error;
    }).then((serviceResponse) async {
      if (serviceResponse.status >= 200 && serviceResponse.status <= 299) {
        userNameController.clear();
        passwordController.clear();
        manager.user = serviceResponse.result;
        await userRepository.save(manager.user!);
        LoadingAlert.close(context: context!);
        navigator.goToBase();
      } else {
        userNameController.clear();
        passwordController.clear();
        LoadingAlert.close(context: context!);
        ErrorAlert.showAlert(context!,
            serviceResponse.message ?? "Error while trying to log in");

        Future.delayed(const Duration(seconds: 2), () {
          return ErrorAlert.close(context: context!);
        });
      }
    });
  }

  Future<void> register(Map<String, dynamic> body) async {
    Manager manager = context!.read<Manager>();
    AppNavigator navigator = AppNavigator(context: context!);

    LoadingAlert.showAlert(context!);
    await authService.register(body).catchError((error, stack) {
      return error;
    }).then((serviceResponse) async {
      if (serviceResponse.status >= 200 && serviceResponse.status <= 299) {
        userNameController.clear();
        emailController.clear();
        firstNameController.clear();
        lastNameController.clear();
        passwordController.clear();
        manager.user = serviceResponse.result;
        await userRepository.save(manager.user!);
        LoadingAlert.close(context: context!);
        navigator.goToBase();
      } else {
        userNameController.clear();
        emailController.clear();
        firstNameController.clear();
        lastNameController.clear();
        passwordController.clear();
        LoadingAlert.close(context: context!);
        ErrorAlert.showAlert(context!,
            serviceResponse.message ?? "Error while trying to register");
        Future.delayed(const Duration(seconds: 2), () {
          return ErrorAlert.close(context: context!);
        });
      }
    });
  }
}
