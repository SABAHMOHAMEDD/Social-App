import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/IconBroken.dart';
import '../Home/cubit/cubit.dart';
import '../Home/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  static const String RouteName = 'edit_profile';
  var namecontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = SocialCubit.get(context).model;
          var profileImage = SocialCubit.get(context).profileimage;
          var coverImage = SocialCubit.get(context).coverImage;
          namecontroller.text = model?.name ?? "";
          biocontroller.text = model?.bio ?? "";
          phonecontroller.text = model?.phone ?? "";
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                  size: 28,
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    SocialCubit.get(context).UpdateUserImagesOrData(
                        name: namecontroller.text,
                        phone: phonecontroller.text,
                        bio: biocontroller.text);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  ConditionalBuilder(
                                    condition: coverImage == null,
                                    builder: (context) => Container(
                                      width: double.infinity,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              topLeft: Radius.circular(4)),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage('${model?.cover}'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    fallback: (context) => Container(
                                      width: double.infinity,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              topLeft: Radius.circular(4)),
                                          image: DecorationImage(
                                            image: FileImage(coverImage!),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .getCoverImageByGallery();
                                    },
                                    icon: CircleAvatar(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.8),
                                        radius: 15,
                                        child: const Icon(
                                          IconBroken.Camera,
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                      radius: 64,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: ConditionalBuilder(
                                        condition: profileImage == null,
                                        builder: (context) => CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 61,
                                            backgroundImage: NetworkImage(
                                                '${model?.image}')),
                                        fallback: (context) => CircleAvatar(
                                            radius: 61,
                                            backgroundImage:
                                                FileImage(profileImage!)),
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .getProfileImageByGallery();
                                    },
                                    icon: Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: CircleAvatar(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.8),
                                          radius: 15,
                                          child: Icon(
                                            IconBroken.Camera,
                                            color: Colors.white,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultFormField(
                        cursorColor: Colors.black,
                        controller: namecontroller,
                        type: TextInputType.name,
                        onChange: () {},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'name can not be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: IconBroken.User),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultFormField(
                        controller: biocontroller,
                        type: TextInputType.name,
                        onChange: () {},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Bio can not be empty';
                          }
                          return null;
                        },
                        label: 'Bio',
                        prefix: IconBroken.Document),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultFormField(
                        controller: phonecontroller,
                        type: TextInputType.number,
                        onChange: () {},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'phone can not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: IconBroken.Message),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          SignOut(context);
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 45,
                          color: KPrimaryColor.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        'Sign Out',
                        style: TextStyle(color: KPrimaryColor.withOpacity(.8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
