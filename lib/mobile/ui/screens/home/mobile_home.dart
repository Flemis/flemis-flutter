import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flemis/mobile/controller/post_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/ui/widgets/components/post/custom_post_card.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../models/post.dart';
import '../notifications/notifications_screen.dart';

/* 
    resolver problema de requisição dupla na home
   */
class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);
  //final User? user;

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  ValueNotifier<bool> resetCache = ValueNotifier<bool>(false);
  PostController? controller;
  Manager? manager;
  Future? _future;
  final analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    super.initState();
    analytics.setCurrentScreen(screenName: "home");
    controller = PostController(context: context);
    manager = context.read<Manager>();
    _future = controller?.getFeed({
      "_id": manager!.user!.id!,
      "following": manager!.user!.following?.toList()
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  Future refresh() async {
    resetCache.value = !resetCache.value;
    _future = controller?.getFeed({
      "_id": manager!.user!.id!,
      "following": manager!.user!.following?.toList()
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        toolbarHeight: Platform.isAndroid ? 110 : 100,
        automaticallyImplyLeading: false,
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
                        "Flemis",
                        style: primaryFontStyle[2],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        manager!.user!.username!.length >= 15
                            ? manager!.user!.username!.replaceRange(
                                15, manager!.user!.username!.length, "...")
                            : manager!.user!.username! ?? "",
                        style: primaryFontStyle[7],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: screenSize.height * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Flemis",
                        style: primaryFontStyle[2],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        manager!.user!.username!.length >= 15
                            ? manager!.user!.username!.replaceRange(
                                15, manager!.user!.username!.length, "...")
                            : manager!.user!.username! ?? "",
                        style: primaryFontStyle[7],
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
                  margin: const EdgeInsets.only(top: 20),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationsScreen(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.notifications_none,
                      size: 40,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationsScreen(),
                        fullscreenDialog: true,
                      ),
                    ),
                    icon: const Icon(
                      Icons.notifications_none,
                      size: 40,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      backgroundColor: primaryColor,
      body: SizedBox(
        child: ValueListenableBuilder(
          valueListenable: resetCache,
          builder: (context, value, _) {
            return FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Loading(context: context),
                  );
                }

                if (snapshot.hasData && snapshot.data != null) {
                  return content(screenSize, snapshot.data!);
                }
                return errorWidget(screenSize, snapshot);
              },
            );
          },
        ),
      ),
    );
  }

  Widget content(Size screenSize, Object data) {
    List<Post> postList = data as List<Post>;
    return AnimationConfiguration.staggeredList(
      position: 0,
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(
          child: RefreshIndicator(
            backgroundColor: primaryColor,
            displacement: 0,
            onRefresh: refresh,
            color: secondaryColor,
            child: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 0, bottom: 100),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: postList
                      .map((e) => CustomPostCard(
                            post: e,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget errorWidget(Size screenSize, AsyncSnapshot data) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      child: FadeInAnimation(
        duration: const Duration(seconds: 2),
        curve: Curves.ease,
        child: RefreshIndicator(
          backgroundColor: primaryColor,
          displacement: 0,
          onRefresh: refresh,
          color: secondaryColor,
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 0,
              ),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: SizedBox(
                height: screenSize.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        data.error != null ? data.error.toString() : "no data",
                        style: const TextStyle(color: whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
