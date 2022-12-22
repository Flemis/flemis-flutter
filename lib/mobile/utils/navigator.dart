import 'dart:io';

import 'package:flemis/mobile/controller/auth_controller.dart';
import 'package:flemis/mobile/models/user.dart';
import 'package:flemis/mobile/ui/screens/camera/camera_screen.dart';
import 'package:flemis/mobile/ui/screens/chat/message/message_screen.dart';
import 'package:flemis/mobile/ui/screens/login/mobile_login_screen.dart';
import 'package:flemis/mobile/ui/screens/post/create/create_post_screen.dart';
import 'package:flemis/mobile/ui/screens/post/create/create_post_screen_forms.dart';
import 'package:flemis/mobile/ui/screens/post/view/post_screen.dart';
import 'package:flemis/mobile/ui/screens/profile/edit/mobile_edit_profile_screen.dart';
import 'package:flemis/mobile/ui/screens/profile/profile_screen.dart';
import 'package:flemis/mobile/ui/screens/register/mobile_register_second_page.dart';
import 'package:flemis/mobile/ui/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../models/post.dart';

class AppNavigator {
  AppNavigator({required this.context});
  final BuildContext context;

  goToBase() {
    // Navigator.of(context).pushReplacementNamed("/base");
    Navigator.of(context).pushNamedAndRemoveUntil("/base", (route) => false);
  }

  goToRegister() {
    Navigator.of(context).pushNamed("/register");
  }

  goToRegisterNext(AuthController authController, {File? avatar}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MobileRegisterSecondPage(
            avatar: avatar, authController: authController),
      ),
    );
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
    return customPageTransition(const CreatePostScreen());
  }

  goToCameraScreen() async {
    return await customPageTransition(const CameraScreen());
  }

  goToPrivacyScreen() {
    Navigator.of(context).pushNamed("/privacy");
  }

  goToHelpScreen() {
    Navigator.of(context).pushNamed("/help");
  }

  goToSecurityScreen() {
    Navigator.of(context).pushNamed("/security");
  }

  goToNotificationSettings() {
    Navigator.of(context).pushNamed("/notificationsettings");
  }

  goToAboutApp() {
    Navigator.of(context).pushNamed("/aboutapp");
  }

  goToPlatformPolicy() {
    Navigator.of(context).pushNamed("/policy");
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
