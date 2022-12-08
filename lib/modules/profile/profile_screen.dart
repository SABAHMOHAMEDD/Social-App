import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Home/cubit/cubit.dart';
import 'package:social_app/modules/Home/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/styles/IconBroken.dart';

class ProfileScreen extends StatelessWidget {
  static const String RouteName = 'profile';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = SocialCubit.get(context).model;

          return ConditionalBuilder(
              condition: SocialCubit.get(context).model != null,
              // if home data have arrived
              builder: (context) => Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            topLeft: Radius.circular(4)),
                                        image: DecorationImage(
                                          image:
                                              NetworkImage('${model?.cover}'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    radius: 64,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 61,
                                      backgroundImage:
                                          NetworkImage('${model?.image}'),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${model?.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          '${model?.bio}',
                          style: Theme.of(context).textTheme.caption,
                        ),
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
                        )
                      ],
                    ),
                  ),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }
}
