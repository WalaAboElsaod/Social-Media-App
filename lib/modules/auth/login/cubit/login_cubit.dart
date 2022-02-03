import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Modules/auth/login/cubit/login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);

          emit(SocialLoginSuccessState(value.user!.uid));
    })
        .catchError((eror){
          emit(SocialLoginErrorsState(eror.toString()));
    });

    // bool ispassword = true;
    // IconData suffix = Icons.visibility;
    // // ignore: non_constant_identifier_names
    // void ChangePasswordVisibility() {
    //   ispassword = !ispassword;
    //
    //   suffix = ispassword ? Icons.visibility : Icons.visibility_off_outlined;
    //   emit(SocialLoginPasswordVisibilityState());
    // }
  }
}
