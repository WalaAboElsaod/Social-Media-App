import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/Modules/chats/chats_screen.dart';
import 'package:social_media_app/Modules/feeds/feeds_screen.dart';
import 'package:social_media_app/Modules/new_post/newpost_screen.dart';
import 'package:social_media_app/Modules/settings/settings_screen.dart';
import 'package:social_media_app/Modules/users/users_screen.dart';
import 'package:social_media_app/components/constant/constant.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/model/comment_model.dart';
import 'package:social_media_app/model/message_model.dart';
import 'package:social_media_app/model/post_model.dart';
import 'package:social_media_app/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context)=>BlocProvider.of(context);
 late SocialUserModel userModel;
  void getUserData(){
    emit(SocialGetUserLoadingStateStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print('   ddddddddddddd      ${value.data()}');

      userModel = SocialUserModel.fromJson(value.data()!);

      emit(SocialGetUserSuccessStateStates());

    }).catchError((eror){
      print('ERRRRRRRRRRRRRRRRR      ${eror.toString()}');
      emit(SocialGetUserErrorStateStates(eror));

    });
  }
int currentIndex=0;
  List<Widget>screen=[
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),

  ];
  List<String>titles=[
    'Home',
    'Chat',
    'Post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index){
    if(index ==1)
      getUsers();
    if(index==2)

        emit(SocialNewPostState());

    else{
      currentIndex=index;
      emit(SocialChangeBottomNavState());

    }
  }


  File? image;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile !=null) {
      image =File(pickedFile.path);
      emit(SocialImageSuccessState());

    }
    else{
       emit(SocialImageErrorState());
       print('no image selected');

    }
  }
File? Cover;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile !=null) {
      Cover =File(pickedFile.path);
      emit(SocialCoverSuccessState());

    }
    else{
       emit(SocialCoverErrorState());
       print('no image selected');
    }
  }

  void uploadProfileImage ({
    required String name,
    required String phone,
    required String bio,
}){
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(image!.path).
    pathSegments.last}').
    putFile(image!).then((value) {
      value.ref.getDownloadURL().then((value) {
       // emit(SocialUploadImageSuccessState());

        print(value);
        updateUser(name: name, phone: phone, bio: bio,image: value);



      }).catchError((error){
     emit  ( SocialUploadImageErrorState());
      });
    }).catchError((error){
      emit  ( SocialUploadImageErrorState());

    });


  }

  void uploadCoverImage (
      {
        required String name,
        required String phone,
        required String bio,
      }
      ){
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(Cover!.path).
    pathSegments.last}').
    putFile(Cover!).then((value) {
      value.ref.getDownloadURL().then((value) {
      //  emit(SocialUploadCoverSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error){
     emit  ( SocialUploadCoverErrorState());
      });
    }).catchError((error){
      emit  ( SocialUploadCoverErrorState());

    });


  }


  //....................................................................................................................................

  File? postImaage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile !=null) {
      postImaage =File(pickedFile.path);
      emit(SocialPostImageSuccessState ());

    }
    else{
      emit(SocialPostImageErrorState());
      print('no image selected');
    }
  }

  //....................................................................................................................................
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover ,
    String? image ,

  }){

    SocialUserModel model=SocialUserModel(

      name: name,
      phone: phone,
      bio: bio,

      image: image??userModel.image ,
      email: userModel.email ,
      cover:cover?? userModel.cover ,
      uId:userModel.uId ,


      isEmailVerified:false,


    );


    FirebaseFirestore.instance.collection('users').doc(userModel.uId)
        .update(model.toMap()).then((value) {
      getUserData();
    }).
    catchError((error){
      emit (SocialUserUpdateErrorState());
    });
  }




  //.....................................................................................................................


  // ignore: non_constant_identifier_names
  void uploadPostImage (
      {

        required String dateTime,
        required String text,
      }
      ){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postImaage!.path).
    pathSegments.last}').
    putFile(postImaage!).then((value) {
      value.ref.getDownloadURL().then((value) {
      //  emit(SocialUploadCoverSuccessState());
        print(value);
        createPost(dateTime: dateTime, text: text
        ,postImage: value,

        );
      }).catchError((error){
     emit  ( SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit  ( SocialCreatePostErrorState());

    });


  }

  //....................................................................................................................................
  void createPost({

    required String dateTime,
    required String text,
    String?postImage ,

  }){
    emit(SocialCreatePostLoadingState());


    SocialPostModel model= SocialPostModel(

        name: userModel.name ,
       image: userModel.image ,
        uId:userModel.uId ,

        dateTime: dateTime,
        text: text,
          postImage:postImage??'',




      );


      FirebaseFirestore.instance
          .collection('posts')

          .add(model.toMap()).then((value) {
            emit(SocialCreatePostSuccessState());
      }).
      catchError((error){
        emit (SocialCreatePostErrorState());
      });
    }

 // }............................................................................................................
void removePostImage(){
    postImaage=null;
    emit(SocialRemovePostImageState());
}
List<SocialPostModel> posts=[];
List<String> PostsId=[];
List<int> likes=[];
// List<int> comments=[];
void getPosts(){
    FirebaseFirestore.instance.collection('posts').get().then((value)

    {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          PostsId.add(element.id);
          posts.add(SocialPostModel.fromJson(element.data()));
        }).catchError((error){});

      print ( element.id);


      }


      );
      emit(SocialGetPostsSuccessStateStates());
    })
        .catchError((error){
          emit(SocialGetPostsErrorStateStates(error.toString()));
    });
}
void likePost(String postId){
  FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes')
      .doc(userModel.uId).set({
    'like':true
  }).then((value) {
   emit (SocialGetLikePostSuccessStateStates());
  }).catchError((error){
    emit (SocialGetLikePostErrorStateStates(error));

  });
}
// void commentPost(String postId){
//   FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments')
//       .doc(userModel.uId).set({
//            'image':userModel.image,
//             'Modules.comment' :'عااااش'
//   }).then((value) {
//    emit (SocialGetCommentPostSuccessStateStates());
//   }).catchError((error){
//     emit (SocialGetCommentPostErrorStateStates(error));
//
//   });
// }

List<SocialUserModel> users=[];
void getUsers (){
  if(users.length==0) {
      emit(SocialGetAllUsersLoadingStateStates());

      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] !=userModel.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });

        emit(SocialGetAllUsersSuccessStateStates());
      }).catchError((error) {
        print('errrrrrrrrrrrrrrrorrrrrrrr           ${error}');
        emit(SocialGetAllUsersErrorStateStates(error.toString()));
      });
    }
  }



  void sendMessage({
 required String receiverId,
 required String dateTime,
 required String text,
}){
  MessageModel model =MessageModel(

      senderId: userModel.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text);
  //set my chats


  FirebaseFirestore
      .instance.collection('users').
  doc(userModel.uId).
  collection('chats').
  doc(receiverId)
      .collection('messages')
      .add(model.toMap()).then((value) {
        emit(SocialSendMessageSuccessState());
  }).
  catchError((error) {
    emit(SocialSendMessageErrorState());

    //set receiver chats
  }
  );

  FirebaseFirestore
      .instance.collection('users').
  doc(receiverId).
  collection('chats').
  doc(userModel.uId)
      .collection('messages')
      .add(model.toMap()).then((value) {
    emit(SocialSendMessageSuccessState());
  }).
  catchError((error) {
    emit(SocialSendMessageErrorState());
  });
  }

List<MessageModel>messages=[];
void  getMessages ({ required String receiverId,}

  ){
  FirebaseFirestore.instance.collection('users')
      .doc(userModel.uId).collection('chats').doc(receiverId).collection('messages')
      .orderBy('dateTime').
  snapshots().listen((event) {
    messages=[];
    event.docs.forEach((element) {
      messages.add(MessageModel.fromJson(element.data()));
    });
    emit(SocialGetMessageSuccessState());

  });
  
}

CommentDataModel?commentDataModel;


  List<CommentDataModel>comments=[];

void createComment({
  required String postId,
  // required String dataTime,
  required String createAt,
  required String commentText,
  String? userProfileImageUrl,
  String? userName,
  String? userId,
}){
  CommentDataModel commentDataModel =CommentDataModel(
  postUid: postId,
    // dateTime: dataTime,
    createAt: createAt,
    commentText: commentText,
    userProfileImageUrl: userModel.image.toString(),
    username:  userModel.name,
     userUId: FirebaseAuth.instance.currentUser!.uid,
  );
  FirebaseFirestore.instance
  .collection('posts')
  .doc(postId)
  .collection('comments')
  .add(commentDataModel.toMap()).
  then((value) {
    SocialCreateCommentPostSuccessStateStates();

  }).catchError((erorr){
    SocialCreateCommentPostErrorStateStates(erorr);
  });




}




void getComments({
  String? postUid,
})

{
  FirebaseFirestore.instance
      .collection('posts').
  doc(postUid).collection('comments').
  orderBy('createAt').
  snapshots().listen((event) {
    comments=[];
    event.docs.forEach((element) {
      comments.add(CommentDataModel.fromJson(element.data()));
      emit(SocialGetCommentPostSuccessStateStates());
    });
  });
}













}

