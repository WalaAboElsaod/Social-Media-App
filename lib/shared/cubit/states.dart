abstract class SocialStates{}
class SocialInitialState extends SocialStates{}
class SocialGetUserLoadingStateStates extends SocialStates{}
class SocialGetUserSuccessStateStates extends SocialStates{}
class SocialGetUserErrorStateStates extends SocialStates{
  final String error;

  SocialGetUserErrorStateStates(this.error);
}
class SocialChangeBottomNavState extends SocialStates{}
class SocialNewPostState extends SocialStates{}
class SocialImageSuccessState extends SocialStates{}
class SocialImageErrorState extends SocialStates{}
class SocialCoverSuccessState extends SocialStates{}
class SocialCoverErrorState extends SocialStates{}
class SocialUploadImageSuccessState extends SocialStates{}
class SocialUploadImageErrorState extends SocialStates{}

class SocialUploadCoverSuccessState extends SocialStates{}
class SocialUploadCoverErrorState extends SocialStates{}
class SocialUserUpdateLoadingState extends SocialStates{}
class SocialUserUpdateErrorState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}
class SocialPostImageSuccessState extends SocialStates{}
class SocialPostImageErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}

class SocialGetPostsLoadingStateStates extends SocialStates{}
class SocialGetPostsSuccessStateStates extends SocialStates{}
class SocialGetPostsErrorStateStates extends SocialStates{
  final String error;

  SocialGetPostsErrorStateStates(this.error);
}
class SocialGetLikePostSuccessStateStates extends SocialStates{}
class SocialGetLikePostErrorStateStates extends SocialStates{
  final String error;

  SocialGetLikePostErrorStateStates(this.error);
}

class SocialCreateCommentPostSuccessStateStates extends SocialStates{}
class SocialCreateCommentPostErrorStateStates extends SocialStates{
  final String error;

  SocialCreateCommentPostErrorStateStates(this.error);
}
class SocialGetCommentPostSuccessStateStates extends SocialStates{}
class SocialGetCommentPostErrorStateStates extends SocialStates{
  final String error;

  SocialGetCommentPostErrorStateStates(this.error);
}



class SocialGetAllUsersLoadingStateStates extends SocialStates{}
class SocialGetAllUsersSuccessStateStates extends SocialStates{}
class SocialGetAllUsersErrorStateStates extends SocialStates{
  final String error;

  SocialGetAllUsersErrorStateStates(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}
