import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/core/core.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/core/resources/IconBroken.dart';

import '../../core/utils/constants.dart';
import '../Home/cubit/cubit.dart';
import '../Home/cubit/states.dart';
import '../comments/comment_sheet.dart';
import '../new_post/new_post_screen.dart';
import '../story/pages/create_story.dart';
import '../story/pages/story_screen.dart';

class FeedScreen extends StatelessWidget {
  static const String RouteName = 'feeds';

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // SocialCubit.get(context).GetComments('mKhmDvZm7AbPcwe6uPlr');
        return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var model = SocialCubit.get(context).model;
              var storymodel = SocialCubit.get(context).stories;
              return Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  ConditionalBuilder(
                    condition: SocialCubit.get(context).stories.isNotEmpty,
                    builder: (BuildContext context) {
                      return Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Stack(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: AlignmentDirectional.bottomStart,
                                    children: [
                                      Stack(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          CircleAvatar(
                                              radius: 32,
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(model
                                                        ?.image ??
                                                    "https://img.freepik.com/free-photo/young-student-woman-with-backpack-bag-holding-hand-with-thumb-up-gesture-isolated-white-wall_231208-11498.jpg?w=996&t=st=1669296316~exp=1669296916~hmac=783161709f71002b0e0825e73eea54c12d0d9a7157be9658d3b3fe3d05c51215"),
                                                backgroundColor:
                                                    Colors.deepPurple.shade300,
                                                radius: 32,
                                              )),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  CreateStoryScreen.RouteName);
                                            },
                                            icon: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: CircleAvatar(
                                                  backgroundColor: Colors
                                                      .grey.shade400
                                                      .withOpacity(0.8),
                                                  radius: 15,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                    size: 19,
                                                  )),
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                                Text("You")
                              ],
                            )),
                            Expanded(
                              flex: 4,
                              child: ListView.builder(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shrinkWrap: true,
                                  itemCount: storymodel.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, StoryScreen.RouteName);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 4),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  storymodel[index]
                                                          .avatarImage ??
                                                      ""),
                                              backgroundColor:
                                                  KPrimaryColor.withOpacity(.5),
                                              radius: 32,
                                            ),
                                          ),
                                          Text(
                                              storymodel[index].name ?? "Name ")
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    },
                    fallback: (context) => Center(
                        child: LoadingAnimationWidget.inkDrop(
                      color: KPrimaryColor.withOpacity(.8),
                      size: 32,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  InkWell(
                                    child: CircleAvatar(
                                        backgroundColor:
                                            KPrimaryColor.withOpacity(.5),
                                        radius: 25,
                                        backgroundImage: NetworkImage(model
                                                ?.image ??
                                            "https://img.freepik.com/free-photo/young-student-woman-with-backpack-bag-holding-hand-with-thumb-up-gesture-isolated-white-wall_231208-11498.jpg?w=996&t=st=1669296316~exp=1669296916~hmac=783161709f71002b0e0825e73eea54c12d0d9a7157be9658d3b3fe3d05c51215")),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ProfileScreen.RouteName);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    child: Container(
                                      height: 45,
                                      width: 260,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        child: Text(
                                          'write a Post...',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                  height: 1.4,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, NewPostScreen.RouteName);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              child: const Icon(
                                IconBroken.Image,
                                size: 36,
                                color: KPrimaryColor,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, NewPostScreen.RouteName);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: ConditionalBuilder(
                      condition: SocialCubit.get(context).posts.isNotEmpty,
                      builder: (context) => SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[300],
                              ),
                            ),
                            ListView.separated(
                              itemBuilder: (context, index) => buildPostItem(
                                  SocialCubit.get(context).posts[index],
                                  context,
                                  index),
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 8,
                              ),
                              itemCount: SocialCubit.get(context).posts.length,
                              shrinkWrap: true,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) => Center(
                          child: LoadingAnimationWidget.inkDrop(
                        color: KPrimaryColor.withOpacity(.8),
                        size: 32,
                      )),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }

  Widget buildPostItem(PostModel postModel, context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          shadowColor: Colors.indigo,
          color: Theme.of(context).backgroundColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).backgroundColor,
                        radius: 25,
                        backgroundImage:
                            NetworkImage(postModel.avatarImage ?? ""),
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
                                postModel.name ?? "",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // Icon(
                              //   Icons.check_circle,
                              //   color: Colors.blue,
                              //   size: 16,
                              // )
                            ],
                          ),
                          Text(
                            // postModel.dateTime ??
                            "1h",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    height: 1.4,
                                    color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.more_horiz,
                    //       size: 16,
                    //     ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Text(postModel.text ?? "",
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(
                  height: 30,
                ),
                if (postModel.postImage != '')
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(postModel.postImage ?? ""),
                          fit: BoxFit.cover,
                        )),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                InkWell(
                                  child: Icon(
                                    IconBroken.Heart,
                                    size: 16,
                                    color: KPrimaryColor,
                                  ),
                                  onTap: () {
                                    SocialCubit.get(context).LikePost(
                                        SocialCubit.get(context)
                                            .postsId[index]);
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '0',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  IconBroken.Chat,
                                  size: 16,
                                  color: KPrimaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ' Comment',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            openBottomSheet(context, index);
                            // SocialCubit.get(context).GetComments(
                            //     SocialCubit.get(context).postsId[index]);
                            // Navigator.pushNamed(
                            //     context, CommentSheet.RouteName);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 10),
                //   child: Container(
                //     width: double.infinity,
                //     height: 1,
                //     color: Colors.grey[300],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );

  void openBottomSheet(context, index) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return CommentSheet(index);
      },
    );
  }
}
