import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/core.dart';
import 'package:social_app/modules/Home/cubit/cubit.dart';
import 'package:social_app/modules/Home/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/core/resources/IconBroken.dart';

import '../../core/utils/constants.dart';

class Layout extends StatelessWidget {
  static const String RouteName = 'layout';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SocialCubit.get(context);
              return Scaffold(
                // appBar: defaultAppBar(
                //
                //   context: context,
                //   // title: cubit.title[cubit.currentIndex],
                //   actions: [
                //     IconButton(
                //         onPressed: () {},
                //         icon: Icon(
                //           IconBroken.Notification,
                //           color: KPrimaryColor,
                //         )),
                //     // IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)
                //     //
                //     // ),
                //   ],
                // ),
                body: cubit.Screens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 0,
                  selectedIconTheme: IconThemeData(color: KPrimaryColor),
                  selectedItemColor: KPrimaryColor,
                  //    showUnselectedLabels: false,
                  backgroundColor: Colors.white,
                  // type: BottomNavigationBarType.shifting,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.ChangebottomNavBar(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(IconBroken.Home),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(IconBroken.Chat), label: 'Chat'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.add), label: 'Post'),

                    BottomNavigationBarItem(
                        icon: Icon(IconBroken.Profile), label: 'Profile'),
                  ],
                ),
              );
            });
      },
    );
  }
}
