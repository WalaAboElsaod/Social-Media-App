
abstract class SocialRegisterState {}

class SocialRegisterInitialState extends SocialRegisterState {}

class SocialRegisterLoadingState extends SocialRegisterState {}

class SocialRegisterSuccessState extends SocialRegisterState {

}

class SocialRegisterErrorsState extends SocialRegisterState {
  final String error;

  SocialRegisterErrorsState(this.error);
}
class SocialCreateUserSuccessState extends SocialRegisterState {

}

class SocialCreateUserErrorsState extends SocialRegisterState {
  final String error;

  SocialCreateUserErrorsState(this.error);
}

class SocialRegisterPasswordVisibilityState extends SocialRegisterState {}
