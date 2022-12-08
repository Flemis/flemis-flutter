// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flemis/mobile/models/user.dart';

class Comment {
  String? id;
  String? postId;
  String? content;
  User? commentedBy;
  DateTime? commentedAt;
  List<String>? likedBy;
  List<String>? reports;
  Comment({
    this.id,
    this.postId,
    this.content,
    this.commentedBy,
    this.commentedAt,
    this.likedBy,
    this.reports,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'postId': postId,
      'content': content,
      'commentedBy': commentedBy,
      'commentedAt': commentedAt?.toIso8601String(),
      'likedBy': likedBy,
      'reports': reports,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] != null ? json['id'] as String : null,
      postId: json['postId'] != null ? json['postId'] as String : null,
      content: json['content'] != null ? json['content'] as String : null,
      /*  commentedBy:
          json['commentedBy'] != null ? json['commentedBy'] as String : null, */
      commentedBy: json["commentedBy"] != null
          ? json["commentedBy"] is String
              ? User(id: json["commentedBy"])
              : User.fromMap(json["commentedBy"] as Map<String, dynamic>)
          : null,
      commentedAt: json['commentedAt'] != null
          ? DateTime.tryParse(json['commentedAt'])
          : null,
      likedBy: json['likedBy'] != null
          ? List<String>.from((json['likedBy'] as List<String>))
          : null,
      reports: json['reports'] != null
          ? List<String>.from((json['reports'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}
