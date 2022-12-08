import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Home/layout.dart';

import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  static const String RouteName = 'Register';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            {
              Navigator.pushReplacementNamed(context, Layout.RouteName);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        Text('Register now to Contact With Friends',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.grey)),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            onChange: () {},
                            validator: (String? text) {
                              if (text!.isEmpty) {
                                return 'please enter Your name';
                              }
                              return null;
                            },
                            label: 'Name',
                            prefix: Icons.person),
                        SizedBox(
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
                          height: 15,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            onChange: () {},
                            validator: (String? text) {
                              if (text!.isEmpty) {
                                return 'please enter Your phone number';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefix: Icons.phone),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: state is! RegisterLoadinState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                text: 'Register',
                                background: Colors.black),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 10,
                        ),
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
