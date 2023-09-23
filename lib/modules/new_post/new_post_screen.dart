import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/core.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/show_snack_bar.dart';
import '../../shared/components/components.dart';
import '../../core/resources/IconBroken.dart';
import '../Home/cubit/cubit.dart';
import '../Home/cubit/states.dart';
import '../profile/profile_screen.dart';

class NewPostScreen extends StatelessWidget {
  static const String RouteName = 'new_post';
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is CreatePostSuccessState) {
        showSnackBar(context, "Post Added Successfully");

        SocialCubit.get(context).GetPosts();
        SocialCubit.get(context).GetUserPosts();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: defaultAppBar(
            context: context,
            // title: 'Create Post',
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

                  if (SocialCubit.get(context).postImage != null) {
                    SocialCubit.get(context).UploadPostImage(
                        dateTime: now.toString(), text: textController.text);
                  } else {
                    SocialCubit.get(context).CreatePost(
                        dateTime: now.toString(), text: textController.text);
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(fontSize: 16, color: Colors.green.shade300),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ]),
        body: Column(
          children: [
            if (state is CreatePostLoadingState ||
                state is PostUpLoadImagePickedByGalleryLoadingState)
              LinearProgressIndicator(
                color: KPrimaryColor,
              ),
            // if(state is CreatePostLoadingState)

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      radius: 25,
                      backgroundImage: NetworkImage(SocialCubit.get(context)
                              .model!
                              .image ??
                          "https://www.flaticon.com/free-icon/user_1077063?term=person&page=1&position=4&origin=search&related_id=1077063"),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, ProfileScreen.RouteName);
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              SocialCubit.get(context).model!.name ?? "",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
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
            if (SocialCubit.get(context).postImage != null)
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
                            image:
                                FileImage(SocialCubit.get(context)!.postImage!),
                            fit: BoxFit.cover,
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
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
                        SocialCubit.get(context).getPostImageByGallery();
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
                Expanded(
                  child: TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Icon(IconBroken.Profile, color: KPrimaryColor),
                          Text(
                            'Tag People',
                            style: TextStyle(color: KPrimaryColor),
                          )
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
