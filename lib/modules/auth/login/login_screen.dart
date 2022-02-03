
import 'package:flutter/material.dart';
import 'package:social_media_app/Modules/auth/login/login_body.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoginBody(),
    );
  }
}
