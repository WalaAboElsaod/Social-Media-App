import 'dart:math';

class SocialUserModel {
 late String name,phone,image,bio,cover;
 late  String email,uId;
late  bool isEmailVerified;

  SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
   required  this.uId,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
});
  SocialUserModel.fromJson(
      Map<String,dynamic>
  map){
    if (map==null){
      return;
    }
    email =map['email'];
    name =map['name'];
    phone =map['phone'];
    uId =map['uId'];
    image =map['image'];
    cover =map['cover'];
    bio =map['bio'];
    isEmailVerified =map['isEmailVerified'];


  }
 Map<String,dynamic>
 toMap() {
    return

    {
      'email':email,
      'name':name,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
  };
  }
}