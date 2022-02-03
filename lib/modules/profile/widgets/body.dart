// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_conditional_rendering/conditional.dart';
// import 'package:social_media_app/shared.cubit/shared.cubit.dart';
// import 'package:social_media_app/shared.cubit/states.dart';
//
// class  SettingBody extends StatefulWidget {
//
//   @override
//   _SettingBodyState createState() => _SettingBodyState();
// }
//
// class _SettingBodyState extends State<SettingBody> {
//   var formKey = GlobalKey<FormState>();
//
//   var emailContrller = TextEditingController();
//
//   var nameContrller = TextEditingController();
//   var phoneContrller = TextEditingController();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//
//     return BlocConsumer<SocialCubit,SocialStates>(
//       listener: (context,state){
//
//         // if (state is ShopSuccessUserModelDataState){
//         //   nameContrller.text=state.shopUserModel.data!.name!;
//         // emailContrller .text=state.shopUserModel.data!.email!;
//         //   phoneContrller.text=state.shopUserModel.data!.phone!;
//         //}
//
//       },
//       builder: (context,state){
//         var model =SocialCubit.get(context).model;
//         nameContrller.text=model.name;
//         emailContrller.text=model.email;
//         phoneContrller.text=model.phone;
//
//
//         return
//
//           Conditional.single(
//             context: context,
//             conditionBuilder: (BuildContext context) =>
//          SocialCubit.get(context).model != null,
//
//         widgetBuilder: (BuildContext context) =>  SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(children: [
//
//               if(state is ShopLoadingUpdateUserModelDataState)
//                 LinearProgressIndicator(),
//               SizedBox(
//                   height: 20
//               ),
//
//               ProfilePic(),
//               SizedBox(
//                   height: 60
//               ),
//
//
//               Container(
//                   width: size.width * .9,
//                   child: CostumFormField(
//                     controller: nameContrller,
//                     type: TextInputType.emailAddress,
//                     label: 'Name',
//                     prefix: Icons.person,
//                     iconcolor: iconColor,
//                     validate: (String? value) {
//                       if (value!.isEmpty) {
//                         return (' Please enter your Name');
//                       }
//                       return null;
//                     },
//                     onSubmit: (String value) {
//                       print(value);
//                     },
//                   )),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                   width: size.width * .9,
//                   child: CostumFormField(
//                     controller: emailContrller,
//                     type: TextInputType.emailAddress,
//                     label: 'Email',
//                     prefix: Icons.email,
//                     iconcolor: iconColor,
//                     validate: (String? value) {
//                       if (value!.isEmpty) {
//                         return (' Please enter your email address');
//                       }
//                       return null;
//                     },
//                     onSubmit: (String value) {
//                       print(value);
//                     },
//                     isPassword: false,
//                   )),
//
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                   width: size.width * .9,
//                   child: CostumFormField(
//                     controller: phoneContrller,
//                     type: TextInputType.phone,
//                     label: 'Phone',
//                     prefix: Icons.phone_android,
//                     iconcolor: iconColor,
//                     validate: (String? value) {
//                       if (value!.isEmpty) {
//                         return (' Please enter your email address');
//                       }
//                       return null;
//                     },
//                     onSubmit: (String value) {
//                       print(value);
//                     },
//                     isPassword: false,
//                   )),
//               SizedBox(
//                 height: 20,
//               ),
//               defultButton(function: (){
//                 if(
//                 formKey.currentState!.validate()
//                 ){
//                   ShopCubit.get(context).getUpdateUserData(
//                     email: emailContrller.text,
//                     name: nameContrller.text,
//                     phone: phoneContrller.text,
//
//                   );
//
//                 }
//
//
//               }, text: 'UPDATE'),
//               SizedBox(
//                 height: 20,
//               ),
//                defultButton(function: (){
//
//                  signOut(context);
//                }, text: 'SIGIN OUT'),
//
//             ]),
//           ),
//         ),
//
//
//         fallbackBuilder: (BuildContext context) =>  Center(
//           child: CircularProgressIndicator(),
//         ));
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//       },
//
//     );
//   }
// }
