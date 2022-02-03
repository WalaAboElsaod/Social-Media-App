import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/model/comment_model.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';

class CommentScreen extends StatelessWidget {
 String? postUid;
 var commentController = TextEditingController();
 CommentScreen(this.postUid);


  @override
  Widget build(BuildContext context) {
    SocialCubit cubit= SocialCubit.get(context);

    return Builder(builder: (context){
     cubit.getComments(postUid: postUid);
     return BlocConsumer<SocialCubit,SocialStates>(
       listener: ((BuildContext context,state){}

     ),
         builder: (BuildContext context,state){
       return  Scaffold(
         appBar: AppBar(
           title: const Text('Comments')
           ,

         ),
         body: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
           child: Column(children: [
             Expanded(
               child: ListView.separated(
                   itemBuilder: (BuildContext context,index){
                     return builedCommentItem(context,cubit.comments[index],index);

                   },
                   separatorBuilder: (BuildContext context,index)=>SizedBox(height: 10,),
                   itemCount: cubit.comments.length),
             ),
             Container(
               decoration: BoxDecoration(
                 border: Border.all(
                   color: Colors.blue,
                   width: 2.0
,                 ),
                 borderRadius: BorderRadius.circular(20.0),
               ),
               child: Padding(
                 padding: const EdgeInsetsDirectional.only(start: 10.0

                 ),
                 child: Row(

                   children: [
                     Expanded(child: TextFormField(
                       maxLines: null,
                       keyboardType: TextInputType.multiline,
                       controller: commentController,
                       decoration: const InputDecoration(
                         border: InputBorder.none,
                         hintText: 'Write a Modules.comment'
                       ),
                     ),


                     ),
                     MaterialButton(onPressed: (){
                       if(commentController.text.isNotEmpty){
                         cubit.createComment(
                             postId: postUid.toString(),
                             // dataTime: DateFormat.ymmmd

                             createAt: Timestamp.fromDate(DateTime.now()).toString(),
                             commentText: commentController.text
                         );
                       }

                     }
                     ,child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.blue,),
                     )
                   ],
                 ),
               ),
             ),


           ],),
         ),
       );

    },
     );
    });


  }
 Widget  builedCommentItem(BuildContext context,CommentDataModel model,index)=>
     Container(
       child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.userProfileImageUrl}'),

                radius: 25.0,


              ) ,
            SizedBox(width: 10.0),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${model.username}',
                          style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text('${model.commentText}'),

                        ],
                      ),
                    ),
                  ),


              )


            ],
          )
       ],),
     );

}
