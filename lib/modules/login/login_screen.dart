import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Home/layout.dart';
import '../Register/Register_screen.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String RouteName = 'login';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool securedPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              Navigator.pushReplacementNamed(context, Layout.RouteName);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        Text('Login now to Contact With friends',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            onChange: () {},
                            validator: (String? text) {
                              if (text!.isEmpty) {
                                return 'please enter Your Email';
                              }
                              return null;
                            },
                            label: 'Email',
                            prefix: Icons.email),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            onChange: () {},
                            validator: (String? text) {
                              if (text!.isEmpty) {
                                return 'please enter Your password';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: true,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState?.validate() ==
                                      true) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                    //  Navigator.pushReplacementNamed(context, HomeScreen.RouteName);

                                  }
                                },
                                text: 'Login',
                                background: Colors.black),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You Don\'t have an Account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 17),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RegisterScreen.RouteName);
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.redAccent),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
