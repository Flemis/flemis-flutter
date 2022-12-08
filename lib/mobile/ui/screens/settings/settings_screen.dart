import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flemis/mobile/controller/account_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AccountController? accountController;
  final analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    accountController = AccountController(context: context);
    analytics.setCurrentScreen(screenName: "settings");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppNavigator appNavigator = AppNavigator(context: context);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Settings",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => appNavigator.backPage(),
        ),
      ),
      backgroundColor: primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                child: const Text(
                  "Logout",
                ),
                onPressed: () async => await accountController?.logout(),
              ),
              TextButton(
                child: Text(
                  "Delete Account",
                  style: errorStyle,
                ),
                onPressed: () async => await accountController?.logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(Size screenSize) {
    return Container();
  }
}
