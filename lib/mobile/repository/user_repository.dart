import 'dart:convert';

import 'package:flemis/mobile/data/mobile_db.dart';
import 'package:idb_shim/idb.dart';

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

  Future<void> delete() async {
    await DatabaseMobile.delete("user");
  }

  Future<void> updateUserLocally(User user) async {
    await delete();
    await save(user);
    print("refreshed");
  }
}
