import 'dart:async';

import 'package:flemis/mobile/services/post_service.dart';
import 'package:flemis/mobile/ui/widgets/components/alerts/loading_alert.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../ui/widgets/components/alerts/error_alert.dart';

class PostController {
  PostController({this.context});
  final BuildContext? context;

  final _services = PostService();
  TextEditingController contentController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController locationController = TextEditingController(text: '');

  Future<dynamic> getFeed(Map<String, dynamic> body) async {
    return await _services.fetchFeed(body).catchError((error, stackTrace) {
      return error;
    }).then((response) async {
      if (response.status >= 200 && response.status <= 299) {
        List<Post> posts = [];
        for (var element in response.result) {
          posts.add(Post.fromMap(element));
        }
        return posts;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<dynamic> randomPosts() async {
    return await _services.fetchRandom().catchError((error, stackTrace) {
      return error;
    }).then((response) async {
      if (response.status >= 200 && response.status <= 299) {
        List<Post> posts = [];
        for (var element in response.result) {
          posts.add(Post.fromMap(element));
        }
        return posts;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<dynamic> likePost(Map<String, dynamic> body) async {
    await _services.likePost(body).catchError((error, stackTrace) {
      return error;
    }).then((response) async {
      if (response.status >= 200 && response.status <= 299) {
        return response.result;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<dynamic> unlikePost(Map<String, dynamic> body) async {
    await _services.unlikePost(body).catchError((error, stackTrace) {
      return error;
    }).then((response) async {
      if (response.status >= 200 && response.status <= 299) {
        return response.result;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<void> createPost(Post post, {Map<String, dynamic>? file}) async {
    AppNavigator navigator = AppNavigator(context: context!);
    LoadingAlert.showAlert(context!);
    await _services.createPost(post, file).catchError((error, stack) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
        descriptionController.clear();
        contentController.clear();
        locationController.clear();
        //return response.result;
        LoadingAlert.close(context: context!);
        navigator.goToBase();
      } else {
        LoadingAlert.close(context: context!);
        //return Future.error(response.message.toString());
        descriptionController.clear();
        contentController.clear();
        locationController.clear();
        ErrorAlert.showAlert(context!, response.message!);
        Future.delayed(const Duration(seconds: 2), () {
          return ErrorAlert.close(context: context!);
        });
      }
    });
  }

  Future<void> addComment(Map<String, dynamic> body) async {
    await _services.addComment(body).catchError((error, stack) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
        //return response.result;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<void> deleteComment(Map<String, dynamic> body) async {
    await _services.deleteComment(body).catchError((error, stack) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
      } else {
        return Future.error(response.message.toString());
      }
    });
  }
}
