import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Register/Register_screen.dart';
import 'package:social_app/modules/chat/chat_screen.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/theme/mytheme.dart';

import 'check_internet_connection/cubit/internet_cubit.dart';
import 'firebase_options.dart';
import 'modules/Home/cubit/cubit.dart';
import 'modules/Home/layout.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/story/story_screen.dart';
import 'my_chats/cubit/private_chats_cubit.dart';
import 'my_chats/pages/private_chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  final String? uId = CacheHelper.getData(key: 'uId');

  Widget widget;
  if (uId != null) {
    widget = Layout();
  } else {
    widget = LoginScreen();
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => LoginCubit()),

          BlocProvider(create: (BuildContext context) => PrivateChatsCubit()),
          BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..GetUserData()
              ,
          ),
    BlocProvider(create: (context) => InternetCubit()..checkConnection())

    ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.LightTheme,
          darkTheme: MyTheme.DarkTheme,
          themeMode: ThemeMode.light,
          routes: {
            LoginScreen.RouteName: (_) => LoginScreen(),
            RegisterScreen.RouteName: (_) => RegisterScreen(),
            Layout.RouteName: (_) => Layout(),
            ChatScreen.RouteName: (_) => ChatScreen(),
            SettingScreen.RouteName: (_) => SettingScreen(),
            FeedScreen.RouteName: (_) => FeedScreen(),
            ProfileScreen.RouteName: (_) => ProfileScreen(),
            NewPostScreen.RouteName: (_) => NewPostScreen(),
            EditProfileScreen.RouteName: (_) => EditProfileScreen(),
            PrivateChatScreen.routeName: (_) => PrivateChatScreen(),
            StoryScreen.RouteName: (_) => StoryScreen(),
          },
          home: startWidget,
        ));
  }
}
