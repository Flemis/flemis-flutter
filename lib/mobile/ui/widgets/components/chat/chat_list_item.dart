import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({Key? key, this.element}) : super(key: key);
  final String? element;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        height: screenSize.height < 700
            ? screenSize.height * 0.15
            : screenSize.height < 800
                ? screenSize.height * 0.14
                : screenSize.height > 900
                    ? screenSize.height * 0.15
                    : screenSize.height * 0.12,
        width: screenSize.width,
        padding: const EdgeInsets.only(top: 10),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "askdhjkas",
                              style: secondaryFontStyle[2],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              children: [
                                const FaIcon(
                                  FontAwesome.comment_empty,
                                  color: secondaryColor,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Received",
                                  style: secondaryFontStyle[3],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 15,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const FaIcon(
                          FontAwesome.camera,
                          size: 30,
                          color: whiteColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Expanded(
              child: Divider(
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
