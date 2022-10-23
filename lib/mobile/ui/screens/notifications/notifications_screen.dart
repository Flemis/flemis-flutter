import 'dart:io';

import 'package:flemis/mobile/ui/widgets/components/notifications/notification_list_item.dart';
import 'package:flutter/material.dart';

import '../../../my_app_mobile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key, this.isDarkMode = false})
      : super(key: key);
  final bool? isDarkMode;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
                        "Activity",
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
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: screenSize.height,
                //color: Colors.red,
                child: Row(
                  children: const [],
                ),
              ),
              const Divider(
                color: whiteColor,
              ),
              Column(
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
                      (e) => NotificationListItem(
                        element: e.toString(),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
