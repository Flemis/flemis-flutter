import 'dart:async';

import 'package:flemis/mobile/services/post_service.dart';
import 'package:flutter/material.dart';

class PostController {
  PostController({this.context});
  final BuildContext? context;

  PostService services = PostService();

  Future<dynamic> getFeed(String userId) async {
    await services.fetchFeed(userId).catchError((error, stackTrace) {
      return error;
    }).then((response) async {
      if (response.status >= 200 && response.status <= 299) {
        return response.result;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }
}
