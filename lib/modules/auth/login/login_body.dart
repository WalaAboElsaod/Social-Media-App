
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/Modules/auth/login/cubit/login_states.dart';
import 'package:social_media_app/Modules/auth/sign_up/sign_up_screen.dart';
import 'package:social_media_app/layout/home/home_screen.dart';
import 'package:social_media_app/components/componants.dart';

import 'package:social_media_app/network/local/cash_helper.dart';
import 'package:social_media_app/styles/colors.dart';
import 'package:social_media_app/widgets/custom_Button_login.dart';
import 'package:social_media_app/widgets/custom_button_f_g.dart';
import 'package:social_media_app/widgets/custom_rounded_fieled.dart';

import 'cubit/login_cubit.dart';

//
// class LoginBody extends StatefulWidget {
//   const LoginBody({Key? key}) : super(key: key);
//
//   @override
//   _LoginBodyState createState() => _LoginBodyState();
// }
//
// class _LoginBodyState extends State<LoginBody> {
//
//   var emailContrller = TextEditingController();
//
//   var passwordContrller = TextEditingController();
//
//   bool stc = false;
//   bool ispasswordd = false;
//   var formKey= GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//
//     return
// ignore: must_be_immutable
class LoginBody extends StatelessWidget {
  var emailContrller = TextEditingController();

  var passwordContrller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return SingleChildScrollView(
        child: BlocProvider(
            create: (context) => SocialLoginCubit(),
            child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
                listener: (context, state) {
                  if (state is SocialLoginErrorsState) {
                       showToast(text: state.error, state: ToastState.ERROR);
                  }
                  if(state is SocialLoginSuccessState){
                    CashHelper.saveData(
                        key: 'uId', value: state.uId,)
                            .then((value) {

                      navigateAndFinish(context, SocialLayout());
                    });

                  }

                  // CashHelper.saveData(
                  // key: 'taken', value: state.loginModel.data?.token)
                  //     .then((value) {
                  // taken=state.loginModel.data?.token;
                  // navigateAndFinish(context, SocialLayout());
                  // });
                  // } else {
                  // print(state.loginModel.message);

                  // showToast(
                  // text: state.loginModel.message, state: ToastState.ERROR);
                  // }
                  //  }
                },
                builder: (context, state) {
                  return
                    SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Image(
                                  image: NetworkImage(
                                      'https://image.freepik.com/free-vector/sign-page-abstract-concept-illustration_335657-3875.jpg'),
                                  // AssetImage(
                                  //   'assets/images/reg.png',
                                  // ),
                                  width: size.width * .4,
                                ),
                              ),
                              Text(
                                'Welcome back!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'log in to your existant account of Q Allure',
                                style: TextStyle(
                                  // fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              Container(
                                  width: size.width * .9,
                                  child: CostumFormField(
                                    onChange: (value){
                                      // SocialRegisterCubit.get(context).email= value;

                                    },
                                    onsaved: (value){
                                      emailContrller.text=value;
                                    },

                                    controller: emailContrller,
                                    type: TextInputType.emailAddress,
                                    label: 'Email',
                                    prefix: Icons.email,
                                    iconcolor: iconColor,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return (' Please enter your email address');
                                      }
                                    },
                                    onSubmit: (String value) {
                                      print(value);
                                    },
                                    isPassword: false,
                                  )),

                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: size.width * .9,
                                  child: CostumFormField(
                                    controller: passwordContrller,
                                    onsaved: (value){
                                      passwordContrller.text=value;
                                    },
                                    iconcolor: iconColor,
                                    type: TextInputType.visiblePassword,
                                    label: 'Password',
                                    // prefix: Icons.lock,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return (' Please enter your password');
                                      }
                                    },
                                    onSubmit: (String value) {
                                      // emailContrller.text=value;

                                    },
                                    // suffix:
                                    // ispasswordd ? Icons.visibility : Icons.visibility_off,
                                    // isPassword: ispasswordd,
                                    // suffixpressed: () {
                                    //   setState(() {
                                    //     ispasswordd = !ispasswordd;
                                    //    });
                                    // },
                                  )),

                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: Text(
                                        ' forgot password?',
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blueAccent),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ]),
                              CustomButton(background: Colors.orangeAccent,

                                function: () {

                                  formKey.currentState!.save();

                                  if (
                                  formKey.currentState!.validate()

                                 )

                                  {
                                    SocialLoginCubit.get(context).userLogin(email: emailContrller.text,
                                        password: passwordContrller.text);


                                  }
                                },

                                text: 'login',
                                width: size.width * .4,
                                radius: 30,
                                isUpperCase: true,),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                ' Or connect using',
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey[400]),
                              ),
                              SizedBox(
                                height: 20,
                              ),


                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  CustomButtonFAndG(
                                    radius: 10,
                                    function: () {},
                                    text: 'Facebook',
                                    width: size.width * .39,
                                    height: size.height * .05,
                                    background: Color(0xff375C8F),
                                    icon: FontAwesomeIcons.facebook,

                                  ),
                                  CustomButtonFAndG(
                                    radius: 10,
                                    function: () {},
                                    // icon: FontAwesomeIcons.lock,
                                    text: 'Google',
                                    width: size.width * .39,
                                    height: size.height * .05,
                                    background: Colors.orangeAccent,
                                    icon: FontAwesomeIcons.googlePlus,

                                  ),

                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.all(50)),

                                  Text('Don\'t have an account? ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15
                                    ),),


                                  GestureDetector(
                                      onTap: () {
                                        navigateTo(context, SignUPScreen());
                                      },
                                      child: Text('Sign Up'
                                        ,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: defultColor),
                                      )
                                  ),


                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                }
            )
        )
    );
  }
}