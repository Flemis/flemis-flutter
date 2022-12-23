import 'dart:io';

import 'package:flemis/mobile/controller/post_controller.dart';
import 'package:flemis/mobile/controller/user_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../models/post.dart';
import '../../../../models/user.dart';
import '../../../../providers/manager.dart';

class CustomPostCard extends StatefulWidget {
  const CustomPostCard({Key? key, this.post}) : super(key: key);
  final Post? post;

  @override
  State<CustomPostCard> createState() => _CustomPostCardState();
}

class _CustomPostCardState extends State<CustomPostCard> {
  UserController? userController;
  ValueNotifier<User?> user = ValueNotifier(null);
  PostController? postController;
  Manager? manager;
  AppNavigator? appNavigator;
  ValueNotifier<Post?>? postNotifier;

  @override
  void initState() {
    appNavigator = AppNavigator(context: context);
    userController = UserController(context: context);
    postController = PostController(context: context);
    manager = context.read<Manager>();
    postNotifier = ValueNotifier(widget.post);
    user.value = widget.post!.postedBy;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    /* await userController?.getUserById(widget.post!.postedBy!.id!).then(
        (value) => user.value = value,
        onError: (error) => user.value = error); */
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height < 750
          ? screenSize.height * 0.45
          : screenSize.height * 0.5,
      width: screenSize.width * 0.9,
      child: Card(
        margin:
            screenSize.height < 750 ? null : const EdgeInsets.only(bottom: 50),
        color: secondaryColor,
        borderOnForeground: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ValueListenableBuilder<User?>(
          valueListenable: user,
          builder: (context, value, child) => Column(
            mainAxisAlignment: value == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: value == null
                ? [
                    SizedBox(
                      height: screenSize.height * 0.045,
                    ),
                    Loading(
                      context: context,
                      color: primaryColor,
                    ),
                  ]
                : [
                    _headerCard(screenSize, postNotifier!, value),
                    Flexible(child: _content(screenSize, postNotifier!, value)),
                  ],
          ),
        ),
      ),
    );
  }

  String _postedAgo(DateTime postedAt) {
    if (DateTime.now().difference(postedAt).inSeconds < 60) {
      return "${DateTime.now().difference(postedAt).inSeconds} seconds ago";
    } else {
      if (DateTime.now().difference(postedAt).inSeconds <= 3600) {
        return "${DateTime.now().difference(postedAt).inMinutes} minutes ago";
      }
      if (DateTime.now().difference(postedAt).inSeconds <= 86400) {
        return "${DateTime.now().difference(postedAt).inHours} hours ago";
      } else {
        return "${DateTime.now().difference(postedAt).inDays} days ago";
      }
    }
  }

  Widget _headerCard(
      Size screenSize, ValueNotifier<Post?> notifier, User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => appNavigator?.goToProfile(
              isYourProfile: user.id != manager?.user?.id,
              isAnimated: true,
              user: user),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                height: 50,
                width: 50,
                child: user.avatarUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(user.avatarUrl!),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("./assets/avatar.png"),
                      ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        user.username!,
                        style: secondaryFontStyle[1],
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          _postedAgo(notifier.value!.postedAt!),
                          style: secondaryFontStyle[5],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

  Widget _content(Size screenSize, ValueNotifier<Post?> notifier, User user) {
    return InkWell(
      onTap: () => appNavigator?.goToPostScreen(
          post: notifier.value, isAnimated: true, user: user),
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
          children: notifier.value?.contentUrl == null
              ? [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5,
                      ),
                      Flexible(
                        child: Container(
                          //  color: Colors.red,
                          height: screenSize.height < 750
                              ? screenSize.height * 0.35
                              : screenSize.height * 0.5,
                          width: screenSize.width > 400
                              ? screenSize.width * 0.3
                              : screenSize.width * 0.37,
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.only(
                              left: Platform.isIOS
                                  ? 20
                                  : screenSize.width < 400
                                      ? 30
                                      : 20,
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
                              ValueListenableBuilder<Post?>(
                                  valueListenable: notifier,
                                  builder: (context, __, _) {
                                    return IconButton(
                                      icon: FaIcon(
                                        notifier.value?.likedBy == null ||
                                                !notifier.value!.likedBy!.any(
                                                    (element) =>
                                                        element.id ==
                                                        manager!.user!.id!)
                                            ? FontAwesome.heart_empty
                                            : FontAwesome.heart,
                                        size: 30,
                                        color:
                                            notifier.value?.likedBy == null ||
                                                    !notifier.value!.likedBy!
                                                        .any((element) =>
                                                            element.id ==
                                                            manager!.user!.id!)
                                                ? whiteColor
                                                : Colors.red,
                                      ),
                                      onPressed: notifier.value?.likedBy ==
                                                  null ||
                                              !notifier.value!.likedBy!.any(
                                                  (element) =>
                                                      element.id ==
                                                      manager!.user!.id!)
                                          ? () async {
                                              notifier.value!.likedBy
                                                  ?.add(manager!.user!);
                                              notifier.notifyListeners();
                                              await postController?.likePost(
                                                {
                                                  "postId": notifier.value?.id,
                                                  "user": manager!.user
                                                      ?.toMapPost(),
                                                  "userNotified": notifier
                                                      .value!.postedBy?.id
                                                },
                                              );
                                            }
                                          : () async {
                                              notifier.value!.likedBy
                                                  ?.removeWhere((element) =>
                                                      element.id ==
                                                      manager?.user!.id);
                                              notifier.notifyListeners();
                                              await postController?.unlikePost(
                                                {
                                                  "postId": notifier.value?.id,
                                                  "user": manager!.user
                                                      ?.toMapPost(),
                                                },
                                              );
                                            },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    // color: Colors.red,
                    width: screenSize.width,
                    padding:
                        const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                    alignment: Alignment.center,
                    child: Text(
                      notifier.value!.description!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: true,
                      style: secondaryFontStyle[2],
                    ),
                  ),
                ]
              : [
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
                            notifier.value!.description!,
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
                            ValueListenableBuilder<Post?>(
                                valueListenable: notifier,
                                builder: (context, __, _) {
                                  return IconButton(
                                    icon: FaIcon(
                                      notifier.value?.likedBy == null ||
                                              !notifier.value!.likedBy!.any(
                                                  (element) =>
                                                      element.id ==
                                                      manager!.user!.id!)
                                          ? FontAwesome.heart_empty
                                          : FontAwesome.heart,
                                      size: 30,
                                      color: notifier.value?.likedBy == null ||
                                              !notifier.value!.likedBy!.any(
                                                  (element) =>
                                                      element.id ==
                                                      manager!.user!.id!)
                                          ? whiteColor
                                          : Colors.red,
                                    ),
                                    onPressed: notifier.value?.likedBy ==
                                                null ||
                                            !notifier.value!.likedBy!.any(
                                                (element) =>
                                                    element.id ==
                                                    manager!.user!.id!)
                                        ? () async {
                                            notifier.value!.likedBy
                                                ?.add(manager!.user!);
                                            notifier.notifyListeners();
                                            await postController?.likePost(
                                              {
                                                "postId": notifier.value?.id,
                                                "user": manager!.user?.toMap(),
                                                "userNotified":
                                                    notifier.value!.postedBy
                                              },
                                            );
                                          }
                                        : () async {
                                            notifier.value!.likedBy
                                                ?.removeWhere((element) =>
                                                    element.id ==
                                                    manager?.user!.id);
                                            notifier.notifyListeners();
                                            await postController?.unlikePost(
                                              {
                                                "postId": notifier.value?.id,
                                                "user": manager!.user?.toMap(),
                                              },
                                            );
                                          },
                                  );
                                }),
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
}
