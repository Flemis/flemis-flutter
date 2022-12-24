import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flemis/mobile/controller/post_controller.dart';
import 'package:flemis/mobile/controller/user_controller.dart';
import 'package:flemis/mobile/models/post.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../models/user.dart';
import '../../../../providers/manager.dart';
import '../../../widgets/components/loading/loading.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, this.post, this.user});
  final Post? post;
  final User? user;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  AppNavigator? appNavigator;
  Manager? manager;
  PostController? _postController;
  ValueNotifier<Post?>? notifier;
  final analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    _postController = PostController(context: context);
    appNavigator = AppNavigator(context: context);
    manager = context.read<Manager>();
    notifier = ValueNotifier<Post?>(widget.post);
    analytics.setCurrentScreen(screenName: "post");
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    analytics.setCurrentScreen(screenName: "post");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: _headerBar(screenSize, notifier!.value!, widget.user!),
        centerTitle: true,
        actions: [
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
                    color: whiteColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
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
      backgroundColor: primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          children: widget.post!.contentUrl != null
              ? [
                  SizedBox(
                    height: screenSize.height < 750
                        ? screenSize.height * 0.3
                        : screenSize.height * 0.35,
                    width: screenSize.width,
                    child: Image.network(widget.post!.contentUrl!),
                  )
                ]
              : [
                  Container(
                    height: screenSize.height < 750
                        ? screenSize.height * 0.3
                        : screenSize.height * 0.2,
                    width: screenSize.width,
                    padding:
                        const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                    alignment: Alignment.center,
                    child: Text(
                      widget.post?.description! ?? "",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: true,
                      style: secondaryFontStyle[2],
                    ),
                  ),
                  _buttonsRow(notifier!, screenSize),
                  SizedBox(
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, right: 10, bottom: 20),
                      child: Text(
                        widget.post?.content ?? "",
                        style: secondaryFontStyle[9],
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Flexible(child: _comments(notifier!, screenSize)),
                ],
        ),
      ),
    );
  }

  Widget postContent(Size screenSize, Post post) {
    return SizedBox(
      height: screenSize.height * 0.3,
      width: screenSize.width,
      child: post.contentUrl != null
          ? Image.network(post.contentUrl!)
          : Center(
              child: Text(
                post.content!.isEmpty ? "" : post.content!,
              ),
            ),
    );
  }

  Widget _headerBar(Size screenSize, Post post, User user) {
    return Row(
      children: [
        InkWell(
          onTap: () => appNavigator?.goToProfile(
              isYourProfile: user.id != manager?.user?.id,
              isAnimated: true,
              user: user),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: screenSize.width < 400 ? 0 : 10, top: 10, bottom: 10),
                child: user.avatarUrl != null
                    ? CircleAvatar(
                        backgroundImage: Image.network(user.avatarUrl!).image,
                        backgroundColor: primaryColor,
                        radius: 20,
                      )
                    : CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 20,
                        backgroundImage:
                            Image.asset("./assets/avatar.png").image,
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
                        style: secondaryFontStyle[9],
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          _postedAgo(post.postedAt!),
                          style: secondaryFontStyle[4],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonsRow(ValueNotifier<Post?> postNotifier, Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.comment,
                  size: 35,
                  color: whiteColor,
                ),
                onPressed: () {},
              ),
              ValueListenableBuilder<Post?>(
                valueListenable: postNotifier,
                builder: (context, snapshot, _) {
                  return IconButton(
                    icon: FaIcon(
                      postNotifier.value?.likedBy == null ||
                              !postNotifier.value!.likedBy!.any(
                                  (element) => element.id == manager!.user!.id!)
                          ? FontAwesome.heart_empty
                          : FontAwesome.heart,
                      size: 35,
                      color: postNotifier.value?.likedBy == null ||
                              !postNotifier.value!.likedBy!.any(
                                  (element) => element.id == manager!.user!.id!)
                          ? whiteColor
                          : Colors.red,
                    ),
                    onPressed: postNotifier.value?.likedBy == null ||
                            !postNotifier.value!.likedBy!.any(
                                (element) => element.id == manager!.user!.id!)
                        ? () async {
                            postNotifier.value!.likedBy?.add(manager!.user!);
                            postNotifier.notifyListeners();
                            await _postController?.likePost(
                              {
                                "postId": postNotifier.value!.id,
                                "user":
                                    manager!.user?.toMapPost(fromLike: true),
                                "userNotified": postNotifier.value!.postedBy
                              },
                            );
                          }
                        : () async {
                            postNotifier.value!.likedBy?.removeWhere(
                                (element) => element.id == manager?.user!.id);
                            postNotifier.notifyListeners();
                            await _postController?.unlikePost(
                              {
                                "postId": postNotifier.value!.id,
                                "user":
                                    manager!.user?.toMapPost(fromLike: true),
                              },
                            );
                          },
                  );
                },
              ),
              SizedBox(
                width: screenSize.width * 0.02,
              ),
              ValueListenableBuilder<Post?>(
                valueListenable: postNotifier,
                builder: (context, snapshot, _) {
                  return SizedBox(
                    width: screenSize.width * 0.65,
                    child: Text(
                      snapshot?.likedBy == null
                          ? ""
                          : snapshot!.likedBy!.length <= 1
                              ? snapshot.likedBy == null ||
                                      snapshot.likedBy!.isEmpty
                                  ? ""
                                  : "Liked by ${snapshot.likedBy?.first.username}"
                              : "Liked by ${snapshot.likedBy?.first.username} and others",
                      style: secondaryFontStyle[9],
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
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

  Widget _comments(ValueNotifier<Post?> postNotifier, Size screenSize) {
    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              "Comments",
              style: primaryFontStyle[8],
            ),
            ValueListenableBuilder<Post?>(
              valueListenable: postNotifier,
              builder: (context, value, child) {
                if (value?.comments != null && value!.comments!.isNotEmpty) {
                  return SizedBox(
                    height: screenSize.height,
                    width: screenSize.width,
                    child: Column(
                      children: value.comments!
                          .map((e) => ListTile(
                                leading: e.commentedBy?.avatarUrl != null &&
                                        e.commentedBy!.avatarUrl!.isNotEmpty
                                    ? CircleAvatar(
                                        backgroundImage: Image.network(
                                          e.commentedBy!.avatarUrl!,
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              Loading(
                                            context: context,
                                          ),
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                                      "./assets/avatar.png"),
                                          fit: BoxFit.cover,
                                        ).image,
                                        radius: 30,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: Image.asset(
                                          "./assets/avatar.png",
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                                      "./assets/avatar.png"),
                                          fit: BoxFit.cover,
                                        ).image,
                                        radius: 30,
                                      ),
                                title: Text(e.commentedBy!.username!),
                              ))
                          .toList(),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: screenSize.height < 750
                        ? screenSize.height * 0.4
                        : screenSize.height * .5,
                    width: screenSize.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Text(
                            "Don't have comments.\n Be first to comment.",
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: secondaryFontStyle[3],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
