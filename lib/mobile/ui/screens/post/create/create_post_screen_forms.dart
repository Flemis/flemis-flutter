import 'dart:io';

import 'package:flemis/mobile/controller/post_controller.dart';
import 'package:flemis/mobile/models/post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../my_app_mobile.dart';
import '../../../../providers/manager.dart';
import '../../../../utils/navigator.dart';
import 'package:path/path.dart' as path;

class CreatePostScreenForms extends StatefulWidget {
  const CreatePostScreenForms({super.key, this.file});
  final File? file;
  @override
  State<CreatePostScreenForms> createState() => _CreatePostScreenFormsState();
}

class _CreatePostScreenFormsState extends State<CreatePostScreenForms> {
  AppNavigator? navigator;
  PostController? _postController;
  Manager? manager;
  ValueNotifier<bool> private = ValueNotifier<bool>(false);

  @override
  void initState() {
    _postController = PostController(context: context);
    manager = context.read<Manager>();
    navigator = AppNavigator(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "New post",
          style: primaryFontStyle[7],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              await _postController?.createPost(
                  Post(
                      postedBy: manager!.user!,
                      content: _postController?.contentController.text,
                      description: _postController?.descriptionController.text,
                      location: _postController?.locationController.text,
                      private: private.value),
                  file: widget.file != null
                      ? {
                          "fileName": path.basename(widget.file!.path),
                          "bytes": widget.file
                              ?.readAsBytesSync()
                              .buffer
                              .asUint8List()
                        }
                      : null);
              private.value = false;
            },
            child: const Text(
              "Create",
              style: TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      backgroundColor: primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _descriptionWidget(),
              _contentWidget(),
              _locationWidget(),
              const SizedBox(
                height: 10,
              ),
              _isPublicPostWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
      child: TextFormField(
        cursorColor: whiteColor,
        style: const TextStyle(
          color: whiteColor,
        ),
        controller: _postController?.descriptionController,
        decoration: const InputDecoration(
          hintText: "Write a description or caption...",
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _locationWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
      child: TextFormField(
        cursorColor: whiteColor,
        style: const TextStyle(
          color: whiteColor,
        ),
        controller: _postController?.locationController,
        decoration: const InputDecoration(
          hintText: "Write a location...",
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
      child: TextFormField(
        cursorColor: whiteColor,
        style: const TextStyle(
          color: whiteColor,
        ),
        controller: _postController?.contentController,
        decoration: const InputDecoration(
          hintText: "Write a content...",
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _isPublicPostWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Private Post",
            style: secondaryFontStyle[9],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: private,
          builder: (context, isPrivate, _) {
            return Switch(              activeColor: secondaryColor,
              value: private.value,
              onChanged: (bool value) {
                private.value = value;
              },
            );
          },
        )
      ],
    );
  }
}
