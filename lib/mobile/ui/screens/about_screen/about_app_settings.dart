import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';

class AboutAppSettings extends StatelessWidget {
  const AboutAppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About App",
          style: primaryFontStyle[7],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
      ),
    );
  }
}
