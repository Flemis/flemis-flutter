import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flemis/mobile/controller/post_controller.dart';
import 'package:flemis/mobile/models/post.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/ui/widgets/components/chat/chat_list_item.dart';
import 'package:flemis/mobile/ui/widgets/components/post/custom_post_card.dart';
import 'package:flemis/mobile/ui/widgets/components/search/custom_search_delegate.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/chat.dart';
import '../../../providers/manager.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  PostController? postController;
  final ValueNotifier<bool> resetCache = ValueNotifier<bool>(false);
  Manager? manager;
  AppNavigator? appNavigator;
  final analytics = FirebaseAnalytics.instance;

  Future? _future;
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
      query: "",
    );
  }

  @override
  void initState() {
    appNavigator = AppNavigator(context: context);
    postController = PostController(context: context);
    manager = context.read<Manager>();
    super.initState();
    _future = postController?.randomPosts();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future onRefresh() async {
    resetCache.value = !resetCache.value;
    _future = postController?.randomPosts();
    return;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        toolbarHeight: Platform.isAndroid ? 110 : 100,
        automaticallyImplyLeading: false,
        /* title: Row(
          children: [
            if (Platform.isAndroid)
              SizedBox(
                height: screenSize.height * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Explore",
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
              SizedBox(
                height: screenSize.height * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Explore",
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
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: IconButton(
                        icon: const FaIcon(
                          FontAwesome5.search,
                          size: 25,
                          color: whiteColor,
                        ),
                        onPressed: () async => await _showSearch(),
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
                      margin: const EdgeInsets.only(top: 20),
                      child: IconButton(
                        icon: const FaIcon(
                          FontAwesome5.search,
                          size: 25,
                          color: whiteColor,
                        ),
                        onPressed: () async => await _showSearch(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(
            width: 20,
          ),
        ], */
        title: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            fillColor: Colors.grey[900],
            hintText: "Search",
            hintStyle: const TextStyle(
              color: whiteColor,
            ),
            prefixIcon: const Icon(
              FontAwesome5.search,
              size: 17,
              color: whiteColor,
            ),
            filled: true,
          ),
        ),
      ),
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: ValueListenableBuilder<bool>(
          valueListenable: resetCache,
          builder: (context, value, _) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              backgroundColor: primaryColor,
              color: secondaryColor,
              child: FutureBuilder(
                future: _future,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Loading(context: context),
                    );
                  }
                  if (snapshot.hasData || snapshot.data != null) {
                    List<Post> data = snapshot.data;

                    return SizedBox(
                      height: screenSize.height,
                      width: screenSize.width,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 100),
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: data
                              .map(
                                (e) => Center(
                                  child: CustomPostCard(
                                    post: e,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  }
                  return errorWidget(screenSize, snapshot);
                },
              ),
            );
          },
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
    );
  }
}
