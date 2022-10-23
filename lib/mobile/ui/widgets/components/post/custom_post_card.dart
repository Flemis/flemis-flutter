import 'dart:io';

import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPostCard extends StatefulWidget {
  const CustomPostCard({Key? key}) : super(key: key);

  @override
  State<CustomPostCard> createState() => _CustomPostCardState();
}

class _CustomPostCardState extends State<CustomPostCard> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height < 750
          ? screenSize.height * 0.45
          : screenSize.height * 0.5,
      width: screenSize.width * 0.9,
      child: Card(
        color: secondaryColor,
        borderOnForeground: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _headerCard(screenSize),
            _content(screenSize),
          ],
        ),
      ),
    );
  }
}

Widget _headerCard(screenSize) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              backgroundImage: Image.asset("./assets/fernando.jpg").image,
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "askdhjkas",
                    style: secondaryFontStyle[1],
                  ),
                ),
                SizedBox(
                  child: Text(
                    "12 min ago",
                    style: secondaryFontStyle[5],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.only(
          left: 20,
          right: 10,
        ),
        child: Row(
          children: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.bookmark,
                size: 30,
                color: primaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                size: 30,
                color: primaryColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _content(screenSize) {
  return Flexible(
    child: Container(
      height: screenSize.height < 750
          ? screenSize.height * 0.45
          : screenSize.height * 0.5,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
                  height: screenSize.height < 750
                      ? screenSize.height * 0.45
                      : screenSize.height * 0.5,
                  width: screenSize.width * 0.5,
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "askdhjkasakjshdajkshdakjshdjakshdkjashdjkashdjakshdjaksdhaksjhdkas",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: secondaryFontStyle[2],
                  ),
                ),
              ),
              Container(
                //color: Colors.red,
                height: screenSize.height < 750
                    ? screenSize.height * 0.35
                    : screenSize.height * 0.5,

                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(
                    left: Platform.isIOS
                        ? 40
                        : screenSize.width < 400
                            ? 30
                            : 50,
                    bottom: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.comment,
                        size: 30,
                        color: whiteColor,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesome.heart_empty,
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
        ],
      ),
    ),
  );
}
