import 'dart:convert';

import 'package:flemis/mobile/models/comment.dart';
import 'package:flemis/mobile/models/user.dart';

class Post {
  String? id;
  String? postedBy;
  String? description;
  String? contentUrl;
  String? content;
  List<Comment>? comments = [];
  List<dynamic>? reports = [];
  bool? private;
  DateTime? postedAt;
  List<User>? likedBy = [];
  String? location;
  List<String>? selectedUsers = [];
  Post({
    this.id,
    this.postedBy,
    this.description,
    this.contentUrl,
    this.content,
    this.comments,
    this.reports,
    this.private,
    this.postedAt,
    this.likedBy,
    this.location,
    this.selectedUsers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'postedBy': postedBy,
      'description': description,
      'contentUrl': contentUrl,
      'content': content,
      'comments':
          comments?.map((e) => Comment.fromMap(e.toMap())).toList().toString(),
      'reports': reports,
      'private': private,
      'postedAt': postedAt?.toIso8601String(),
      'likedBy':
          likedBy?.map((e) => User.fromMap(e.toMap())).toList().toString(),
      'location': location,
      'selectedUsers': selectedUsers,
    };
  }

  factory Post.fromMap(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] != null ? json['_id'] as String : null,
      postedBy: json['postedBy'] != null ? json['postedBy'] as String : null,
      description:
          json['description'] != null ? json['description'] as String : null,
      contentUrl:
          json['contentUrl'] != null ? json['contentUrl'] as String : null,
      content: json['content'] != null ? json['content'] as String : null,
      comments: json['comments'] != null && json["comments"] is List<dynamic>
          ? List<Comment>.from(
              (json['comments'] as List<dynamic>).map(
                (element) => Comment.fromMap(element as Map<String, dynamic>),
              ),
            )
          : [],
      reports: json['reports'] != null && json["reports"] is List<dynamic>
          ? List<dynamic>.from(json['reports'] as List<dynamic>)
          : [],
      private: json['private'] != null ? json['private'] as bool : null,
      postedAt:
          json['postedAt'] != null ? DateTime.tryParse(json['postedAt']) : null,
      likedBy: json['likedBy'] != null && json["likedBy"] is List<dynamic>
          ? List<User>.from(
              (json['likedBy'] as List<dynamic>).map(
                (element) => User.fromMap(element as Map<String, dynamic>),
              ),
            )
          : [],
      location: json['location'] != null ? json['location'] as String : null,
      selectedUsers: json['selectedUsers'] != null &&
              json["selectedUsers"] is List<dynamic>
          ? List<String>.from(json['selectedUsers'] as List<dynamic>)
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
