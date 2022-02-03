import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Modules/auth/login/login_screen.dart';
import 'package:social_media_app/layout/home/home_screen.dart';
import 'package:social_media_app/components/componants.dart';
import 'package:social_media_app/network/local/cash_helper.dart';
import 'package:social_media_app/network/remote/dio_helper.dart';
import 'package:social_media_app/shared/bloc_observer.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';
import 'package:social_media_app/styles/themes.dart';


Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('onnnnnnnnnnnnnnnnn   ${message.data.toString()}');
  showToast(text: 'ON background  message ', state: ToastState.SUCCESS);
  // // If you're going to use other Firebase services in the background, such as Firestore,
  // // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  //
  // print("Handling a background message: ${message.messageId}");
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var taken=await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'ON message ', state: ToastState.SUCCESS);

  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('dddddddattttttttttttt   ${event.data.toString()}');
    showToast(text: 'ON message opened app', state: ToastState.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  print(taken);
Widget widget;
  DioHelper.init();
  await CashHelper.init();


  Bloc.observer = MyBlocObserver();
  var uId =CashHelper.getData(key: 'uId');
  if(
  uId!=null
  ){
    widget=SocialLayout();
  }else{
    widget=LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,

  ));
}

class MyApp extends StatelessWidget {
  late Widget startWidget;
  MyApp(
     {
        required this.startWidget
     }
      );


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context)=>SocialCubit()..getUserData()..getPosts()..getUsers(),
     child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home:

         // LoginScreen (),

            startWidget,
        theme: lightTheme,


        // LoginScreen (),
      ),
    );
  }
}