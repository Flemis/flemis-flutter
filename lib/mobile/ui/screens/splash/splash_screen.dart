import 'dart:async';

import 'package:flemis/mobile/controller/user_controller.dart';
import 'package:flemis/mobile/data/mobile_db.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/repository/user_repository.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserController? userController;
  AppNavigator? navigator;
  UserRepository userRepository = UserRepository();
  Manager? manager;

  @override
  void initState() {
    navigator = AppNavigator(context: context);
    userController = UserController(context: context);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    manager = context.read<Manager>();
    var user = await userRepository
        .read()
        .catchError((error, stack) => null)
        .then((value) => value);

    if (user != null) {
      manager?.user = user;
      if (!JwtDecoder.isExpired(user.token!)) {
        Timer(
          const Duration(seconds: 5),
          () => navigator?.goToBase(),
        );
      } else {
        await DatabaseMobile.deleteAll();
        Timer(
          const Duration(seconds: 5),
          () => navigator?.goToLogin(),
        );
      }
    } else {
      if (!mounted) {}
      await DatabaseMobile.deleteAll();
      Timer(
        const Duration(seconds: 5),
        () => navigator?.goToLogin(),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: screenSize.height < 700 ? true : false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparentColor,
      ),
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screenSize.height < 700
                    ? screenSize.height * 0.45
                    : screenSize.height * 0.35,
              ),
              SizedBox(
                child: Text(
                  "Flemis",
                  style: primaryFontStyle[0],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
