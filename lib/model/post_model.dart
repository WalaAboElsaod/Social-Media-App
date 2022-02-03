import 'dart:math';

class SocialPostModel {
  late String name,image,uId,dateTime,text,postImage;

  SocialPostModel({
    required this.name,

    required  this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,


  });
  SocialPostModel.fromJson(
      Map<String,dynamic>
      map){
    if (map==null){
      return;
    }
    dateTime =map['dateTime'];
    name =map['name'];
    text =map['text'];
    uId =map['uId'];
    image =map['image'];
    postImage =map['postImage'];



  }
  Map<String,dynamic>
  toMap() {
    return

      {
        'dateTime':dateTime,
        'name':name,
        'text':text,
        'uId':uId,
        'image':image,
        'postImage':postImage,
      };
  }
}