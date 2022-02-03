
abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState {}

class SocialLoginLoadingState extends SocialLoginState {}

class SocialLoginSuccessState extends SocialLoginState {
final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorsState extends SocialLoginState {
  final String error;

  SocialLoginErrorsState(this.error);
}

// class SocialLoginPasswordVisibilityState extends SocialLoginState {}
