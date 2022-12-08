import 'package:flemis/mobile/models/chat.dart';
import 'package:flemis/mobile/models/message.dart';
import 'package:flemis/mobile/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatController {
  ChatController({this.context});

  final BuildContext? context;
  final ChatService _chatService = ChatService();

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

  Future<dynamic> getAllConversations(String userId) async {
    await _chatService.getConversations(userId).catchError((error, stack) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
        return response.result;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }

  Future<void> initChat(String chatId) async {
    await _chatService.connect(chatId);
  }

  Future<void> sendMessage(Message message) async {
    await _chatService.sendMessage(message);
  }

  Future<void> loadMessages(Chat chat) async {
    await _chatService.loadMessages();
  }

  Future<void> disconnect() async {
    await _chatService.disconnect();
  }
}
