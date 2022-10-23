import 'package:flemis/mobile/services/default_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/api_response.dart';

class UserService extends DefaultService {
  Future<APIResponse> fetchProfileData(String userId) async {
    String url = "${DefaultService.envUrl}/profile/$userId";
    try {
      final response = await get(url);
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
      return APIResponse(
          status: 500,
          message: "Error while trying to make login on our services");
    }
  }

  Future<APIResponse> updateProfile(
      Map<String, dynamic> body, Map<String, dynamic>? file) async {
    String url = "${DefaultService.envUrl}/profile/edit";
    try {
      var request = http.MultipartRequest(
        "put",
        Uri.parse(url),
      );
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Methods": "GET, PUT, DELETE, POST, OPTIONS",
      };
      request.headers.addAll(headers);

      if (body.isNotEmpty) {
        request.fields.addAll(body as Map<String, String>);
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
        final parsedResponse = parseResponse(response);
        return APIResponse(
          result: parsedResponse.result,
          status: parsedResponse.status,
        );
      } else {
        final parsedReponse = parseResponse(response);
        return APIResponse(
          message: parsedReponse.message,
          status: parsedReponse.status,
          result: [],
        );
      }
    } catch (e) {
      return APIResponse(
          status: 500,
          message: "Error while trying to make login on our services");
    }
  }

  Future<void> setAppVersion(Map<String, dynamic> body) async {
    String url = "${DefaultService.envUrl}/configuration/appversion/";
    
  }

  Future<APIResponse> getAppVersion(String userId) async {
    String url = "${DefaultService.envUrl}/configuration/appversion/$userId";
    return APIResponse();
  }
}
