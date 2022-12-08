import 'package:flemis/mobile/controller/user_controller.dart';
import 'package:flemis/mobile/models/chat.dart';
import 'package:flemis/mobile/models/message.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../models/user.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({Key? key, this.element, required this.navigator})
      : super(key: key);
  final Chat? element;
  final AppNavigator navigator;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  User? to;
  UserController? userController;
  Manager? manager;

  @override
  void initState() {
    manager = context.read<Manager>();
    userController = UserController(context: context);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    to = await userController?.getUserById(widget.element!.users!
        .firstWhere((element) => element != manager!.user!.id!));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => widget.navigator.goToMessageScreen(
        chat: widget.element,
        to: to,
      ),
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
            item(widget.element!),
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

  Widget item(Chat chat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: CircleAvatar(
                backgroundImage: to?.avatarUrl != null
                    ? Image.network(
                        to!.avatarUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: ((context, error, stackTrace) =>
                            Image.asset(
                              "./assets/avatar.png",
                              fit: BoxFit.cover,
                            )),
                      ).image
                    : Image.asset(
                        "./assets/avatar.png",
                        fit: BoxFit.cover,
                      ).image,
                backgroundColor: secondaryColor,
                radius: 25,
              ),
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      chat.messages != null &&
                              chat.messages!.last.contentType ==
                                  ContentType.text
                          ? chat.messages!.last.content!
                          : "askdhjkas",
                      style: secondaryFontStyle[2],
                    ),
                  ),
                  /*Container(
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
                  ),*/
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
    );
  }
}
