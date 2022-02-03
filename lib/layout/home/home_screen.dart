import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Modules/new_post/newpost_screen.dart';
import 'package:social_media_app/components/componants.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';
import 'package:social_media_app/styles/icon_broken.dart';
import 'package:social_media_app/widgets/custom_text.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }

      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            ],
            title: CustomText(
              text: cubit.titles[cubit.currentIndex],
              alignment: Alignment.topLeft,
            ),
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'User'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Setting'),
            ],
          ),
          // Conditional.single(
          //     context: context,
          //   conditionBuilder:(BuildContext context)=>
          //       SocialCubit.get(context).model !=null
          //   ,
          //   widgetBuilder:(BuildContext context)
          //   {
          //     var model =SocialCubit.get(context).model;
          //      return
          //        Column(
          //     children: [
          //       if(!FirebaseAuth.instance.currentUser!.emailVerified
          //
          //       )
          //       Container(
          //
          //         color: Colors.amber.withOpacity(.6),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 20.0
          //           ),
          //           child: Row(
          //             children: [
          //               Icon(
          //                 Icons.info_outline,
          //               ),
          //               SizedBox(
          //                 width: 15,
          //               ),
          //               Expanded(
          //                 child: CustomText(
          //                     color: Colors.black,
          //
          //                     text: 'please verify your email',
          //                     fontsize: 16,
          //                     alignment: Alignment.topLeft),
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               defultTextButton(function: () {
          //                 FirebaseAuth.instance.currentUser!.sendEmailVerification()
          //
          //                     .then((value) =>{
          //                       showToast(text: 'check your mail', state: ToastState.SUCCESS),
          //                 }).catchError((error){});
          //               }, text: 'send ')
          //             ],
          //           ),
          //         ),
          //       )
          //     ],
          //   );
          //   },
          //     fallbackBuilder: (BuildContext context) =>
          //         Center(
          //           child: CircularProgressIndicator(),
          //         )
          // ),
        );
      },
    );
  }
}
