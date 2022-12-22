import 'package:flemis/mobile/models/notifications.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';

class NotificationListItem extends StatefulWidget {
  const NotificationListItem({Key? key, this.element}) : super(key: key);
  final Notifications? element;

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.08,
      width: screenSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: const CircleAvatar(
                        backgroundColor: secondaryColor,
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.element!.createdBy!.username ?? "",
                              style: secondaryFontStyle[2],
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          Text(
                            widget.element!.message!,
                            style: secondaryFontStyle[3],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        _postedAgo(widget.element!.createdAt!),
                        style: primaryFontStyle[4],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /* const Expanded(
            child: Divider(
              color: whiteColor,
            ),
          ), */
        ],
      ),
    );
  }

  String _postedAgo(DateTime postedAt) {
    if (DateTime.now().difference(postedAt).inSeconds < 60) {
      return "${DateTime.now().difference(postedAt).inSeconds} s";
    } else {
      if (DateTime.now().difference(postedAt).inSeconds <= 3600) {
        return "${DateTime.now().difference(postedAt).inMinutes} m";
      }
      if (DateTime.now().difference(postedAt).inSeconds <= 86400) {
        return "${DateTime.now().difference(postedAt).inHours} h ";
      } else {
        return "${DateTime.now().difference(postedAt).inDays} d";
      }
    }
  }
}
