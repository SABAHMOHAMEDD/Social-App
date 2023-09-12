import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/Register/cubit/states.dart';

import '../../../shared/network/local/cache_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit()
      : super(RegisterIntialState()); // need intial state in the super

  static RegisterCubit get(context) => BlocProvider.of(context);

  // so i dont have to intialize the cubit everyTime i use it

  bool securedPassword = true;
  IconData Suffix = Icons.visibility;

  void ChangePasswordVisibility() {
    securedPassword = !securedPassword;

    Suffix = securedPassword ? Icons.visibility_off : Icons.visibility;
    emit(RegChangePasswordVisibilityState());
  }

  // Authentication
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadinState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      CacheHelper.saveData(key: "uId", value: value.user!.uid);

      print(value.user?.uid);
      UserCreate(
          name: name,
          email: email,
          phone: phone,
          uId: CacheHelper.getData(key: 'uId')); // save data in firestore
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

// save data in firestore
  void UserCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: CacheHelper.getData(key: 'uId'),
        cover:
            'https://img.freepik.com/free-photo/young-student-woman-with-backpack-bag-holding-hand-with-thumb-up-gesture-isolated-white-wall_231208-11498.jpg?w=996&t=st=1669296316~exp=1669296916~hmac=783161709f71002b0e0825e73eea54c12d0d9a7157be9658d3b3fe3d05c51215',
        bio: 'write your bio',
        image:
            'https://img.freepik.com/free-photo/young-student-woman-with-backpack-bag-holding-hand-with-thumb-up-gesture-isolated-white-wall_231208-11498.jpg?w=996&t=st=1669296316~exp=1669296916~hmac=783161709f71002b0e0825e73eea54c12d0d9a7157be9658d3b3fe3d05c51215',
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  static showLoading(context, String loadingMessage,
      {bool isCancelabele = true}) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 12,
                ),
                Text(loadingMessage),
              ],
            ),
          );
        },
        barrierDismissible: isCancelabele);
  }
}
