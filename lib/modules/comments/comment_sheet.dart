import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../Home/cubit/cubit.dart';
import '../Home/cubit/states.dart';
import '../profile/profile_screen.dart';

class CommentSheet extends StatelessWidget {
  static const String RouteName = 'CommentSheet';
  int index;
  CommentSheet(this.index);

  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: FractionallySizedBox(
              heightFactor: 0.95,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: SocialCubit.get(context).comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CommentItem();
                        },
                      ),
                    ),
                    Divider(),
                    Container(
                      height: 65,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                hoverColor: KPrimaryColor,
                                focusColor: KPrimaryColor,
                                hintText: 'Write a comment...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: KPrimaryColor,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                var now = DateTime.now();

                                SocialCubit.get(context).CreateComment(
                                    dateTime: now.toString(),
                                    text: commentController.text,
                                    postId: SocialCubit.get(context)
                                        .postsId[index]);
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class CommentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: InkWell(
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
                        height: 60,
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
                                SocialCubit.get(context).model?.name ??
                                    "sabah mohamed",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  SocialCubit.get(context).comment[0].text ??
                                      "",
                                  style: Theme.of(context).textTheme.subtitle1),
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
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    height: 1.4,
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "like",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    height: 1.4,
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Reply",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    height: 1.4,
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
