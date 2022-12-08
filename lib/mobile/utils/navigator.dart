import 'dart:io';

import 'package:flemis/mobile/models/user.dart';
import 'package:flemis/mobile/ui/screens/camera/camera_screen.dart';
import 'package:flemis/mobile/ui/screens/chat/message/message_screen.dart';
import 'package:flemis/mobile/ui/screens/login/mobile_login_screen.dart';
import 'package:flemis/mobile/ui/screens/post/create/create_post_screen.dart';
import 'package:flemis/mobile/ui/screens/post/create/create_post_screen_forms.dart';
import 'package:flemis/mobile/ui/screens/post/view/post_screen.dart';
import 'package:flemis/mobile/ui/screens/profile/edit/mobile_edit_profile_screen.dart';
import 'package:flemis/mobile/ui/screens/profile/profile_screen.dart';
import 'package:flemis/mobile/ui/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../models/post.dart';

class AppNavigator {
  AppNavigator({required this.context});
  final BuildContext context;

  goToBase() {
    Navigator.of(context).pushReplacementNamed("/base");
  }

  goToRegister() {
    Navigator.of(context).pushReplacementNamed("/register");
  }

  goToLogin({bool isAnimated = false}) {
    if (!isAnimated) {
      //Navigator.of(context).pushReplacementNamed("/login");
      customPageTransitionReplacement(const MobileLoginScreen());
    } else {
      customPageTransition(const MobileLoginScreen());
    }
  }

  goToEditProfile({User? user}) {
    //Navigator.of(context).pushNamed("/edit");
    customPageTransition(const MobileEditProfileScreen());
  }

  goToProfile(
      {User? user, bool isYourProfile = false, bool isAnimated = false}) {
    if (user != null && !isYourProfile || isAnimated) {
      customPageTransition(ProfileScreen(
        isYourProfile: !isYourProfile,
        user: user,
      ));
    } else {
      Navigator.of(context).pushNamed("/profile");
    }
  }

  goToSettings({bool isAnimated = false}) {
    if (!isAnimated) {
      Navigator.of(context).pushReplacementNamed("/settings");
    } else {
      customPageTransition(const SettingsScreen());
    }
  }

  goToCreatePostForm({File? file, bool isAnimated = false}) {
    if (!isAnimated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CreatePostScreenForms(file: file),
        ),
      );
    } else {
      customPageTransition(CreatePostScreenForms(file: file));
    }
  }

  goToPostScreen({Post? post, bool isAnimated = false, User? user}) {
    if (!isAnimated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostScreen(
            post: post,
            user: user,
          ),
        ),
      );
    } else {
      customPageTransition(PostScreen(
        post: post,
        user: user,
      ));
    }
  }

  backPage() {
    Navigator.of(context).pop({false});
  }

  goToCreatePost() {
    // Navigator.of(context).pushNamed("/createPost");
    customPageTransition(const CreatePostScreen());
  }

  goToCameraScreen() {
    customPageTransition(const CameraScreen());
  }

  goToMessageScreen({Chat? chat, User? to}) {
    //Navigator.of(context).pushNamed("/chat");
    customPageTransition(MessageScreen(chat: chat, to: to));
  }

  customPageTransition(Widget widget) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        maintainState: false,
        opaque: false,
        fullscreenDialog: true,
        pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) =>
            widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            ScaleTransition(
          scale: animation,
          //opacity: animation,
          child: child,
        ),
      ),
    );
  }

  customPageTransitionReplacement(Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        maintainState: false,
        opaque: false,
        fullscreenDialog: true,
        pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) =>
            widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            ScaleTransition(
          scale: animation,
          //opacity: animation,
          child: child,
        ),
      ),
      ((route) => false),
    );
  }
}
