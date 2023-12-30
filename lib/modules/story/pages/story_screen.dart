import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../models/story_model.dart';
import '../../Home/cubit/cubit.dart';
import '../../Home/cubit/states.dart';

class StoryScreen extends StatelessWidget {
  static const String RouteName = 'StoryScreen';

  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    var storyModel = ModalRoute.of(context)!.settings.arguments as StoryModel;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return StoryView(
          controller: controller, // pass controller here too
          repeat: false, // should the stories be slid forever
          onComplete: () {
            Navigator.pop(context);
          },
          storyItems: [
            if (storyModel.text != '')
              StoryItem.text(
                  duration: const Duration(seconds: 4),
                  title: storyModel.text ?? "",
                  textStyle: const TextStyle(
                      decoration: TextDecoration.none, fontSize: 24),
                  backgroundColor: Colors.indigo),
            if (storyModel.storyImage != '')
              StoryItem.pageImage(
                  url: storyModel.storyImage ??
                      "https://img.freepik.com/free-photo/young-student-woman-with-backpack-bag-holding-hand-with-thumb-up-gesture-isolated-white-wall_231208-11498.jpg?w=996&t=st=1669296316~exp=1669296916~hmac=783161709f71002b0e0825e73eea54c12d0d9a7157be9658d3b3fe3d05c51215",
                  controller: controller,
                  caption: storyModel.text ?? "")
          ],
        );
      },
    );
  }
}
