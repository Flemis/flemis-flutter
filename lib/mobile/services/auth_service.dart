import 'package:flemis/mobile/models/api_response.dart';
import 'package:flemis/mobile/services/default_service.dart';
import 'package:flutter/material.dart';

class AuthService extends DefaultService {
  Future<APIResponse> login(Map<String, dynamic> body) async {
    String url = "${DefaultService.envUrl}/login";
    try {
      final response = await post(url, body: body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return parseUserResponse(response);
      } else {
        final parsedReponse = parseResponse(response);
        return APIResponse(
            message: parsedReponse.message,
            status: parsedReponse.status,
            result: []);
      }
    } catch (e) {
      return APIResponse(
          status: 500,
          message: "Error while trying to make login on our services");
    }
  }

  Future<APIResponse> register(Map<String, dynamic> body) async {
    String url = "${DefaultService.envUrl}/register";
    try {
      final response = await post(url, body: body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return parseUserResponse(response);
      } else {
        final parsedReponse = parseResponse(response);
        return APIResponse(
            message: parsedReponse.message,
            status: parsedReponse.status,
            result: []);
      }
    } catch (e) {
      debugPrint(e.toString());
      return APIResponse(
          status: 500, message: "Error while trying to register user");
    }
  }
}
