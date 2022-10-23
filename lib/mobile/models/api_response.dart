import 'dart:convert';

import 'package:flemis/mobile/models/user.dart';

class APIResponse<T> {
  String? message;
  int status;
  T? result;
  bool get statusOk => status == 200;
  APIResponse({this.message, this.status = 0, this.result});

  factory APIResponse.userFromJson(Map<String, dynamic> json, {int? status}) {
    dynamic objectReturn;
    objectReturn = json['result'] != null
        ? User.fromJson(jsonEncode(json['result']))
        : null;
    var result = APIResponse<T>(
        message: json['message'],
        status: json['status'] ?? status,
        result: objectReturn);

    return result;
  }

  factory APIResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    var result = APIResponse<T>(
        message: json['message'],
        status: json['status'] ?? statusCode,
        result: json['result']);
    return result;
  }
}
