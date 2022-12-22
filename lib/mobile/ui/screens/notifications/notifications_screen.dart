import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flemis/mobile/controller/notifications_controller.dart';
import 'package:flemis/mobile/models/notifications.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flemis/mobile/ui/widgets/components/notifications/notification_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../my_app_mobile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key, this.isDarkMode = false})
      : super(key: key);
  final bool? isDarkMode;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  ValueNotifier<bool> resetCache = ValueNotifier<bool>(false);
  NotificationsController? notificationsController;
  Manager? manager;
  StreamController streamController = StreamController.broadcast();
  final analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    analytics.setCurrentScreen(screenName: "notifications");
    notificationsController = NotificationsController();
    manager = context.read<Manager>();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await notificationsController
        ?.getNotifications(manager!.user!.id!)
        .then((value) => streamController.sink.add(value))
        .catchError((error, stack) => streamController.sink.addError(error));
  }

  Future onRefresh() async {
    //future = notificationsController?.getNotifications(manager!.user!.id!);
    resetCache.value = !resetCache.value;
    return;
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: !widget.isDarkMode! ? primaryColor : tertiaryColor,
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
                        "Activity",
                        style: primaryFontStyle[2],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        manager!.user!.username!,
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
                        "Activity",
                        style: primaryFontStyle[2],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        manager!.user!.username!,
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
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: whiteColor,
                        ),
                        onPressed: () async => Navigator.of(context).pop(
                            /*  MaterialPageRoute(
                            builder: (BuildContext context) => MobileBase(),
                          ), */
                            true),
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
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: whiteColor,
                        ),
                        onPressed: () async => Navigator.of(context).pop(true),
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
      backgroundColor: primaryColor,
      body: ValueListenableBuilder(
        valueListenable: resetCache,
        builder: (context, isCacheReseted, _) {
          return StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Loading(context: context),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                List<Notifications> notifications =
                    snapshot.data as List<Notifications>;
                return notificationList(screenSize, notifications);
              }
              return SizedBox(
                height: screenSize.height * .6,
                child: Center(
                  child: Text(
                    snapshot.error != null
                        ? snapshot.error.toString()
                        : "no data",
                    textAlign: TextAlign.center,
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

  Widget notificationList(Size screenSize, List<Notifications> notifications) {
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
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                if (index <= 0) {
                  return _followersRequests(screenSize);
                }
                return Column(
                  children: [
                    const Divider(
                      color: whiteColor,
                    ),
                    NotificationListItem(
                      element: notifications[index],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _followersRequests(Size screenSize) {
    return SizedBox(
      height: 100,
      width: screenSize.height,
      //color: Colors.red,
      child: Row(
        children: const [],
      ),
    );
  }
}
