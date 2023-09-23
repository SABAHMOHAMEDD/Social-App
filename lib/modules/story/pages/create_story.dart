import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/core.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../../../shared/components/components.dart';
import '../../../core/resources/IconBroken.dart';
import '../../Home/cubit/cubit.dart';
import '../../Home/cubit/states.dart';
import '../../Home/layout.dart';

class CreateStoryScreen extends StatelessWidget {
  static const String RouteName = 'CreateStoryScreen';
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is CreateStorySuccessState) {
        SocialCubit.get(context).GetStories();

        showSnackBar(context, "Story Added Successfully");

        Navigator.pushNamed(context, Layout.RouteName);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: defaultAppBar(
            context: context,
            // title: 'Create Story',
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                size: 28,
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  var now = DateTime.now();

                  if (SocialCubit.get(context).storyImage != null) {
                    SocialCubit.get(context).UploadStoryImage(
                        dateTime: now.toString(), text: textController.text);
                  } else {
                    SocialCubit.get(context).CreateStory(
                        dateTime: now.toString(), text: textController.text);
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 16, color: Colors.green.shade300),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ]),
        body: Column(
          children: [
            if (state is CreateStoryLoadingState ||
                state is StoryUpLoadImagePickedByGalleryLoadingState)
              LinearProgressIndicator(
                color: KPrimaryColor,
              ),
            // if(state is CreatePostLoadingState)

            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                    hintText: 'What is in your mind...',
                    border: InputBorder.none),
              ),
            ),
            if (SocialCubit.get(context).storyImage != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Stack(alignment: AlignmentDirectional.topEnd, children: [
                    Container(
                      width: double.infinity,
                      height: 360,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(
                                SocialCubit.get(context)!.storyImage!),
                            fit: BoxFit.cover,
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removeStoryImage();
                      },
                      icon: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.7),
                          radius: 15,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                    )
                  ]),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        SocialCubit.get(context).getStoryImageByGallery();
                      },
                      child: Column(
                        children: [
                          Icon(
                            IconBroken.Image,
                            color: KPrimaryColor,
                          ),
                          Text('Add Photo',
                              style: TextStyle(color: KPrimaryColor))
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
