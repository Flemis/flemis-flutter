import 'dart:io';

import 'package:flemis/mobile/controller/post_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/ui/widgets/components/chat/chat_list_item.dart';
import 'package:flemis/mobile/ui/widgets/components/search/custom_search_delegate.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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

  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
      query: "any query",
    );
  }

  @override
  void initState() {
    super.initState();
    postController = PostController(context: context);
    manager = context.read<Manager>();
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
                        "Explore",
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
        ],
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
                future: postController?.getFeed(manager!.user!.id!),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading(context: context);
                  }
                  if (snapshot.hasData || snapshot.data != null) {
                    List<dynamic> data = snapshot.data;
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Column(
                        children: data
                            .map((e) => ChatListItem(
                                  element: e.toString(),
                                ))
                            .toList(),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
