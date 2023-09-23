import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/core/core.dart';
import 'package:social_app/core/utils/constants.dart';
import 'package:social_app/modules/Home/cubit/cubit.dart';
import 'package:social_app/modules/Home/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/core/resources/IconBroken.dart';

import '../../models/post_model.dart';
import '../comments/comment_sheet.dart';
import '../feeds/feeds_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String RouteName = 'profile';

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        Size screenSize = MediaQuery.of(context).size;

        return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 225,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                width: double.infinity,
                                height: 170,
                                decoration: BoxDecoration(
                                    color: KPrimaryColor.withOpacity(.25),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4),
                                        topLeft: Radius.circular(4)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          SocialCubit.get(context)
                                              .model!
                                              .cover!),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: CircleAvatar(
                                radius: 64,
                                backgroundColor: KPrimaryColor.withOpacity(0.4),
                                child: CircleAvatar(
                                  backgroundColor:
                                      KPrimaryColor.withOpacity(0.5),
                                  radius: 61,
                                  backgroundImage: NetworkImage(
                                      SocialCubit.get(context).model!.image!),
                                ),
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            SocialCubit.get(context).model!.name ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Text(
                            SocialCubit.get(context).model!.bio ?? "",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: InkWell(
                    //         child: Column(
                    //           children: [
                    //             Text('100',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    //             Text('post',style: Theme.of(context).textTheme.caption,),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: InkWell(
                    //         child: Column(
                    //           children: [
                    //             Text('100',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    //             Text('post',style: Theme.of(context).textTheme.caption,),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: InkWell(
                    //         child: Column(
                    //           children: [
                    //             Text('100',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    //             Text('post',style: Theme.of(context).textTheme.caption,),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: InkWell(
                    //         child: Column(
                    //           children: [
                    //             Text('100',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    //             Text('post',style: Theme.of(context).textTheme.caption,),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //
                    //
                    //   ],)
                    ,
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, EditProfileScreen.RouteName);
                          },
                          child: Icon(
                            IconBroken.Edit,
                            color: Colors.black,
                            size: 17,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Expanded(
                      flex: 5,
                      child: ConditionalBuilder(
                        condition:
                            SocialCubit.get(context).userposts.isNotEmpty,
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
                                    SocialCubit.get(context).userposts[index],
                                    context,
                                    index),
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 8,
                                ),
                                itemCount:
                                    SocialCubit.get(context).userposts.length,
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
                ),
              );

              if (state is GetUserSuccessState) {
              } else {
                return Scaffold(
                  body: Center(
                      child: LoadingAnimationWidget.inkDrop(
                    color: KPrimaryColor.withOpacity(.8),
                    size: screenSize.width / 12,
                  )),
                );
              }
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
