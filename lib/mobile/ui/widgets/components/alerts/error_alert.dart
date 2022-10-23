import 'dart:ui';

import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';

class ErrorAlert {
  static Future<dynamic> showAlert(BuildContext context, String message) async {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      transitionBuilder: (context, a1, a2, _) => WillPopScope(
        onWillPop: () async => false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  "Error",
                  style: TextStyle(
                    color: secondaryColor,
                  ),
                ),
                content: SizedBox(
                  height: 150,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          message,
                          style: const TextStyle(color: whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static close({required BuildContext context}) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
