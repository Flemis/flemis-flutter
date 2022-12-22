import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flemis/mobile/controller/account_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/components/loading/loading.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AccountController? accountController;
  final analytics = FirebaseAnalytics.instance;
  Manager? manager;
  AppNavigator? navigator;
  @override
  void initState() {
    accountController = AccountController(context: context);
    analytics.setCurrentScreen(screenName: "settings");
    manager = context.read<Manager>();
    navigator = AppNavigator(context: context);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AppNavigator appNavigator = AppNavigator(context: context);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          //o settings normal é sem essa fonte
          style: primaryFontStyle[7],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async =>
                        navigator?.goToEditProfile(user: manager!.user!),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (manager!.user!.avatarUrl != null)
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      manager!.user!.avatarUrl!,
                                      loadingBuilder:
                                          (context, child, loadingProgress) =>
                                              Loading(
                                        context: context,
                                      ),
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Image.asset("./assets/avatar.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              else
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "./assets/avatar.png",
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Image.asset("./assets/avatar.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    manager!.user!.username!,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text(
                                    "Edit profile",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async => navigator?.goToPrivacyScreen(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.privacy_tip,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Privacy",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async => navigator?.goToPlatformPolicy(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.policy,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Policy",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async => navigator?.goToSecurityScreen(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.lock_outline_rounded,
                                color: secondaryColor,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Security",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async => navigator?.goToNotificationSettings(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.notifications,
                                color: whiteColor,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Notifications",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async => navigator?.goToHelpScreen(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.help_center_rounded,
                                color: Colors.orange,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Help",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async => navigator?.goToAboutApp(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.info_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "About",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 15,
                  ),
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
