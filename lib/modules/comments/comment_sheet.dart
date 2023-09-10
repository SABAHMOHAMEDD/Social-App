import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../shared/styles/IconBroken.dart';
import '../Home/cubit/cubit.dart';
import '../Home/cubit/states.dart';
import '../profile/profile_screen.dart';

class CommentSheet extends StatelessWidget {
  var commentController = TextEditingController();

  static const String RouteName = 'comment';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCommentItem(context, index),
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 0,
                            ),
                        itemCount: SocialCubit
                            .get(context)
                            .comments
                            .length,
                        shrinkWrap: true,
                      ),
                    ),
                    Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(
                                          SocialCubit
                                              .get(context)
                                              .model
                                              ?.image ?? ""),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 100,
                                      color: Colors.indigo,
                                      child: TextFormField(
                                        controller: commentController,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(height: 1.4),
                                      ),
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
                                    color: KPrimaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'like',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption,
                                  )
                                ],
                              ),
                              onTap: () {
                                var now = DateTime.now();

                                SocialCubit.get(context).CreateComment(
                                    dateTime: now.toString(),
                                    text: commentController.text,
                                    postId: SocialCubit
                                        .get(context)
                                        .comment[0].postId);
                              },
                            )
                          ],
                        ))
                  ],
                )),
          );
        });
  }

  Widget buildCommentItem(context, index) =>
      Padding(
        padding: const EdgeInsets.all(5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: InkWell(
                  child: CircleAvatar(
                    backgroundColor: Theme
                        .of(context)
                        .backgroundColor,
                    radius: 20,
                    backgroundImage: NetworkImage(
                        SocialCubit
                            .get(context)
                            .model
                            ?.image ?? ""),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.RouteName);
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                            Border.all(color: Colors.black54, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SocialCubit
                                    .get(context)
                                    .comment[index].name ??
                                    "sabah mohamed",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  SocialCubit
                                      .get(context)
                                      .comment[index]
                                      .text ??
                                      "its not funny 3la fkra",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            // SocialCubit.get(context)
                            //         .comment[commentIndex]
                            //         .dateTime ??
                            "now",
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                height: 1.4,
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "like",
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                height: 1.4,
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Reply",
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                height: 1.4,
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
        ]),
      );
}
