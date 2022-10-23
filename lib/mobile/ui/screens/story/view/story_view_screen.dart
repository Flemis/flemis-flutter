import 'package:flemis/mobile/models/Story.dart';
import 'package:flutter/material.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({super.key, this.stories});
  final List<Story>? stories;

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
