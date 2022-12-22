import 'package:flemis/mobile/models/api_response.dart';
import 'package:flemis/mobile/services/default_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/post.dart';

class PostService extends DefaultService {
  Future<APIResponse> fetchFeed(Map<String, dynamic> body) async {
    String url = "${DefaultService.envUrl}/posts/following";
    try {
      final response = await super.post(url, body: body);
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

  Future<APIResponse> fetchRandom() async {
    String url = "${DefaultService.envUrl}/posts/random";
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

  Future<dynamic> createPost(Post post, Map<String, dynamic>? file) async {
    String url = "${DefaultService.envUrl}/post/create";
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(url),
      );

      if (post.toJson().isNotEmpty) {
        Map<String, String> data = post.toMapCreate().map(
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

      final response = await super.multiPartForm(url, request);
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
        message: "Error while trying to create post!",
      );
    }
  }

  Future<dynamic> likePost(Map<String, dynamic> body) async {
    String url = "${DefaultService.envUrl}/post/like";
    try {
      final response = await super.put(url, body: body);
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
        message: "Error while trying to like this post. Please, try again!",
      );
    }
  }

  Future<dynamic> unlikePost(Map<String, dynamic> body) async {
    String url = "${DefaultService.envUrl}/post/unlike";
    try {
      final response = await super.put(url, body: body);
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
        message: "Error while trying to like this post. Please, try again!",
      );
    }
  }

  Future<APIResponse> addComment(Map<String, dynamic> body) async {
    String url = "${DefaultService.envUrl}/post/add/comment";
    try {
      final response = await super.put(url, body: body);
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
        message: "Error while trying add coment to post. Please, try again!",
      );
    }
  }

  Future<APIResponse> deleteComment(Map<String, dynamic> body) async {
    String url = "${DefaultService.envUrl}/post/add/comment";
    try {
      final response = await super.put(url, body: body);
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
        message: "Error while trying add coment to post. Please, try again!",
      );
    }
  }
}
