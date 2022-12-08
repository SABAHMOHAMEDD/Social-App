import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/shared/styles/IconBroken.dart';

import '../Home/cubit/cubit.dart';
import '../Home/cubit/states.dart';

class FeedScreen extends StatelessWidget {
  static const String RouteName = 'feeds';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = SocialCubit.get(context).model;
          return ConditionalBuilder(
              condition: SocialCubit.get(context).posts.isNotEmpty,
              builder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(8),
                          elevation: 12,
                          child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: const [
                                Image(
                                  image: NetworkImage(
                                      'https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984801.jpg?w=996&t=st=1669041985~exp=1669042585~hmac=748e7a8d0f1c2a8fff614a70ceed762fd9eec62360c946ce5acbeb467d9a44ec'),
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Communicate With Friends',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
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
                                            backgroundColor: Theme.of(context)
                                                .backgroundColor,
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                model?.image ?? "")),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, ProfileScreen.RouteName);
                                        },
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        child: Container(
                                          //height: 35,
                                          width: 260,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),

                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                  child: Icon(
                                    IconBroken.Image,
                                    size: 24,
                                    color: Colors.redAccent,
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
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
                              SocialCubit.get(context).posts[index], context),
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
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
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }

  Widget buildPostItem(PostModel postModel, context) => Card(
        shadowColor: Colors.black,
        color: Theme.of(context).backgroundColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      radius: 25,
                      backgroundImage: NetworkImage(
                          SocialCubit.get(context).model?.image ?? ""),
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
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                          postModel.dateTime ?? "",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              height: 1.4,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 16,
                      ))
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
              // SizedBox(height: 5,),
              Text(postModel.text ?? "",
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(
                height: 30,
              ),
              if (postModel.postImage != '')
                Container(
                  width: double.infinity,
                  height: 370,
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
                              Icon(
                                IconBroken.Heart,
                                size: 16,
                                color: Colors.redAccent,
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
                                color: Colors.redAccent,
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
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context).model?.image ?? ""),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'write a comment',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(height: 1.4),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'like',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {},
                  )
                ],
              )
            ],
          ),
        ),
      );
}
