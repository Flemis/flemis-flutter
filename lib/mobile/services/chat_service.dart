import 'dart:convert';

import 'package:flemis/mobile/models/api_response.dart';
import 'package:flemis/mobile/models/chat.dart';
import 'package:flemis/mobile/services/default_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/message.dart';

class ChatService extends DefaultService {
  IO.Socket? _socket;
  Future<APIResponse> getConversations(String userId) async {
    String url = "${DefaultService.envUrl}/chat/all";
    try {
      final response = await super.post(url, body: {"userId": userId});
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final parsedResponse = parseResponse(response);

        return APIResponse(
            status: parsedResponse.status, result: parsedResponse.result);
      } else {
        final parsedResponse = parseResponse(response);
        return APIResponse(
          status: parsedResponse.status,
          message: parsedResponse.message,
          result: [],
        );
      }
      // ignore: empty_catches
    } catch (e) {
      return APIResponse(
        status: 500,
        message:
            "Error while trying to load your conversations. Please, try again!",
      );
    }
  }

  Future<void> connect(String chatId) async {
    _socket = IO.io('${DefaultService.envUrl}/',
        IO.OptionBuilder().setTransports(['websocket', 'polling']).build());
    _socket?.connect();
    _socket?.onconnect(chatId);
    // _socket?.emit("signIn", yourId);
    _socket?.on("response", (data) => print(data));
    _socket?.emit("start", chatId);
  }

  Future<void> sendMessage(Message message) async {
    // _socket?.on("sendMessage", (data) => print(data));
    //_socket?.emit("chat", "sua mae ");
    _socket?.on("sendMessage", (data) => print(data));
    _socket?.emit("chat", message.toJson());
  }

  Future<APIResponse> loadMessages() async {
    return APIResponse();
  }

  Future<void> socketError() async {
    _socket?.onError((err) => print(err));
  }

  Future<void> disconnect() async {
    ///_socket?.onDisconnect((data) => print("disconnected"));
    _socket?.ondisconnect();
    _socket?.dispose();
  }
}
