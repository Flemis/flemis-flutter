import 'package:flemis/mobile/repository/user_repository.dart';
import 'package:flemis/mobile/services/user_service.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserController {
  UserController({this.context});
  final BuildContext? context;
  UserRepository userRepository = UserRepository();
  final UserService _userService = UserService();

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

  Future<User> getUserById(String userId) async {
    return await _userService
        .fetchProfileData(userId)
        .catchError((error, stackTrace) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
        return response.result;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<void> followUser(String yourId, String otherPersonId) async {
    await _userService.followUser({
      "yourId": yourId,
      "otherPersonId": otherPersonId
    }).catchError((error, stack) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<void> unfollowUser(String yourId, String otherPersonId) async {
    await _userService.unfollowUser({
      "yourId": yourId,
      "otherPersonId": otherPersonId
    }).catchError((error, stack) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<dynamic> findUsersByUsername(String username) async {
    return await _userService
        .findUsersByUsername(username)
        .catchError((error, stack) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
        List<User> userList = [];
        response.result
            .forEach((element) => userList.add(User.fromMap(element)));
        return userList;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }
}
