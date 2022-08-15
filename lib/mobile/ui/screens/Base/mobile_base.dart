import 'dart:io';

import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/ui/screens/home/mobile_home.dart';
import 'package:flemis/mobile/ui/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MobileBase extends StatefulWidget {
  const MobileBase({Key? key}) : super(key: key);

  @override
  State<MobileBase> createState() => _MobileBaseState();
}

class _MobileBaseState extends State<MobileBase> {
  List<Widget> screens = <Widget>[
    const SplashScreen(),
    const SplashScreen(),
    const MobileHome(),
    const SplashScreen(),
    const SplashScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    Manager manager = context.watch<Manager>();

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        toolbarHeight: Platform.isAndroid ? 110 : 100,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            if (Platform.isAndroid)
              SizedBox(
                height: screenSize.height * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Logo",
                        style: primaryFontStyle[2],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Fernandosini",
                        style: primaryFontStyle[4],
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                height: screenSize.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Logo",
                        style: primaryFontStyle[2],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Fernandosini",
                        style: primaryFontStyle[4],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        actions: [
          if (Platform.isAndroid)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Icon(
                    Icons.notifications_none,
                    size: 40,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            )
          else
            Icon(
              Icons.notifications_none,
              size: 40,
              color: Theme.of(context).colorScheme.surface,
            ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: screens[manager.currentPage.value],
      backgroundColor: primaryColor,
      bottomNavigationBar: Platform.isIOS || Platform.isMacOS
          ? SizedBox(
              child: BottomAppBar(
                elevation: 0,
                color: transparentColor,
                child: ClipRRect(
                  child: CupertinoTabBar(
                    onTap: (value) => manager.setCurrentPage(value),
                    backgroundColor: transparentColor,
                    currentIndex: manager.currentPage.value,
                    activeColor: secondaryColor,
                    inactiveColor: whiteColor,
                    items: const [
                      BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesome5.comments,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: FaIcon(
                          FontAwesome5.comments,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.explore,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: Icon(
                          Icons.explore,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          FontAwesomeIcons.house,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: Icon(
                          FontAwesomeIcons.house,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesome5.play_circle,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: FaIcon(
                          FontAwesome5.play_circle,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          FontAwesome5.user_circle,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: Icon(
                          FontAwesome5.user_circle,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : BottomAppBar(
              elevation: 0,
              color: transparentColor,
              child: ClipRRect(
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  onTap: (value) => manager.setCurrentPage(value),
                  backgroundColor: transparentColor,
                  currentIndex: manager.currentPage.value,
                  selectedItemColor: secondaryColor,
                  unselectedItemColor: whiteColor,
                  items: const [
                    BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesome5.comments,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: FaIcon(
                          FontAwesome5.comments,
                          color: secondaryColor,
                          size: 30,
                        ),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.explore,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: Icon(
                          Icons.explore,
                          color: secondaryColor,
                          size: 30,
                        ),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(
                          FontAwesomeIcons.house,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: Icon(
                          FontAwesomeIcons.house,
                          color: secondaryColor,
                          size: 30,
                        ),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesome5.play_circle,
                          color: whiteColor,
                          size: 30,
                        ),
                        activeIcon: FaIcon(
                          FontAwesome5.play_circle,
                          color: secondaryColor,
                          size: 30,
                        ),
                        label: ""),
                    BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesome5.user_circle,
                        color: whiteColor,
                        size: 30,
                      ),
                      activeIcon: Icon(
                        FontAwesome5.user_circle,
                        color: secondaryColor,
                        size: 30,
                      ),
                      label: "",
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
