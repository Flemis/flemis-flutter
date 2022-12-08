import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../my_app_mobile.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  PhotoViewController controller =
      PhotoViewController(initialPosition: Offset.zero, initialScale: 1);
  AppNavigator? navigator;
  @override
  void initState() {
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
            onPressed: () async => null,
            child: const Text(
              "Next",
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
              _imageCropped(screenSize),
              _imageMenu(screenSize),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageCropped(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.4,
      width: screenSize.width,
      child: ClipRRect(
        child: PhotoView.customChild(
          enablePanAlways: true,
          // enableRotation: true,
          controller: controller,
          tightMode: true,
          minScale: PhotoViewComputedScale.contained,
          backgroundDecoration:
              const BoxDecoration(color: primaryColor ?? darkColor),
          child: Image.asset(
            "./assets/fernando.jpg",
          ),
        ),
      ),
    );
  }

  Widget _imageMenu(Size screenSize) {
    return Container(
      color: primaryColor,
      height: screenSize.height * 0.09,
      width: screenSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    "Recents",
                    style: secondaryFontStyle[9],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: TextButton(
              onPressed: () => navigator?.goToCreatePostForm(),
              child: Row(
                children: const [
                  Text(
                    "Skip step",
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(40),
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: const CircleBorder(
                  side: BorderSide(color: Colors.white, width: 0.5),
                ),
              ),
              onPressed: () => navigator?.goToCameraScreen(),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
