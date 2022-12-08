import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/IconBroken.dart';
import '../Home/cubit/cubit.dart';
import '../Home/cubit/states.dart';
import '../profile/profile_screen.dart';

class NewPostScreen extends StatelessWidget {
  static const String RouteName = 'new_post';
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Create Post',
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
                            dateTime: now.toString(),
                            text: textController.text);
                      } else {
                        SocialCubit.get(context).CreatePost(
                            dateTime: now.toString(),
                            text: textController.text);
                      }
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(fontSize: 16, color: Colors.green),
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
                  LinearProgressIndicator(),
                // if(state is CreatePostLoadingState)

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).backgroundColor,
                          radius: 25,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/smiley-little-girl-red-dress_23-2148984789.jpg?w=996&t=st=1669040171~exp=1669040771~hmac=f49a41db725402bf41b6bfa0a876a5045797481003844627c66861c6b3ff1787'),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Sabah Mohamed',
                                  style: Theme.of(context).textTheme.subtitle1,
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
                  padding: const EdgeInsets.all(20),
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
                      child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 360,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: FileImage(
                                        SocialCubit.get(context)!.postImage!),
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
                              Icon(IconBroken.Image),
                              Text('Add Photo')
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(IconBroken.Profile),
                              Text('Tag People')
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
