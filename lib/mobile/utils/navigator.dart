import 'package:flemis/mobile/models/user.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator({required this.context});
  final BuildContext context;

  goToBase() {
    Navigator.of(context).pushReplacementNamed("/base");
  }

  goToRegister() {
    Navigator.of(context).pushReplacementNamed("/register");
  }

  goToLogin() {
    Navigator.of(context).pushReplacementNamed("/login");
  }

  goToEditProfile({User? user}) {
    Navigator.of(context).pushNamed("/edit");
  }

  goToProfile({User? user}) {
    Navigator.of(context).pushNamed("/profile");
  }

  backPage() {
    Navigator.of(context).pop();
  }
}
