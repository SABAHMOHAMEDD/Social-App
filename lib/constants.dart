import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';


const String KLogo = "assets/images/lovemessage.png";
const String usersCollection = "users";

const String privateChatCollection = "chats";
const String privateMessagesCollection = "messages";
const Color KPrimaryColor = Color(0xFFDBA39A);
const Color KSecondryColor = Color(0xFFF5EBE0);
const Color KAppBarColor = Color(0xFFF5EBE0);

const Color KScaffoldColor = Colors.white;
const String kCreatedAt = "createdAt";
final String? uId = CacheHelper.getData(key: 'uId');

void SignOut(context) async {
  await CacheHelper.init();
  final String? uId = CacheHelper.getData(key: 'uId');
  print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
  print(uId);
  print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
  await FirebaseAuth.instance.signOut();
  CacheHelper.removeData(key: 'userId');
  CacheHelper.removeData(key: 'name');
  CacheHelper.removeData(key: 'email');
  CacheHelper.removeData(key: 'userImage');
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      print("44444444444444444444444");
      print(CacheHelper.getData(key: 'uId'));
      print("44444444444444444444444");
    }
  });
  RemoveUserData();
}


void RemoveUserData() {
  FirebaseFirestore.instance
      .collection('users')
      .doc(CacheHelper.getData(key: 'uId'))
      .delete()
      .then((value) {
    print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  }).catchError((error) {
    print(error.toString());
  });
}

void removeDocument() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Specify the path to the document you want to remove
  String documentPath =
      'users/uId'; // Replace with your collection name and document ID

  // Get the reference to the document
  DocumentReference documentReference = firestore.doc(documentPath);

  // Delete the document
  documentReference.delete().then((_) {
    print('Document removed successfully.');
  }).catchError((error) {
    print('Failed to remove document: $error');
  });
}
