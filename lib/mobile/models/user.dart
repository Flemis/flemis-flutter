import 'dart:convert';

import 'package:flemis/mobile/models/post.dart';

class User {
  User(
      {this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.password,
      this.email,
      this.token,
      this.followers,
      this.following,
      this.subscribers,
      this.links,
      this.avatarUrl,
      this.birthday,
      this.bio,
      this.createdAt,
      this.posts,
      this.subscribed,
      this.isProfilePrivate,
      this.isBanned});

  String? id;
  String? username;
  String? firstname;
  String? password;
  String? lastname;
  String? avatarUrl;
  String? bio;
  String? email;
  String? token;
  String? birthday;
  List<Post>? posts = [];
  List<String>? followers = [];
  List<String>? following = [];
  List<String>? subscribers = [];
  List<String>? subscribed = [];
  List<String>? links = [];
  DateTime? createdAt;
  bool? isProfilePrivate = false;
  bool? isBanned = false;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      username: json["username"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      email: json["email"],
      avatarUrl: json["avatarUrl"],
      bio: json["bio"],
      followers: json["followers"] != null && json["followers"] is List<dynamic>
          ? List<String>.from(json["followers"] as List<dynamic>).toList()
          : [],
      following: json["following"] != null && json["following"] is List<dynamic>
          ? List<String>.from(json["following"] as List<dynamic>).toList()
          : [],
      subscribers:
          json["subscribers"] != null && json["subscribers"] is List<dynamic>
              ? List<String>.from(json["subscribers"] as List<dynamic>).toList()
              : [],
      subscribed:
          json["subscribed"] != null && json["subscribed"] is List<dynamic>
              ? List<String>.from(json["subscribed"] as List<dynamic>).toList()
              : [],
      birthday: json["birthday"],
      password: json["password"],
      links: json["links"] != null && json["links"] is List<dynamic>
          ? List<String>.from(json["links"] as List<dynamic>)
          : [],
      token: json["token"],
      posts: json['posts'] != null && json["posts"] is List<dynamic>
          ? List<Post>.from(
              (json['posts'] as List<dynamic>).map(
                (element) => Post.fromMap(element as Map<String, dynamic>),
              ),
            )
          : [],
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"]),
      isProfilePrivate: json["isProfilePrivate"] ?? false,
      isBanned: json["isBanned"] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "bio": bio,
        "avatarUrl": avatarUrl,
        "email": email,
        "token": token,
        "followers": followers?.toList(),
        "following": following?.toList(),
        "subscribers": subscribers?.toList(),
        "subscribed": subscribed?.toList(),
        "password": password,
        "posts":
            posts?.map((e) => Post.fromJson(e.toJson())).toList().toString(),
        "createdAt": createdAt?.toIso8601String(),
        "birthday": birthday,
        "isBanned": isBanned,
        "isProfilePrivate": isProfilePrivate,
      };

  //Specific map to create User json on Create post
  Map<String, dynamic> toMapPost({bool fromLike = false}) => {
        "_id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "bio": bio,
        "avatarUrl": avatarUrl,
        "email": email,
        "followers": !fromLike ? followers?.toList() : null,
        "following": !fromLike ? following?.toList() : null,
        "subscribers": !fromLike ? subscribers?.toList() : null,
        "subscribed": !fromLike ? subscribed?.toList() : null,
        "posts": !fromLike
            ? posts?.map((e) => Post.fromMap(e.toMap())).toList()
            : null,
        "createdAt": createdAt?.toIso8601String(),
        "birthday": birthday,
        "isBanned": isBanned,
        "isProfilePrivate": isProfilePrivate,
      };

  static List<User> parseJsonToList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static String parseListToJson(List<User> users) {
    return jsonEncode(users.map((e) => User.fromJson(e.toJson())).toList());
  }
}
