import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_media_app/Modules/chat_details/chat_details_screen.dart';
import 'package:social_media_app/components/componants.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/model/user_model.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){

      },
      builder: (context,state)=>Conditional.single(
        context: context,
        conditionBuilder: (context)=>SocialCubit.get(context).users.length > 0,
        widgetBuilder: (context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=> buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: SocialCubit.get(context).users.length),
        fallbackBuilder: (context)=>Center(child: CircularProgressIndicator())

      ),

    );
  }
  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },

    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${model.image}'),
            radius: 25.0,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style: TextStyle(height: 1.4),
          ),

        ],
      ),
    ),
  );
}

