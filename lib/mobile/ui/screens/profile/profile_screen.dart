import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flemis/mobile/controller/account_controller.dart';
import 'package:flemis/mobile/models/user.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/repository/user_repository.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../controller/user_controller.dart';
import '../../../providers/manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.user, this.isYourProfile = false})
      : super(key: key);
  final bool isYourProfile;
  final User? user;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ValueNotifier<bool> resetCache = ValueNotifier<bool>(false);
  AppNavigator? navigator;
  Manager? manager;
  AccountController? accountController;
  UserController? _userController;
  final UserRepository _repository = UserRepository();
  final analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    analytics.setCurrentScreen(screenName: "profile");
    _userController = UserController(context: context);
    accountController = AccountController(context: context);
    manager = context.read<Manager>();
    navigator = AppNavigator(context: context);
    super.initState();
  }

  Future onRefresh() async {
    resetCache.value = !resetCache.value;
    return;
  }

  _openAvatarMenu(BuildContext context, Size screenSize) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => Theme(
          data: ThemeData.dark(),
          child: CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {},
                child: const Text("Change Avatar"),
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: const Text(
                  "Remove Avatar",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: const Text("Change Background"),
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: const Text(
                  "Remove Background",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        //backgroundColor: ThemeData.dark().backgroundColor,
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) => ListView(
          children: [
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  ListTile(
                    leading: const FaIcon(
                      FontAwesome5.user_edit,
                      color: whiteColor,
                    ),
                    title: Text(
                      'Change avatar',
                      style: secondaryFontStyle[4],
                    ),
                    onTap: () => {},
                  ),
                  const Expanded(
                    child: Divider(
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Remove avatar',
                      style: secondaryFontStyle[4],
                    ),
                    onTap: () => {},
                  ),
                  const Expanded(
                    child: Divider(
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.add_photo_alternate,
                      color: whiteColor,
                    ),
                    title: Text(
                      'Change background photo',
                      style: secondaryFontStyle[4],
                    ),
                    onTap: () => {},
                  ),
                  const Expanded(
                    child: Divider(
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Remove background photo',
                      style: secondaryFontStyle[4],
                    ),
                    onTap: () => {},
                  ),
                  const Expanded(
                    child: Divider(
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.close,
                      color: whiteColor,
                    ),
                    title: Text(
                      'Cancel',
                      style: secondaryFontStyle[4],
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Divider(
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 0,
        toolbarHeight: Platform.isAndroid ? 110 : 100,
        automaticallyImplyLeading: false,
        title: Row(
          children: const [],
        ),
        leading: (widget.isYourProfile && widget.user == null) ||
                manager?.currentPage.value == 4
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
                padding: const EdgeInsets.only(left: 15),
                onPressed: () {
                  navigator?.backPage();
                },
              ),
        actions: [
          if (widget.isYourProfile)
            if (Platform.isAndroid)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(40),
                            backgroundColor: primaryColor,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 25,
                            color: whiteColor,
                          ),
                          onPressed: () async =>
                              navigator?.goToEditProfile(user: manager!.user),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(40),
                            backgroundColor: primaryColor,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.settings,
                            size: 25,
                            color: whiteColor,
                          ),
                          onPressed: () async =>
                              navigator?.goToSettings(isAnimated: true),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(40),
                            backgroundColor: primaryColor,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 25,
                            color: whiteColor,
                          ),
                          onPressed: () async =>
                              navigator?.goToEditProfile(user: manager!.user),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(40),
                            backgroundColor: primaryColor,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.settings,
                            size: 25,
                            color: whiteColor,
                          ),
                          onPressed: () async =>
                              navigator?.goToSettings(isAnimated: true),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          else
            const SizedBox(),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: resetCache,
        builder: (context, isReseted, _) {
          return FutureBuilder(
            future: !widget.isYourProfile && widget.user != null
                ? accountController?.getProfileInfo(widget.user!.id!)
                : accountController?.getProfileInfo(manager!.user!.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Loading(context: context),
                );
              }

              if (snapshot.hasData && snapshot.data != null) {
                User user = snapshot.data as User;
                ValueNotifier<User> notifierUser = ValueNotifier(user);
                return AnimationConfiguration.staggeredList(
                  position: 0,
                  child: FadeInAnimation(
                    duration: const Duration(seconds: 2),
                    curve: Curves.ease,
                    child: RefreshIndicator(
                      onRefresh: onRefresh,
                      color: secondaryColor,
                      backgroundColor: primaryColor,
                      child: SizedBox(
                        height: screenSize.height,
                        width: screenSize.width,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          child: Stack(
                            children: [
                              backgroundCover(screenSize, user),
                              backgroundCoverGradient(screenSize),
                              Container(
                                height: screenSize.height * 0.8,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _avatarWidget(context, screenSize,
                                        notifierUser, widget.isYourProfile),
                                    Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        user.username!,
                                        style: secondaryFontStyle[2],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        user.bio != null ? user.bio! : user.id!,
                                        style: secondaryFontStyle[3],
                                      ),
                                    ),
                                    _infoCard(screenSize, notifierUser),
                                    //  _memories(screenSize, user),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    snapshot.error != null
                        ? snapshot.error.toString()
                        : "no data",
                    style: const TextStyle(color: whiteColor),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _avatarWidget(BuildContext context, Size screenSize,
      ValueNotifier<User> notifier, bool isYourProfile) {
    return InkWell(
      onLongPress: () =>
          !isYourProfile ? null : _openAvatarMenu(context, screenSize),
      child: ValueListenableBuilder<User>(
          valueListenable: notifier,
          builder: (context, user, _) {
            return Row(
              mainAxisAlignment: !isYourProfile
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: !isYourProfile && widget.user != null
                  ? [
                      SizedBox(
                        width: screenSize.width >= 400
                            ? screenSize.width * 0.22
                            : screenSize.width * 0.25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 3),
                          shape: BoxShape.circle,
                        ),
                        child: user.avatarUrl != null &&
                                user.avatarUrl!.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: Image.network(
                                  user.avatarUrl!,
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          Loading(
                                    context: context,
                                  ),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset("./assets/avatar.png"),
                                  fit: BoxFit.cover,
                                ).image,
                                radius: 60,
                              )
                            : CircleAvatar(
                                backgroundImage: Image.asset(
                                  "./assets/avatar.png",
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset("./assets/avatar.png"),
                                  fit: BoxFit.cover,
                                ).image,
                                radius: 60,
                              ),
                      ),
                      Padding(
                        padding: user.followers == null ||
                                !user.followers!.any(
                                    (element) => element == manager!.user!.id!)
                            ? const EdgeInsets.only(left: 0, right: 5.0)
                            : const EdgeInsets.only(left: 5, right: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: user.followers == null ||
                                      !user.followers!.any((element) =>
                                          element == manager!.user!.id!)
                                  ? secondaryColor
                                  : primaryColor,
                              foregroundColor: user.followers == null ||
                                      !user.followers!.any((element) =>
                                          element == manager!.user!.id!)
                                  ? primaryColor
                                  : Colors.red),
                          onPressed: user.followers == null ||
                                  !user.followers!.any((element) =>
                                      element == manager!.user!.id!)
                              ? () async {
                                  notifier.value.followers
                                      ?.add(manager!.user!.id!);
                                  notifier.notifyListeners();
                                  manager?.user!.following?.add(user.id!);
                                  await _repository
                                      .updateUserLocally(manager!.user!);
                                  await _userController?.followUser(
                                      manager!.user!.id!, user.id!);
                                }
                              : () async {
                                  notifier.value.followers?.removeWhere(
                                      (element) =>
                                          element == manager?.user!.id);
                                  notifier.notifyListeners();
                                  manager?.user!.following?.removeWhere(
                                      (element) => element == user.id!);
                                  await _repository
                                      .updateUserLocally(manager!.user!);
                                  await _userController?.unfollowUser(
                                      manager!.user!.id!, user.id!);
                                },
                          child: user.followers == null ||
                                  !user.followers!.any((element) =>
                                      element == manager!.user!.id!)
                              ? const Text("Follow")
                              : const Text("Unfollow"),
                        ),
                      )
                    ]
                  : [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 3),
                          shape: BoxShape.circle,
                        ),
                        child: user.avatarUrl != null &&
                                user.avatarUrl!.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: Image.network(
                                  user.avatarUrl!,
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          Loading(
                                    context: context,
                                  ),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset("./assets/avatar.png"),
                                  fit: BoxFit.cover,
                                ).image,
                                radius: 60,
                              )
                            : CircleAvatar(
                                backgroundImage: Image.asset(
                                  "./assets/avatar.png",
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset("./assets/avatar.png"),
                                  fit: BoxFit.cover,
                                ).image,
                                radius: 60,
                              ),
                      ),
                    ],
            );
          }),
    );
  }

  Widget backgroundCoverGradient(Size screenSize) {
    return Container(
      height: screenSize.height * 0.355,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.0, 20.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            transparentColor,
            primaryColor,
          ],
        ),
      ),
    );
  }

  Widget backgroundCover(Size screenSize, User user) {
    return Container(
      height: screenSize.height * 0.35,
      decoration: BoxDecoration(
        image: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(user.avatarUrl!),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage(
                  "./assets/avatar.png",
                ),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _infoCard(screenSize, ValueNotifier<User> notifier) {
    return Container(
      height: 65,
      width: screenSize.width * 0.85,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: whiteColor, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ValueListenableBuilder<User>(
              valueListenable: notifier,
              builder: (context, user, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        user.followers == null || user.followers!.isEmpty
                            ? "-"
                            : user.followers!.length.toString(),
                        style: secondaryFontStyle[0],
                      ),
                    ),
                    Text(
                      "followers",
                      style: secondaryFontStyle[6],
                    ),
                  ],
                );
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  notifier.value.subscribers == null ||
                          notifier.value.subscribers!.isEmpty
                      ? "-"
                      : notifier.value.subscribers!.length.toString(),
                  style: secondaryFontStyle[0],
                ),
              ),
              Text(
                "subscribers",
                style: secondaryFontStyle[6],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  "-",
                  style: secondaryFontStyle[0],
                ),
              ),
              Text(
                "Posts",
                style: secondaryFontStyle[6],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _memories(Size screenSize, User user) {
    return SizedBox(
      height: 200,
      width: screenSize.width,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: screenSize.width < 390 ? 30 : 40, top: 40),
            child: Text(
              "Memories",
              style: secondaryFontStyle[8],
            ),
          ),
          SizedBox(
            height: 100,
            //padding: const EdgeInsets.only(left: 10),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                if (index >= 4 - 1) {
                  return Container(
                    height: 65,
                    width: 65,
                    margin: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: whiteColor,
                      size: 30,
                    ),
                  );
                }
                return Container(
                  padding:
                      EdgeInsets.only(left: screenSize.width < 400 ? 20 : 30),
                  child: InkWell(
                    onLongPress: () => null,
                    child: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: Image.network(
                              user.avatarUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset("./assets/avatar.png"),
                            ).image,
                            radius: 35,
                          )
                        : CircleAvatar(
                            backgroundImage: Image.asset(
                              "./assets/fernando.jpg",
                              fit: BoxFit.cover,
                            ).image,
                            radius: 35,
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
