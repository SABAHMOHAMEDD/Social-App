import 'package:flutter/material.dart';
import 'package:social_app/modules/Home/layout.dart';
import 'package:social_app/modules/Register/Register_screen.dart';
import 'package:social_app/modules/chat/chat_screen.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/story/pages/create_story.dart';
import 'package:social_app/modules/story/pages/story_screen.dart';
import 'package:social_app/my_chats/pages/private_chat_screen.dart';

Map<String, Widget Function(BuildContext)> AppRoutes = {
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
  CreateStoryScreen.RouteName: (_) => CreateStoryScreen(),
};
