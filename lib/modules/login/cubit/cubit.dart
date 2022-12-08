import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginIntialState()); // need intial state in the super

  static LoginCubit get(context) => BlocProvider.of(context);

  // so i dont have to intialize the cubit everyTime i use it

  // late LoginModel loginModel;
  bool securedPassword = true;
  IconData Suffix = Icons.visibility;

  void ChangePasswordVisibility() {
    securedPassword = !securedPassword;

    Suffix = securedPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadinState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
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
