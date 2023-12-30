import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/Home/cubit/states.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';

import '../../../models/comment_model.dart';
import '../../../models/story_model.dart';
import '../../../my_chats/pages/all_chats_screen.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(IntialState()); // need intial state in the super

  static SocialCubit get(context) => BlocProvider.of(context);

//get user data from firebase
  UserModel? model;

  void GetUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      print(value.data());

      model = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: "uId", value: model!.uId);

      emit(GetUserSuccessState(model!));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens = [
    FeedScreen(),
    MyChatsScreen(),
    // NewPostScreen(),
    ProfileScreen(),
  ];
  // List<String> title = [
  //   'Home',
  //   'Chat',
  //   // 'Create Post',
  //   'Profile',
  // ];

  void ChangebottomNavBar(int index) {
    currentIndex = index;
    emit(ChageBottomNavState());
  }

  final picker = ImagePicker();

  File? profileimage;
  File? coverImage;

  Future<void> getProfileImageByGallery() async {
    XFile? imageFileProfile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFileProfile == null) return null;

    profileimage = File(imageFileProfile.path);
    emit(ProfileImagePickedByGallerySuccessState());
  }

  Future<void> getCoverImageByGallery() async {
    XFile? imageFileCover = await picker.pickImage(source: ImageSource.gallery);
    if (imageFileCover == null) return;
    coverImage = File(imageFileCover.path);
    emit(CoverImagePickedByGallerySuccessState());
  }
// Future<void> getProfileImageByCam() async {
  //   XFile? imageFileProfile =
  //       await picker.pickImage(source: ImageSource.camera);
  //   if (imageFileProfile == null) return;
  //   profileimage = File(imageFileProfile.path);
  //   emit(ProfileImagePickedByCamSuccessState());
  // }

  // Future<void> getCoverImageByCam() async {
  //   XFile? imageFileCover = await picker.pickImage(source: ImageSource.camera);
  //   if (imageFileCover == null) return;
  //   coverImage = File(imageFileCover.path);
  //   emit(CoverImagePickedByCamSuccessState());
  // }

  //upload image to firebase storage
  // then have the url to send it to firebase firestore in the update func
  void uploadProfileImage({
    @required name,
    @required phone,
    @required bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage?.path ?? "").pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(ProfileUpLoadImagePickedByGallerySuccessState());
        print(value);
        UpdateUser(
            name: model?.name,
            phone: model?.phone,
            bio: model?.bio,
            image: value);
      }).catchError((error) {
        emit(ProfileUpLoadImagePickedByGalleryErrorState());
      });
    }).catchError((error) {
      emit(ProfileUpLoadImagePickedByGalleryErrorState());
    });
  }

  void uploadCoverImage({
    @required name,
    @required phone,
    @required bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage?.path ?? "").pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(CoverUpLoadImagePickedByGallerySuccessState());
        print(value);
        UpdateUser(
            name: model?.name,
            phone: model?.phone,
            bio: model?.bio,
            cover: value);
      }).catchError((error) {
        emit(CoverUpLoadImagePickedByGalleryErrorState());
      });
    }).catchError((error) {
      emit(CoverUpLoadImagePickedByGalleryErrorState());
    });
  }

  void UpdateUserImagesOrData({
    @required name,
    @required phone,
    @required bio,
  }) {
    emit(UpdateUserDataLoadingState());
    if (coverImage != null) {
      //updata cover and (data if it changed)
      uploadCoverImage();
    } else if (profileimage != null) {
      //updata profile and (data if it changed)

      uploadProfileImage();
    } else if (coverImage != null && profileimage != null) {
      //updata cover and profile and (data if it changed)

      uploadCoverImage();
      uploadProfileImage();
    } else {
      UpdateUser(name: name, phone: phone, bio: bio);
    }
  }

  // update only data
  void UpdateUser({
    @required name,
    @required phone,
    @required bio,
    String? cover,
    String? image,
  }) {
    UserModel userModel = UserModel(
        name: name,
        phone: phone,
        email: model?.email,
        uId: uId,
        cover: cover ?? model?.cover,
        // if cover null user( model.cover)
        bio: bio,
        image: image ?? model?.image,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(userModel.toJson())
        .then((value) {
      GetUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

  File? postImage;

  Future<void> getPostImageByGallery() async {
    XFile? imageFilePost = await picker.pickImage(source: ImageSource.gallery);
    if (imageFilePost == null) return;
    postImage = File(imageFilePost.path);
    emit(PostImagePickedByGallerySuccessState());
  }

  void removePostImage() {
    postImage = null;
    emit(RemoveImagePostState());
  }

  void UploadPostImage({
    @required dateTime,
    @required text,
  }) {
    emit(PostUpLoadImagePickedByGalleryLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage?.path ?? "").pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      emit(PostUpLoadImagePickedByGallerySuccessState());
      value.ref.getDownloadURL().then((value) {
        print(value);
        CreatePost(text: text, dateTime: dateTime, postImage: value);
      }).catchError((error) {
        emit(PostUpLoadImagePickedByGalleryErrorState());
      });
    }).catchError((error) {
      emit(PostUpLoadImagePickedByGalleryErrorState());
    });
  }

  void CreatePost({
    @required dateTime,
    @required text,
    String? postImage,
    String? avatarImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
        name: model?.name,
        uId: CacheHelper.getData(key: 'uId'),
        dateTime: dateTime,
        text: text,
        avatarImage: model?.image,
        postImage: postImage ?? "");

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toJson())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState(error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  PostModel? postModel;
  List<int> likes = [];
  String? currentPostId;

  void GetPosts() {
    emit(GetPostsLoadingState());
    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts = [];

        element.reference.collection('likes').get().then((value) {
          likes = [];
          // like collection is in posts collection
          // like collection contain ids of users that do like this post
          // add no of likes which is no of docs in likes collection
          likes.add(value.docs.length);
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
          print(likes);
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

          // post id is here in that list but i cant see it y3ny
          postsId.add(element.id);

          posts.add(PostModel.fromJson(element.data()));
          emit(GetPostsSuccessState());
        }).catchError((error) {
          emit(GetPostsErrorState(error));
        });
      });
    }).catchError((error) {
      emit(GetPostsErrorState(error));
    });
  }

  List<PostModel> userposts = [];
  List<String> userpostsId = [];
  PostModel? userpostModel;
  List<int> userlikes = [];
  String? usercurrentPostId;

  void GetUserPosts() {
    emit(GetUserPostsLoadingState());
    userposts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      userposts = [];

      value.docs.forEach((element) {
        if (element.data()['uId'] == CacheHelper.getData(key: 'uId')) {
          // userposts = [];

          userposts.add(PostModel.fromJson(element.data()));
          element.reference.collection('likes').get().then((value) {
            userlikes = [];
            // like collection is in posts collection
            // like collection contain ids of users that do like this post
            // add no of likes which is no of docs in likes collection
            userlikes.add(value.docs.length);
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            print(userlikes);
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

            // post id is here in that list but i cant see it y3ny
            userpostsId.add(element.id);

            emit(GetUserPostsSuccessState());
          }).catchError((error) {
            emit(GetUserPostsErrorState(error));
          });
        }
      });
    }).catchError((error) {
      emit(GetUserPostsErrorState(error));
    });
  }

  List<UserModel> users = [];

  void GetAllUsers() {
    users = [];
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      users = [];

      value.docs.forEach((element) {
        if (element.data()['uId'] != CacheHelper.getData(key: 'uId')) {
          users.add(UserModel.fromJson(element.data()));
        }
      });
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersFailureState(errorMessage: error.toString()));
      print(error.toString());
    });
  }

  void LikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model?.uId)
        .set(({'likes': true}))
        .then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  void CreateComment(
      {@required dateTime,
      @required text,
      String? postImage,
      String? avatarImage,
      @required postId}) {
    emit(CreateCommentLoadingState());
    CommentModel commentModel = CommentModel(
        name: model?.name,
        uId: model?.uId,
        dateTime: dateTime,
        text: text,
        avatarImage: model?.image,
        postId: postId
        //  postImage: postImage ?? ""
        );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toJson())
        .then((value) {
      emit(CreateCommentSuccessState());
    }).catchError((error) {
      emit(CreateCommentErrorState(error.toString()));
    });
  }

  List<String> commentsId = [];
  List<CommentModel> comment = [];
  List<int> comments = [];

  void GetComments(String postId) {
    emit(GetCommentLoadingState());
    commentsId = [];
    comment = [];
    comments = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        comments.add(value.docs.length);
        print("//////////////////////////////////");
        print(comments.length);
        print("//////////////////////////////////");

        commentsId.add(element.id);

        comment.add(CommentModel.fromJson(element.data()));
      });
      emit(GetCommentSuccessState());
    }).catchError((error) {
      emit(GetCommentErrorState(error));
    }).catchError((error) {
      emit(GetCommentErrorState(error));
    });
  }

  File? storyImage;

  Future<void> getStoryImageByGallery() async {
    XFile? imageFileStory = await picker.pickImage(source: ImageSource.gallery);
    if (imageFileStory == null) return;
    storyImage = File(imageFileStory.path);
    emit(StoryImagePickedByGallerySuccessState());
  }

  void removeStoryImage() {
    storyImage = null;
    emit(RemoveImageStoryState());
  }

  void UploadStoryImage({
    @required dateTime,
    @required text,
  }) {
    emit(StoryUpLoadImagePickedByGalleryLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('stories/${Uri.file(storyImage?.path ?? "").pathSegments.last}')
        .putFile(storyImage!)
        .then((value) {
      emit(StoryUpLoadImagePickedByGallerySuccessState());
      value.ref.getDownloadURL().then((value) {
        print(value);
        CreateStory(text: text, dateTime: dateTime, storyImage: value);
      }).catchError((error) {
        emit(StoryUpLoadImagePickedByGalleryErrorState());
      });
    }).catchError((error) {
      emit(StoryUpLoadImagePickedByGalleryErrorState());
    });
  }

  List<StoryModel> stories = [];
  List<String> storiesId = [];
  StoryModel? storiesModel;
  String? currentstoriesId;

  void CreateStory({
    @required dateTime,
    @required text,
    String? storyImage,
    String? avatarImage,
  }) {
    emit(CreateStoryLoadingState());
    StoryModel storiesModel = StoryModel(
        name: model?.name,
        uId: CacheHelper.getData(key: 'uId'),
        dateTime: dateTime,
        text: text,
        avatarImage: model?.image,
        storyImage: storyImage ?? "");

    FirebaseFirestore.instance
        .collection("story")
        .add(storiesModel.toJson())
        .then((value) {
      emit(CreateStorySuccessState());
    }).catchError((error) {
      emit(CreateStoryErrorState(error.toString()));
    });
  }

  void GetStories() {
    emit(GetStoryLoadingState());
    stories = [];
    FirebaseFirestore.instance.collection('story').get().then((value) {
      value.docs.forEach((element) {
        stories = [];

        element.reference.collection('likes').get().then((value) {
          likes = [];
          // like collection is in posts collection
          // like collection contain ids of users that do like this post
          // add no of likes which is no of docs in likes collection
          likes.add(value.docs.length);
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
          print(likes);
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

          // post id is here in that list but i cant see it y3ny
          storiesId.add(element.id);
          print("oooooooooooooooooooooooooooooooooo");

          print(element.data());
          if (element.data()['uId'] != CacheHelper.getData(key: 'uId')) {
            stories.add(StoryModel.fromJson(element.data()));
          }

          emit(GetStorySuccessState());
        }).catchError((error) {
          emit(GetStoryErrorState(error));
        });
      });
    }).catchError((error) {
      emit(GetStoryErrorState(error));
    });
  }
}
