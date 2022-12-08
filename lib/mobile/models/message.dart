import 'dart:convert';

enum ContentType { text, image, video, gif }

class Message {
  String? id;
  String? chatId;
  String? from;
  String? to;
  DateTime? sendedAt;
  String? content;
  ContentType? contentType;

  Message({
    this.id,
    this.from,
    this.chatId,
    this.to,
    this.sendedAt,
    this.content,
    this.contentType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      "idChat": chatId,
      'from': from,
      'to': to,
      'sendedAt': sendedAt?.toIso8601String(),
      'content': content,
      'contentType': contentType?.index,
    };
  }

  factory Message.fromMap(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      from: json['from'],
      to: json['to'] as String,
      sendedAt: json["createdAt"] == null
          ? DateTime.tryParse(json['sendedAt'])
          : null,
      content: json['content'],
      contentType: ContentType.values.elementAt(json["contentType"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
