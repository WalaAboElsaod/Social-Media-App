
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_media_app/Modules/auth/login/login_screen.dart';
import 'package:social_media_app/Modules/auth/sign_up/cubit/register_cubit.dart';
import 'package:social_media_app/Modules/auth/sign_up/cubit/register_states.dart';
import 'package:social_media_app/layout/home/home_screen.dart';
import 'package:social_media_app/components/componants.dart';

import 'package:social_media_app/styles/colors.dart';
import 'package:social_media_app/widgets/custom_Button_login.dart';
import 'package:social_media_app/widgets/custom_rounded_fieled.dart';
import 'package:social_media_app/widgets/custom_text.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  var emailContrller = TextEditingController();

  var passwordContrller = TextEditingController();
  var phoneContrller = TextEditingController();

  var NameContrller = TextEditingController();
  var confirmContrller = TextEditingController();
  var formKey= GlobalKey<FormState>();
  bool ispasswordd = false;



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return



      SingleChildScrollView(

      child: BlocProvider(
        create: (context) => SocialRegisterCubit(),


        child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if(
          state is SocialCreateUserSuccessState
          ){
            navigateAndFinish(context, SocialLayout());
          }
        },

          builder: ( context,state ){
            return  Form(
              key: formKey,
              child: Column(children: [
                SizedBox(
                  height: 60,
                ),
                CustomText(
                  text: 'Let\'s Get started !',alignment: Alignment.center,color: Colors.black,fontsize: 30,isBold: true,

                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Create an account to get all features',alignment: Alignment.center,color: Colors.grey,fontsize: 15,isBold: false,

                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: size.width * .9,
                    child: CostumFormField(
                      onsaved: (value){
                        // NameContrller.text=
                        //
                         SocialRegisterCubit.get(context).name= value;

                      },

                      controller: NameContrller,
                      type: TextInputType.name,
                      label: 'Name',
                      prefix: Icons.person,
                      iconcolor: iconColor,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return (' Please enter your email address');
                        }
                      },
                      onSubmit: (String value) {
                        print(value);
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: size.width * .9,
                    child: CostumFormField(
                      onsaved: (value){
                         SocialRegisterCubit.get(context).email= value;

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
                  height: 20,
                ),
                Container(
                    width: size.width * .9,
                    child: CostumFormField(
                      onsaved: (val){
                         SocialRegisterCubit.get(context).phone= val;

                      },
                      controller: phoneContrller,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icons.phone_android,
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
                  height: 20,
                ),
                Container(
                    width: size.width * .9,
                    child:

                    CostumFormField (
                      onsaved: (value){
                        SocialRegisterCubit.get(context).password= value;

                      },

                      controller: passwordContrller,
                      iconcolor: iconColor,
                      type: TextInputType.visiblePassword,
                      label: 'Password',
                      prefix: Icons.lock,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return (' Please enter your password');
                        }
                      },
                      onSubmit: (String value) {
                        print(value);
                      },
                      suffix:
                      ispasswordd ? Icons.visibility : Icons.visibility_off,
                      isPassword: ispasswordd,
                      suffixpressed: () {
                        setState(() {
                          ispasswordd = !ispasswordd;
                        });
                      },
                    )),          SizedBox(
                  height: 20,
                ),

                // Container(
                //     width: size.width * .9,
                //     child: CostumFormField(
                //       onChange: (){},
                //
                //
                //       // controller: confirmContrller,
                //       type: TextInputType.visiblePassword,
                //       label: 'Confirm Password',
                //       prefix: Icons.lock,
                //       iconcolor: iconColor,
                //       validate: (String? value) {
                //         if (value!.isEmpty) {
                //           return (' Please enter your email address');
                //         }
                //         return null;
                //       },
                //       onSubmit: (String value) {
                //         print(value);
                //       },
                //       isPassword: false,
                //     )),//password
                SizedBox(
                  height: 20,
                ),
              Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) => state is! SocialRegisterLoadingState,
                widgetBuilder: (BuildContext context) =>  CustomButton(background: Colors.orangeAccent,

                  function: () {
                    formKey.currentState!.save();


                    if (formKey.currentState!.validate()) {
                      SocialRegisterCubit.get(context).userRegister(


                      );
                    }
                  },

                  text: 'Sign Up',
                  width: size.width * .4,
                  radius: 30, isUpperCase: true,),

                fallbackBuilder: (BuildContext context) =>
                    Center(child: CircularProgressIndicator()),


                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(30)),

                    Text('Already have an account? ',style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15
                    ),),



                    GestureDetector(
                        onTap: (){

                          navigateTo(context, LoginScreen());

                        },
                        child:Text('Login'
                          ,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: defultColor),
                        )
                    ),


                  ],

                ),

              ]),
            );
          },
        ),
      ),
    );
  }
}
