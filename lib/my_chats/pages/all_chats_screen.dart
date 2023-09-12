import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/my_chats/pages/private_chat_screen.dart';

import '../../constants.dart';
import '../../modules/Home/cubit/cubit.dart';
import '../../modules/Home/cubit/states.dart';
import '../../shared/network/local/cache_helper.dart';
import '../cubit/private_chats_cubit.dart';

class MyChatsScreen extends StatelessWidget {
  const MyChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).GetAllUsers();

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            if (state is GetAllUsersSuccessState) {
              return Scaffold(
                  body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: SocialCubit.get(context).users.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<PrivateChatsCubit>(context).GetMessages(
                          receiverId:
                              SocialCubit.get(context).users[index].uId);

                      Navigator.pushNamed(context, PrivateChatScreen.routeName,
                          arguments: SocialCubit.get(context).users[index]);
                      print(
                          'oooooooooooooooooooooooooooooooooooooooooooooooooo');
                      CacheHelper.saveData(
                          key: 'userId',
                          value: SocialCubit.get(context).users[index].uId);

                      print(CacheHelper.getData(key: 'userId'));
                      print(
                          'oooooooooooooooooooooooooooooooooooooooooooooooooo');
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: KPrimaryColor.withOpacity(0.5),
                              radius: 28,
                              backgroundImage: NetworkImage(
                                  SocialCubit.get(context).users[index].image ??
                                      ""),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      SocialCubit.get(context)
                                              .users[index]
                                              .name ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: KSecondryColor.withOpacity(0.5))),
                  );
                },
              ));
            } else {
              return Scaffold(
                body: Center(
                    child: LoadingAnimationWidget.inkDrop(
                  color: KPrimaryColor.withOpacity(.8),
                  size: screenSize.width / 12,
                )),
              );
            }
          },
        );
      },
    );
  }
}
