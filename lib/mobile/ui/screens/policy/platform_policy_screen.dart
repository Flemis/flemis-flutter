import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';

class PlatformPolicyScreen extends StatefulWidget {
  const PlatformPolicyScreen({super.key});

  @override
  State<PlatformPolicyScreen> createState() => _PlatformPolicyScreenState();
}

class _PlatformPolicyScreenState extends State<PlatformPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Platform Policy",
          style: primaryFontStyle[7],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
      ),
    );
  }
}
