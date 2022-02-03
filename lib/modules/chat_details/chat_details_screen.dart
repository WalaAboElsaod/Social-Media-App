import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/model/message_model.dart';
import 'package:social_media_app/model/user_model.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';
import 'package:social_media_app/styles/colors.dart';
import 'package:social_media_app/styles/icon_broken.dart';
import 'package:social_media_app/widgets/custom_text.dart';

class ChatDetailsScreen extends StatelessWidget {
  var messageController =TextEditingController();
  SocialUserModel? userModel;
  ChatDetailsScreen({this.userModel});

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Builder(

        builder:(BuildContext context){
          SocialCubit.get(context).getMessages(receiverId: userModel!.uId);
          return BlocConsumer<SocialCubit, SocialStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                    appBar: AppBar(
                      titleSpacing: 0,
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(userModel!.image),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          CustomText(text: userModel!.name),
                        ],
                      ),
                    ),
                    body: Conditional.single(context: context,
                        conditionBuilder:(context)=>
                        SocialCubit.get(context).messages.length == 0 ||  SocialCubit.get(context).messages.length > 0 ,
                        widgetBuilder: (context)=>Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(

                            children: [
                              Expanded(

                                child: ListView.separated(
                                    itemBuilder: (context,index){
                                      var message=  SocialCubit.get(context).messages[index];
                                      if(SocialCubit.get(context).userModel.uId==message.senderId)
                                        {
                                          return buildMyMessage(message);
                                        }
                                      else{
                                        return buildMessage(message);
                                      }
                                    },
                                    separatorBuilder:  (context,index)=>SizedBox(height: 15,),
                                    itemCount: SocialCubit.get(context).messages.length
                                ),
                              ),
                           //   buildMessage(message),
                           //   buildMyMessage(),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: TextFormField(
                                          controller: messageController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'type your message here...'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      color: Colors.blue,
                                      child: MaterialButton(
                                        onPressed: () {
                                          SocialCubit.get(context).sendMessage(
                                              receiverId: userModel!.uId,
                                              dateTime: DateTime.now().toString(),
                                              text: messageController.text);
                                          print(userModel!.uId);


                                        },
                                        minWidth: 1.0,
                                        child: IconButton(
                                          icon: Icon(
                                            IconBroken.Send,
                                            color: Colors.white,
                                            size: 16.0,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        fallbackBuilder: (context)=>Center(child: CircularProgressIndicator()))
                );
              });
        }

    );
  }
  Widget buildMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            )),
        padding: EdgeInsets.symmetric(
            vertical: 5.0, horizontal: 10.0),
        child: CustomText(
          text: model.text,
        )),
  );

  Widget buildMyMessage(MessageModel model)=>                    Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        decoration: BoxDecoration(
            color: defultColor.withOpacity(.3),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            )),
        padding: EdgeInsets.symmetric(
            vertical: 5.0, horizontal: 10.0),
        child: CustomText(
          text: model.text,
        )),
  );


}
