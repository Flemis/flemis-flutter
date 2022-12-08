// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flemis/mobile/models/message.dart';

class Chat {
  String? id;
  List<dynamic>? users;
  DateTime? createdAt;
  List<Message>? messages;
  Chat({
    this.id,
    this.users,
    this.createdAt,
    this.messages,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      '_idUsers': users,
      'createdAt': createdAt?.toIso8601String(),
      'messages': messages?.map((x) => x.toMap()).toList().toString(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'],
      users: List<String>.from((json['_idUsers'] as List<String>)),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      messages: json['messages'] != null
          ? List<Message>.from(
              (json['messages'] as List<int>).map<Message?>(
                (x) => Message.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);
}
