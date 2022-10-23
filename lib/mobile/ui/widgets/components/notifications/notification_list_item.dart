import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';

class NotificationListItem extends StatefulWidget {
  const NotificationListItem({Key? key, this.element}) : super(key: key);
  final String? element;

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.11,
      width: screenSize.width,
      child: Column(
        children: [
          Row(
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
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "askdhjkas ",
                            style: secondaryFontStyle[2],
                          ),
                        ),
                        Text(
                          "liked your post",
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
                      "3h",
                      style: primaryFontStyle[4],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Expanded(
            child: Divider(
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
