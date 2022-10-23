import 'package:flutter/material.dart';

class ChatController {
  ChatController({this.context});

  final BuildContext? context;

  Future<dynamic> loadConversations() async {
    return List.from(
      [
        0,
        1,
        2,
        3,
        4,
        6,
        7,
      ],
    );
  }
}
