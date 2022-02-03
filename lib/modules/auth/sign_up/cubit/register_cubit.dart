import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Modules/auth/sign_up/cubit/register_states.dart';
import 'package:social_media_app/model/user_model.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  late String email;
  late String password;
  late String name;
  late String phone;
  void userRegister(
  
 
  ) {
    print('hello');
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      createUser(
        email: email,
        uId: value.user!.uid,
        phone: phone,
        name: name,


      );

    }).catchError((erorr){
      print('erorrrrrrrrrr ${erorr}');
      emit(SocialRegisterErrorsState(erorr.toString()));

    });



  }
  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uId,

  }
      )
  {
    SocialUserModel model=SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ....',
      image:'https://image.freepik.com/free-photo/smiling-girl-making-peace-gesture-with-painted-fingers-face-against-white-brick-wall_23-2148088490.jpg' ,
      cover:'https://image.freepik.com/free-photo/smiling-girl-making-peace-gesture-with-painted-fingers-face-against-white-brick-wall_23-2148088490.jpg' ,
        isEmailVerified:false,


    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error){
      print('erorr ${error}');

      emit(SocialCreateUserErrorsState(error.toString()));

    });
    
}

  bool ispassword = true;
  IconData suffix = Icons.visibility;
  // ignore: non_constant_identifier_names
  void ChangePasswordRegisterVisibility() {
    ispassword = !ispassword;

    suffix = ispassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordVisibilityState());
  }
}
