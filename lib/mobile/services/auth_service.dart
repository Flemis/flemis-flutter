import 'package:flemis/mobile/models/api_response.dart';
import 'package:flemis/mobile/services/default_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  Future<APIResponse> register(Map<String, dynamic> body,
      {Map<String, dynamic>? file}) async {
    String url = "${DefaultService.envUrl}/register";
    try {
      var request = http.MultipartRequest(
        "post",
        Uri.parse(url),
      );

      if (body.isNotEmpty) {
        Map<String, String> data = body.map(
            (key, value) => MapEntry<String, String>(key, value.toString()));

        request.fields.addAll(data);
      }

      if (file != null && file.isNotEmpty) {
        Uint8List bytes = file["bytes"] as Uint8List;

        request.files.add(
          http.MultipartFile.fromBytes(
            "file",
            bytes,
            filename: file["fileName"],
            contentType: file["fileName"].endsWith(".jpg")
                ? MediaType("image", "jpeg")
                : MediaType("image", "png"),
          ),
        );
      }
      final response = await multiPartForm(url, request);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return parseUserResponse(response);
      } else {
        final parsedReponse = parseResponse(response);
        return APIResponse(
          message: parsedReponse.message,
          status: parsedReponse.status,
          result: [],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      return APIResponse(
          status: 500, message: "Error while trying to register user");
    }
  }
}
