import 'dart:math';

class MessageModel {
 late String senderId,receiverId,dateTime,text;


  MessageModel({
    required this.senderId,
    required this.receiverId,
   required  this.dateTime,
    required this.text,

});
  MessageModel.fromJson(
      Map<String,dynamic>
  map){
    if (map==null){
      return;
    }

    senderId =map['senderId'];
    receiverId =map['receiverId'];
    dateTime =map['dateTime'];
    text =map['text'];



  }
 Map<String,dynamic>
 toMap() {
    return

    {
      'senderId':senderId,

      'receiverId':receiverId,
      'dateTime':dateTime,
      'text':text,

  };
  }
}