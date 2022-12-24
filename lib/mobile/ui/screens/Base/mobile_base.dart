import 'dart:io';

import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/ui/screens/chat/chat_list_screen.dart';
import 'package:flemis/mobile/ui/screens/explore/explore_screen.dart';
import 'package:flemis/mobile/ui/screens/flemis/flemis_screen.dart';
import 'package:flemis/mobile/ui/screens/home/mobile_home.dart';
import 'package:flemis/mobile/ui/screens/profile/profile_screen.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class MobileBase extends StatefulWidget {
  const MobileBase({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  State<MobileBase> createState() => _MobileBaseState();
}

class _MobileBaseState extends State<MobileBase> {
  List<Widget>? screens;
  Manager? manager;
  PageController? pageController;
  AppNavigator? navigator;

  @override
  void initState() {
    screens = <Widget>[
      const ChatListScreen(),
      const ExploreScreen(),
      const MobileHome(),
      const FlemisScreen(),
      const ProfileScreen(
        isYourProfile: true,
      ),
    ];
    navigator = AppNavigator(context: context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    manager = context.watch<Manager>();
    pageController = PageController(initialPage: manager!.currentPage.value);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: PageView(
        physics:
            manager!.currentPage.value == 0 || manager!.currentPage.value == 4
                ? null
                : const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screens!,
        onPageChanged: (value) => manager!.setCurrentPage(value),
      ),
      backgroundColor: primaryColor,
      bottomNavigationBar: Platform.isIOS || Platform.isMacOS
          ? SizedBox(
              child: BottomAppBar(
                elevation: 0,
                color: primaryColor,
                child: ClipRRect(
                  child: CupertinoTabBar(
                    onTap: (value) {
                      manager?.setCurrentPage(value);
                      pageController?.animateToPage(manager!.currentPage.value,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    },
                    backgroundColor: primaryColor,
                    currentIndex: manager!.currentPage.value,
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
                  onTap: (value) {
                    manager?.setCurrentPage(value);
                    pageController?.animateToPage(manager!.currentPage.value,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate);
                  },
                  backgroundColor: primaryColor,
                  currentIndex: manager!.currentPage.value,
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
      floatingActionButton: manager?.currentPage.value == 2
          ? FloatingActionButton(
              backgroundColor: secondaryColor,
              /* onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CameraScreen(),
                ),
              ), */
              onPressed: () => navigator?.goToCreatePost(),
              child: const FaIcon(
                FontAwesome5.plus,
                size: 25,
                color: primaryColor,
              ),
            )
          : null,
    );
  }
}
