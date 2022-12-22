import 'dart:ui';

import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

typedef SessionCallBack = void Function(int);

class _LandingState extends State<Landing> {
  late final SessionCallBack sessionCallBack;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.red,
      body: InkWell(
        onTap: () => sessionCallBack(0),
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
        ),
      ),
    );
  }
}
