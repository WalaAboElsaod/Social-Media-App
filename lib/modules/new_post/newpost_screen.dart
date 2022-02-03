import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:social_media_app/Modules/auth/login/login_screen.dart';
import 'package:social_media_app/components/componants.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';
import 'package:social_media_app/styles/icon_broken.dart';
import 'package:social_media_app/widgets/custom_text.dart';

class NewPostScreen extends StatelessWidget {
  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Builder(builder : (context)=> BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){} ,
        builder: (context,state){
          return Scaffold(
            appBar:defultAppBar(context: context,
                title: 'Create Post',
                actions: [
                  defultTextButton(
                      function: (){
                        var now = DateTime.now();

                        if(SocialCubit.get(context).postImaage==null){
                          SocialCubit.get(context).createPost(dateTime: now.toString(),
                              text: textController.text);
                        }
                        else{
                          SocialCubit.get(context).uploadPostImage(dateTime: now.toString(),
                              text: textController.text);
                        }
                      }
                      ,text: 'Post'
                  )
                ]

            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://image.freepik.com/free-photo/cheerful-attractive-little-girl-sitting-floor-with-crossed-legs-touching-floor-with-palms-looking-camera-posing-isolated-yellow-background-dresses-pale-pink-attire_176532-13691.jpg'),
                        radius: 25.0,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Asem',
                                    style: TextStyle(height: 1.4),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'Whate is on your mind....',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if(SocialCubit.get(context).postImaage!=null)

                    Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:FileImage(SocialCubit.get(context).postImaage!)
                                    ,
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(4.0),

                              )),

                          IconButton(
                              onPressed: () {
                                SocialCubit.get(context)
                                    .removePostImage();
                              },
                              icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(Icons.close))),
                        ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(onPressed: (){
                          SocialCubit.get(context).getPostImage() ;
                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5.0),
                            CustomText(
                              text: 'Add photo',
                            )
                          ],
                        )),

                      ),
                      Expanded(
                        child: TextButton(onPressed: (){
                          navigateTo(context, LoginScreen());
                        }, child:CustomText(

                          text: '# tags',
                        )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },

      ));
  }
}

