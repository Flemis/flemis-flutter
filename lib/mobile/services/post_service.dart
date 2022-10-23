import 'package:flemis/mobile/models/api_response.dart';
import 'package:flemis/mobile/services/default_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostService extends DefaultService {
  Future<APIResponse> fetchFeed(String userId) async {
    String url = "${DefaultService.envUrl}/posts/$userId";
    try {
      final response = await super.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final parsedResponse = parseResponse(response);

        return APIResponse(
            status: parsedResponse.status, result: parsedResponse.result);
      } else {
        final parsedResponse = parseResponse(response);
        return APIResponse(
          status: parsedResponse.status,
          message: parsedResponse.message,
          result: [],
        );
      }
      // ignore: empty_catches
    } catch (e) {
      return APIResponse(
        status: 500,
        message: "Error while trying to load your feed. Please, try again!",
      );
    }
  }

  Future<dynamic> createPost(post, Map<String, dynamic>? file) async {
    String url = "${DefaultService.envUrl}/posts/create";
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(url),
      );
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Methods": "GET, PUT, DELETE, POST, OPTIONS",
      };
      request.headers.addAll(headers);

      if (post.toJsonV2().isNotEmpty) {
        request.fields.addAll(post.toJsonV2());
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

      final response = await super.multiPartForm(url, request);
    } catch (e) {
      return APIResponse(
        status: 500,
        message: "Error while trying to create post!",
      );
    }
  }
}
