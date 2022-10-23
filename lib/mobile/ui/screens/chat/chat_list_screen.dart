import 'dart:io';

import 'package:flemis/mobile/controller/chat_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/ui/widgets/components/chat/chat_list_item.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  final ValueNotifier<bool> resetCache = ValueNotifier(false);
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
      query: "any query",
    );
  }

  ChatController? chatController;

  @override
  void initState() {
    super.initState();
    chatController = ChatController(context: context);
    controllerAnimation =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(controllerAnimation!);
    controllerAnimation?.reverse();
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
                        "Fernandosini",
                        style: primaryFontStyle[4],
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
                              "Fernandosini",
                              style: primaryFontStyle[4],
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
                    future: chatController?.loadConversations(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data == null ||
                          snapshot.data?.length == 0 ||
                          snapshot.error != null ||
                          snapshot.hasError ||
                          !snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Text(
                              snapshot.error.toString(),
                            ),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loading(context: context);
                      }
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        child: Column(
                          children: List.from(
                            [
                              0,
                              1,
                              2,
                              3,
                              4,
                              6,
                              7,
                            ],
                          )
                              .map(
                                (e) => ChatListItem(
                                  element: e.toString(),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
