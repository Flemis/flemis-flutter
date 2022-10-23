import 'dart:convert';

import 'package:flemis/mobile/data/mobile_db.dart';

import '../models/user.dart';

class UserRepository {
  Future<void> save(User user) async {
    await DatabaseMobile.save(json.encode(user.toJson()), "user");
  }

  Future<User?> read() async {
    if (await DatabaseMobile.getByKey("user") != null) {
      String? data = await json.decode(await DatabaseMobile.getByKey("user"));
      if (data == null || data.isEmpty) return null;
      return User.fromJson(data);
    } else {
      return null;
    }
  }
}
