import 'dart:async';
import 'dart:io';

import 'package:flemis/mobile/controller/chat_controller.dart';
import 'package:flemis/mobile/models/chat.dart';
import 'package:flemis/mobile/models/message.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../models/user.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key, this.chat, this.to}) : super(key: key);
  final Chat? chat;
  final User? to;
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  IO.Socket? socket;
  ScrollController scrollController = ScrollController();
  double scrollPosition = 0;
  StreamController streamController = StreamController.broadcast();
  ChatController? _chatController;
  Manager? manager;

  Future<void> sendMessage(
    String from,
    String text,
    String to,
    String chatId,
    ContentType contentType,
  ) async {
    Message message = Message(
        chatId: chatId,
        from: from,
        content: text,
        contentType: contentType,
        sendedAt: DateTime.now(),
        to: to);
    await _chatController?.sendMessage(message);
  }

  void scrollListener() {
    scrollPosition = scrollController.position.pixels;
  }

  @override
  void initState() {
    manager = context.read<Manager>();
    _chatController = ChatController(context: context);
    _chatController?.initChat(manager!.user!.id!);
    //_chatController?.loadMessages();
    // scrollController.addListener(scrollListener);
    super.initState();
  }

  _animateScreen() {
    scrollController.animateTo(scrollController.position.maxScrollExtent * 1.0,
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }

  @override
  void didChangeDependencies() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateScreen());

    await _chatController?.loadMessages(widget.chat!);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _chatController?.disconnect();
    scrollController.removeListener(scrollListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.to != null ? widget.to!.username! : "flemis user",
          style: primaryFontStyle[7],
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: ListView.builder(
          controller: scrollController,
          itemCount: 0,
          itemBuilder: (context, index) => StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) => Container(
              color: Colors.red,
              child: Center(
                  child: Text(
                "cu",
                style: primaryFontStyle[7],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
