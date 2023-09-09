import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryScreen extends StatelessWidget {
  static const String RouteName = 'StoryScreen';

  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return StoryView(
      controller: controller, // pass controller here too
      repeat: true, // should the stories be slid forever
      onComplete: () {},
      storyItems: [
        StoryItem.text(
            duration: const Duration(seconds: 4),
            title: 'hello ',
            textStyle:
                const TextStyle(decoration: TextDecoration.none, fontSize: 24),
            backgroundColor: Colors.indigo),
        StoryItem.text(
            duration: const Duration(seconds: 4),
            textStyle:
                const TextStyle(decoration: TextDecoration.none, fontSize: 24),
            title: 'hello',
            backgroundColor: Colors.indigo)
      ],
    );
  }
}
