import 'dart:convert';

class User {
  User({
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.email,
    this.token,
    this.followers,
    this.following,
    this.subscribers,
    this.avatarUrl,
    this.createdAt,
  });

  String? id;
  String? username;
  String? firstname;
  String? lastname;
  String? avatarUrl;
  String? email;
  String? token;
  List<String>? followers;
  List<String>? following;
  List<String>? subscribers;
  DateTime? createdAt;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        avatarUrl: json["avatarUrl"],
        followers: json["followers"],
        following: json["following"],
        subscribers: json["subscribers"],
        token: json["token"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "avatarUrl": avatarUrl,
        "email": email,
        "token": token,
        "followers": followers?.toList().toString(),
        "following": following?.toList().toString(),
        "subscribers": subscribers?.toList().toString(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
