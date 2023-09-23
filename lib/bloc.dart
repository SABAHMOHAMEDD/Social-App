import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/check_internet_connection/cubit/internet_cubit.dart';
import 'package:social_app/modules/Home/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/my_chats/cubit/private_chats_cubit.dart';

class GenerateMultiBloc extends StatelessWidget {
  final Widget child;

  const GenerateMultiBloc({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => PrivateChatsCubit()),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..GetUserData()
            ..GetPosts()
            ..GetStories(),
        ),
        BlocProvider(create: (context) => InternetCubit()..checkConnection())
      ],
      child: child,
    );
  }
}
