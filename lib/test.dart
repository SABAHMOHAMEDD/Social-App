// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:social_app/models/post_model.dart';
// import 'package:social_app/models/user_model.dart';
// import 'package:social_app/modules/Home/cubit/states.dart';
// import 'package:social_app/modules/chat/chat_screen.dart';
// import 'package:social_app/modules/feeds/feeds_screen.dart';
// import 'package:social_app/modules/profile/profile_screen.dart';
// import 'package:social_app/modules/settings/settings_screen.dart';
//
// import '../../../models/comment_model.dart';
// import '../../../shared/components/constant.dart';
//
// class SocialCubit extends Cubit<SocialStates> {
//   SocialCubit() : super(IntialState());
//
//
//   static SocialCubit get(context) => BlocProvider.of(context);
//
// //get user data from firebase
//   UserModel? model;
//
//   void GetUserData() {
//     emit(GetUserLoadingState());
//     FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
//       print(value.data());
//
//       model = UserModel.fromJson(value.data()!);
//       emit(GetUserSuccessState());
//     }).catchError((error) {
//       print(error.toString());
//       emit(GetUserErrorState(error.toString()));
//     });
//   }
//
//   int currentIndex = 0;
//   List<Widget> Screens = [
//     FeedScreen(),
//     ChatScreen(),
//     ProfileScreen(),
//     SettingScreen()
//   ];
//   List<String> title = [
//     'Home',
//     'Chat',
//     'Profile',
//     'Settings',
//   ];
//
//   void ChangebottomNavBar(int index) {
//     currentIndex = index;
//     emit(ChageBottomNavState());
//   }
//
//   File? profileimage;
//   final picker = ImagePicker();
//
//   Future<void> getProfileImageByGallery() async {
//     XFile? imageFileProfile =
//     await picker.pickImage(source: ImageSource.gallery);
//     if (imageFileProfile == null) return null;
//
//     profileimage = File(imageFileProfile.path);
//     emit(ProfileImagePickedByGallerySuccessState());
//   }
//
//   Future<void> getProfileImageByCam() async {
//     XFile? imageFileProfile =
//     await picker.pickImage(source: ImageSource.camera);
//     if (imageFileProfile == null) return;
//     profileimage = File(imageFileProfile.path);
//     emit(ProfileImagePickedByCamSuccessState());
//   }
//
//   File? coverImage;
//
//   Future<void> getCoverImageByGallery() async {
//     XFile? imageFileCover = await picker.pickImage(source: ImageSource.gallery);
//     if (imageFileCover == null) return;
//     coverImage = File(imageFileCover.path);
//     emit(CoverImagePickedByGallerySuccessState());
//   }
//
//   Future<void> getCoverImageByCam() async {
//     XFile? imageFileCover = await picker.pickImage(source: ImageSource.camera);
//     if (imageFileCover == null) return;
//     coverImage = File(imageFileCover.path);
//     emit(CoverImagePickedByCamSuccessState());
//   }
//
//   //upload image to firebase storage
//   // then have the url to send it to firebase firestore in the update func
//   void uploadProfileImage({
//     @required name,
//     @required phone,
//     @required bio,
//   }) {
//     FirebaseStorage.instance
//         .ref()
//         .child('users/${Uri.file(profileimage?.path ?? "").pathSegments.last}')
//         .putFile(profileimage!)
//         .then((value) {
//       value.ref.getDownloadURL().then((value) {
//         emit(ProfileUpLoadImagePickedByGallerySuccessState());
//         print(value);
//         UpdateUser(
//             name: model?.name,
//             phone: model?.phone,
//             bio: model?.bio,
//             image: value);
//       }).catchError((error) {
//         emit(ProfileUpLoadImagePickedByGalleryErrorState());
//       });
//     }).catchError((error) {
//       emit(ProfileUpLoadImagePickedByGalleryErrorState());
//     });
//   }
//
//   void uploadCoverImage({
//     @required name,
//     @required phone,
//     @required bio,
//   }) {
//     FirebaseStorage.instance
//         .ref()
//         .child('users/${Uri.file(coverImage?.path ?? "").pathSegments.last}')
//         .putFile(coverImage!)
//         .then((value) {
//       value.ref.getDownloadURL().then((value) {
//         emit(CoverUpLoadImagePickedByGallerySuccessState());
//         print(value);
//         UpdateUser(
//             name: model?.name,
//             phone: model?.phone,
//             bio: model?.bio,
//             cover: value);
//       }).catchError((error) {
//         emit(CoverUpLoadImagePickedByGalleryErrorState());
//       });
//     }).catchError((error) {
//       emit(CoverUpLoadImagePickedByGalleryErrorState());
//     });
//   }
//
//   void UpdateUserImagesOrData({
//     @required name,
//     @required phone,
//     @required bio,
//   }) {
//     emit(UpdateUserDataLoadingState());
//     if (coverImage != null) {
//       //updata cover and (data if it changed)
//       uploadCoverImage();
//     } else if (profileimage != null) {
//       //updata profile and (data if it changed)
//
//       uploadProfileImage();
//     } else if (coverImage != null && profileimage != null) {
//       //updata cover and profile and (data if it changed)
//
//       uploadCoverImage();
//       uploadProfileImage();
//     } else {
//       UpdateUser(name: name, phone: phone, bio: bio);
//     }
//   }
//
//   // update only data
//   void UpdateUser({
//     @required name,
//     @required phone,
//     @required bio,
//     String? cover,
//     String? image,
//   }) {
//     UserModel userModel = UserModel(
//         name: name,
//         phone: phone,
//         email: model?.email,
//         uId: uId,
//         cover: cover ?? model?.cover,
//         // if cover null user( model.cover)
//         bio: bio,
//         image: image ?? model?.image,
//         isEmailVerified: false);
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(uId)
//         .update(userModel.toJson())
//         .then((value) {
//       GetUserData();
//     }).catchError((error) {
//       emit(UpdateUserDataErrorState(error.toString()));
//     });
//   }
//
//   File? postImage;
//
//   Future<void> getPostImageByGallery() async {
//     XFile? imageFilePost = await picker.pickImage(source: ImageSource.gallery);
//     if (imageFilePost == null) return;
//     postImage = File(imageFilePost.path);
//     emit(PostImagePickedByGallerySuccessState());
//   }
//
//   void removePostImage() {
//     postImage = null;
//     emit(RemoveImagePostState());
//   }
//
//   void UploadPostImage({
//     @required dateTime,
//     @required text,
//   }) {
//     emit(PostUpLoadImagePickedByGalleryLoadingState());
//     FirebaseStorage.instance
//         .ref()
//         .child('posts/${Uri.file(postImage?.path ?? "").pathSegments.last}')
//         .putFile(postImage!)
//         .then((value) {
//       emit(PostUpLoadImagePickedByGallerySuccessState());
//       value.ref.getDownloadURL().then((value) {
//         print(value);
//         CreatePost(text: text, dateTime: dateTime, postImage: value);
//       }).catchError((error) {
//         emit(PostUpLoadImagePickedByGalleryErrorState());
//       });
//     }).catchError((error) {
//       emit(PostUpLoadImagePickedByGalleryErrorState());
//     });
//   }
//
//   void CreatePost({
//     @required dateTime,
//     @required text,
//     String? postImage,
//     String? avatarImage,
//   }) {
//     emit(CreatePostLoadingState());
//     PostModel postModel = PostModel(
//         name: model?.name,
//         uId: model?.uId,
//         dateTime: dateTime,
//         text: text,
//         avatarImage: model?.image,
//         postImage: postImage ?? "",
//         postId: currentPostId
//
//     );
//
//     FirebaseFirestore.instance
//         .collection('posts')
//         .add(postModel.toJson())
//         .then((value) {
//       emit(CreatePostSuccessState());
//     }).catchError((error) {
//       emit(CreatePostErrorState(error.toString()));
//     });
//   }
//
//   List<PostModel> posts = [];
//   List<String> postsId = [];
//   PostModel?postModel;
//   List<int> likes = [];
//   String? currentPostId;
//
// //elemnt == post
//   void GetPosts() {
//     emit(GetPostsLoadingState());
//
//     FirebaseFirestore.instance.collection('posts').get().then((value) {
//       value.docs.forEach((element) {
//         element.reference.collection('likes')
//             .get()
//             .then((value) {
//
//           // like collection is in posts collection
//           // like collection contain ids of users that do like this post
//           // add no of likes which is no of docs in likes collection
//           likes.add(value.docs.length);
//           print(likes);
//           // post id is here in that list but i cant see it y3ny
//           postsId.add(element.id);
//
//           posts.add(PostModel.fromJson(element.data()));
//           emit(GetPostsSuccessState());
//
//         }).catchError((error){
//           emit(GetPostsErrorState(error));
//
//         });
//
//       });
//     }).catchError((error) {
//       emit(GetPostsErrorState(error));
//     });
//
//
//
//   }
//
//
//
//   void LikePost(String postId){
//
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc(postId)
//         .collection('likes')
//         .doc(model?.uId)
//         .set(({
//       'likes':true
//
//     })
//
//     ).then((value) {
//       emit(LikePostSuccessState());
//     })
//         .catchError((error){
//       emit(LikePostErrorState(error.toString()));
//     });
//   }
//
//
//
//   void CreateComment({
//     @required dateTime,
//     @required text,
//     String? postImage,
//     String? avatarImage,
//     @required postId
//   }) {
//     emit(CreateCommentLoadingState());
//     CommentModel commentModel = CommentModel(
//         name: model?.name,
//         uId: model?.uId,
//         dateTime: dateTime,
//         text: text,
//         avatarImage: model?.image,
//         postId:postId
//       //  postImage: postImage ?? ""
//     );
//
//     FirebaseFirestore.instance
//         .collection('posts').doc(postId).collection('comments').add(commentModel.toJson()).then((value) {
//       emit(CreateCommentSuccessState());
//     }).catchError((error) {
//       emit(CreateCommentErrorState(error.toString()));
//     });
//   }
//
//
//   List<String> commentsId = [];
//   List<CommentModel> comment = [];
//   List<int> comments = [];
//   void GetComments(String postId) {
//     emit(GetCommentLoadingState());
//     commentsId = [];
//     comment = [];
//     comments=[];
//     FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').get().then((value) {
//       value.docs.forEach((element){
//
//         comments.add(value.docs.length);
//         print(comments );
//         commentsId.add(element.id);
//
//         comment.add(CommentModel.fromJson(element.data()));
//       }
//       );
//       emit(GetCommentSuccessState());
//
//     }).catchError((error){ emit(GetCommentErrorState(error));
//     }).catchError((error){emit(GetCommentErrorState(error));});
//
//
//
//
//   }
//
// //element =post
//   //value = comment
//   test(){
//     FirebaseFirestore.instance.collection('posts').get().then((value) {
//
//       value.docs.forEach((element) {
//         element.reference.collection('comments')
//             .get()
//             .then((value) {
//
//           postsId.add(element.id);
//           comments.add(value.docs.length);
//           print(comments );
//           // commentsId.add(value.);
//           comment.add(CommentModel.fromJson(element.data()));
//           emit(GetCommentSuccessState());
//
//         }).catchError((error){
//           emit(GetCommentErrorState(error));
//
//         });
//
//       });
//     }).catchError((error) {
//       emit(GetCommentErrorState(error));
//     });
//
//   }
//
// }
