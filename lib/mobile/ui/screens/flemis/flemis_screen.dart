import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';

class FlemisScreen extends StatefulWidget {
  const FlemisScreen({super.key});

  @override
  State<FlemisScreen> createState() => _FlemisScreenState();
}

class _FlemisScreenState extends State<FlemisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Flemis",
          style: primaryFontStyle[7],
        ),
      ),
      backgroundColor: primaryColor,
    );
  }
}
