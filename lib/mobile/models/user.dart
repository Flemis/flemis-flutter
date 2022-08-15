class User {
  User();

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }

  User.fromJson(Map<String, dynamic> json);
}
