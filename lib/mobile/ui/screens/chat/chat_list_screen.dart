import 'dart:io';

import 'package:flemis/mobile/controller/chat_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/ui/widgets/components/chat/chat_list_item.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../controller/user_controller.dart';
import '../../../models/chat.dart';
import '../../../providers/manager.dart';
import '../../widgets/components/search/custom_search_delegate.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _isSearchExpanded = ValueNotifier<bool>(false);

  AnimationController? controllerAnimation;
  Animation<double>? _fadeAnimation;
  AppNavigator? appNavigator;

  final ValueNotifier<bool> resetCache = ValueNotifier(false);
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
      query: "any query",
    );
  }

  ChatController? chatController;
  UserController? userController;
  Manager? manager;

  @override
  void initState() {
    manager = context.read<Manager>();
    appNavigator = AppNavigator(context: context);
    super.initState();
    chatController = ChatController(context: context);
    userController = UserController(context: context);
    controllerAnimation =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(controllerAnimation!);
    controllerAnimation?.reverse();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future onRefresh() async {
    resetCache.value = !resetCache.value;
    return;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
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
                        "Chat",
                        style: primaryFontStyle[2],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        manager!.user!.username!.length >= 15
                            ? manager!.user!.username!.replaceRange(
                                15, manager!.user!.username!.length, "...")
                            : manager!.user!.username!,
                        style: primaryFontStyle[7],
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              )
            else
              ValueListenableBuilder<bool>(
                  valueListenable: _isSearchExpanded,
                  builder: (context, isExpanded, _) {
                    if (isExpanded) {
                      return Container();
                    }
                    return SizedBox(
                      height: screenSize.height * 0.12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "Chat",
                              style: primaryFontStyle[2],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              manager!.user!.username!.length >= 15
                                  ? manager!.user!.username!.replaceRange(15,
                                      manager!.user!.username!.length, "...")
                                  : manager!.user!.username! ?? "",
                              style: primaryFontStyle[7],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
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
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const FaIcon(
                        FontAwesome5.plus,
                        size: 25,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            )
          else
            ValueListenableBuilder<bool>(
                valueListenable: _isSearchExpanded,
                builder: (context, isExpanded, _) {
                  if (!isExpanded) {
                    return Column(
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
                                onPressed: () async {
                                  _isSearchExpanded.value = true;
                                  _isSearchExpanded.notifyListeners();
                                  controllerAnimation?.forward();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const FaIcon(
                                FontAwesome5.plus,
                                size: 25,
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return FadeTransition(
                      opacity: _fadeAnimation!,
                      child: SizedBox(
                        width: screenSize.width * .94,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _isSearchExpanded.value = false;
                                _isSearchExpanded.notifyListeners();
                                controllerAnimation?.reverse();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 25,
                              ),
                            ),
                            AnimatedContainer(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              height: 50,
                              duration: const Duration(seconds: 3),
                              curve: Curves.linear,
                              width: isExpanded ? screenSize.width * 0.6 : 0,
                              color: secondaryColor,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    fillColor: Colors.red, filled: true),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _isSearchExpanded.value = false;
                                _isSearchExpanded.notifyListeners();
                                controllerAnimation?.reverse();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: ValueListenableBuilder(
            valueListenable: resetCache,
            builder: (context, __, _) {
              return RefreshIndicator(
                backgroundColor: primaryColor,
                color: secondaryColor,
                onRefresh: onRefresh,
                child: FutureBuilder(
                  future:
                      chatController?.getAllConversations(manager!.user!.id!),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: Loading(context: context),
                      );
                    }
                    if (snapshot.hasData || snapshot.data != null) {
                      return chatItem(snapshot);
                    }
                    return errorWidget(screenSize, snapshot);
                  },
                ),
              );
            }),
      ),
    );
  }

  Widget chatItem(AsyncSnapshot snapshot) {
    List<Chat> chats = snapshot.data;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        children: chats
            .map(
              (e) => ChatListItem(
                element: e,
                navigator: appNavigator!,
              ),
            )
            .toList(),
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
          onRefresh: onRefresh,
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
