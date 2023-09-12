import 'package:social_app/models/user_model.dart';

abstract class SocialStates {}

class IntialState extends SocialStates {}

class GetUserSuccessState extends SocialStates {
  UserModel userModel;
  GetUserSuccessState(this.userModel);
}

class GetUserLoadingState extends SocialStates {}

class GetUserErrorState extends SocialStates {
  final String error;

  GetUserErrorState(this.error);
}

class GetPostsSuccessState extends SocialStates {}

class GetPostsLoadingState extends SocialStates {}

class GetPostsErrorState extends SocialStates {
  final String error;

  GetPostsErrorState(this.error);
}
class GetUserPostsSuccessState extends SocialStates {}

class GetUserPostsLoadingState extends SocialStates {}

class GetUserPostsErrorState extends SocialStates {
  final String error;

  GetUserPostsErrorState(this.error);
}

class ChageBottomNavState extends SocialStates {}

class ProfileImagePickedByGallerySuccessState extends SocialStates {}

class ProfileImagePickedByGalleryErrorState extends SocialStates {}

class ProfileImagePickedByCamSuccessState extends SocialStates {}

class ProfileImagePickedByCamErrorState extends SocialStates {}

class CoverImagePickedByGallerySuccessState extends SocialStates {}

class CoverImagePickedByGalleryErrorState extends SocialStates {}

class CoverImagePickedByCamSuccessState extends SocialStates {}

class CoverImagePickedByCamErrorState extends SocialStates {}

class ProfileUpLoadImagePickedByGallerySuccessState extends SocialStates {}

class ProfileUpLoadImagePickedByGalleryErrorState extends SocialStates {}

class ProfileUpLoadImagePickedByCamSuccessState extends SocialStates {}

class ProfileUpLoadImagePickedByCamErrorState extends SocialStates {}

class CoverUpLoadImagePickedByGallerySuccessState extends SocialStates {}

class CoverUpLoadImagePickedByGalleryErrorState extends SocialStates {}

class CoverUpLoadImagePickedByCamSuccessState extends SocialStates {}

class CoverUpLoadImagePickedByCamErrorState extends SocialStates {}

class UpdateUserDataSuccessState extends SocialStates {}

class UpdateUserDataLoadingState extends SocialStates {}

class UpdateUserDataErrorState extends SocialStates {
  String error;

  UpdateUserDataErrorState(this.error);
}

class CreatePostSuccessState extends SocialStates {}

class CreatePostLoadingState extends SocialStates {}

class CreatePostErrorState extends SocialStates {
  String error;

  CreatePostErrorState(this.error);
}

class PostImagePickedByGallerySuccessState extends SocialStates {}

class PostUpLoadImagePickedByGallerySuccessState extends SocialStates {}

class PostUpLoadImagePickedByGalleryErrorState extends SocialStates {}

class PostUpLoadImagePickedByGalleryLoadingState extends SocialStates {}






class StoryImagePickedByGallerySuccessState extends SocialStates {}
class StoryUpLoadImagePickedByGallerySuccessState extends SocialStates {}

class StoryUpLoadImagePickedByGalleryErrorState extends SocialStates {}

class StoryUpLoadImagePickedByGalleryLoadingState extends SocialStates {}



class RemoveImagePostState extends SocialStates {}
class RemoveImageStoryState extends SocialStates {}

class GetAllUsersInitState extends SocialStates {}

class GetAllUsersLoadingState extends SocialStates {}

class GetAllUsersSuccessState extends SocialStates {}

class GetAllUsersFailureState extends SocialStates {
  String? errorMessage;

  GetAllUsersFailureState({required this.errorMessage});
}

class CreateCommentSuccessState extends SocialStates {}

class CreateCommentLoadingState extends SocialStates {}

class CreateCommentErrorState extends SocialStates {
  String error;

  CreateCommentErrorState(this.error);
}

class GetCommentSuccessState extends SocialStates {}

class GetCommentLoadingState extends SocialStates {}

class GetCommentErrorState extends SocialStates {
  String error;

  GetCommentErrorState(this.error);
}

class LikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {
  String error;

  LikePostErrorState(this.error);
}



class CreateStorySuccessState extends SocialStates {}

class CreateStoryLoadingState extends SocialStates {}

class CreateStoryErrorState extends SocialStates {
  String error;

  CreateStoryErrorState(this.error);
}



class GetStorySuccessState extends SocialStates {}

class GetStoryLoadingState extends SocialStates {}

class GetStoryErrorState extends SocialStates {
  final String error;

  GetStoryErrorState(this.error);
}