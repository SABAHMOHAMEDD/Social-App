import 'package:flutter/material.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../../modules/login/login_screen.dart';

const String usersCollection = "users";

const String privateChatCollection = "chats";
const String privateMessagesCollection = "messages";

const String kCreatedAt = "createdAt";
final String? uId = CacheHelper.getData(key: 'uId');

// it needed then function so the clear of uId done
void SignOut(context) async {
  await CacheHelper.init();
  final String? uId = CacheHelper.getData(key: 'uId');
  print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
  print(uId);
  print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      Navigator.pushNamed(context, LoginScreen.RouteName);
      print("44444444444444444444444");
      print(CacheHelper.getData(key: 'uId'));
      print("44444444444444444444444");
    }
  });
}
