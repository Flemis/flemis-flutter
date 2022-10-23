// ignore_for_file: constant_identifier_names

import 'package:flemis/mobile/models/user.dart';
import 'package:flutter/material.dart';

enum MediaType { Image, Video }

class Story {
  String? id;
  String? mediaUrl;
  Duration? duration;
  User? author;
  List<String>? viewdBy;
  List<Widget>? storyWidgets;
  MediaType? mediaType;
}
