import 'dart:math';

class CommentDataModel {
   String? username,userProfileImageUrl,userUId,
       // dateTime,
       commentText,postUid,createAt;

  CommentDataModel({
    required this.username,


    this.userUId,

    this.userProfileImageUrl,

    // this.dateTime,

    this.commentText,

    this.postUid,

    this.createAt,


  });
  CommentDataModel.fromJson(
      Map<String,dynamic>
      map){
    if (map==null){
      return;
    }
    // dateTime =map['dateTime'];
    username =map['name'];
    commentText =map['text'];
    userUId =map['uId'];
    userProfileImageUrl =map['image'];
    postUid =map['postImage'];
    createAt =map['createAt'];



  }
  Map<String,dynamic>
  toMap() {
    return

      {
        // 'dateTime':dateTime,
        'name':username,
        'text':commentText,
        'uId':userUId,
        'image':userProfileImageUrl,
        'postImage':postUid,
        'createAt':createAt,
      };
  }
}