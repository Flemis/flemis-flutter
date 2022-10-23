import 'package:flemis/mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserController {
  UserController({this.context});
  final BuildContext? context;
  UserRepository userRepository = UserRepository();

  Future<User?> getUserFromRepo() async {
    return await userRepository.read().then((value) {
      return value;
    }).onError((error, stackTrace) {
      // print("error:" + error.toString());
      //   print("stackTrace" + stackTrace.toString());
      return null;
    }).catchError((error) {
      debugPrint("catch error: $error");
      return null;
    });
  }

  Future<void> saveCurrentData(User user) async {
    await userRepository.save(user);
  }
}
