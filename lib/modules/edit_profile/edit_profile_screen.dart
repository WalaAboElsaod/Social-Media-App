import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/components/componants.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';
import 'package:social_media_app/styles/colors.dart';
import 'package:social_media_app/styles/icon_broken.dart';
import 'package:social_media_app/widgets/custom_Button_login.dart';
import 'package:social_media_app/widgets/custom_rounded_fieled.dart';

class EditProfile extends StatelessWidget {
  var bioController = TextEditingController();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).image;
          var coverImage = SocialCubit.get(context).Cover;
          nameController.text = model.name;
          bioController.text = model.bio;
          phoneController.text = model.phone;

          return Scaffold(
            appBar:
                defultAppBar(context: context, title: 'Edit Profile', actions: [
              defultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: 'UPDATE'),
              SizedBox(
                width: 15,
              ),
            ]),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialUserUpdateLoadingState)
                      LinearProgressIndicator(),
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: coverImage == null
                                                ? NetworkImage('${model.cover}')
                                                : FileImage(coverImage)
                                                    as ImageProvider,
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        )),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .getCoverImage();
                                      },
                                      icon: CircleAvatar(
                                          radius: 20.0,
                                          child: Icon(IconBroken.Camera))),
                                ]),
                          ),
                          Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64.0,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    backgroundImage: profileImage == null
                                        ? NetworkImage('${model.image}')
                                        : FileImage(profileImage)
                                            as ImageProvider,
                                    radius: 60.0,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .getProfileImage();
                                    },
                                    icon: CircleAvatar(
                                        radius: 20.0,
                                        child: Icon(IconBroken.Camera))),
                              ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    if (SocialCubit.get(context).image != null ||
                        SocialCubit.get(context).Cover != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (SocialCubit.get(context).image != null)
                            Expanded(
                              child: Column(
                                children: [
                                  CustomButton(
                                    function: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text);
                                    },
                                    radius: 10,
                                    width: size.width * .4,
                                    text: 'Upload Image',
                                    background: Colors.orangeAccent,
                                    isUpperCase: false,
                                    height: 35,
                                  ),
                                  if (state is SocialUserUpdateLoadingState)
                                    SizedBox(height: 10.0),
                                  if (state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          SizedBox(width: 10.0),
                          if (SocialCubit.get(context).Cover != null)
                            Expanded(
                              child: Column(
                                children: [
                                  CustomButton(
                                    function: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    radius: 10,
                                    width: size.width * .4,
                                    text: 'Upload Cover',
                                    background: Colors.purple,
                                    isUpperCase: false,
                                    height: 35,
                                  ),
                                  if (state is SocialUserUpdateLoadingState)
                                    SizedBox(height: 10.0),
                                  if (state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    SizedBox(height: 20.0),
                    Container(
                        width: size.width * .9,
                        child: CostumFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          prefix: Icons.person,
                          iconcolor: iconColor,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return (' Please enter your Name');
                            }
                            return null;
                          },
                          onSubmit: (String value) {
                            print(value);
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: size.width * .9,
                        child: CostumFormField(
                          controller: bioController,
                          type: TextInputType.text,
                          label: 'Bio',
                          prefix: IconBroken.Info_Circle,
                          iconcolor: iconColor,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return (' Please enter your Bio');
                            }
                            return null;
                          },
                          onSubmit: (String value) {
                            print(value);
                          },
                          isPassword: false,
                        )),
                    SizedBox(height: 20.0),
                    Container(
                        width: size.width * .9,
                        child: CostumFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: (IconBroken.Call),
                          iconcolor: iconColor,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return (' Please enter your Phone');
                            }
                            return null;
                          },
                          onSubmit: (String value) {
                            print(value);
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
