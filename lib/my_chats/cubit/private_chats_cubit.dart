import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../models/private_message_model.dart';
import 'private_chats_states.dart';

class PrivateChatsCubit extends Cubit<PrivateChatsStates> {
  PrivateChatsCubit() : super(MyChatsInitStates());

  static PrivateChatsCubit get(context) => BlocProvider.of(context);

  void sendPrivateMessage(
      {required String receiverId,
      required String dateTime,
      required String message,
      required String senderId}) {
    try {
      PrivateMessageModel privateMessageModel = PrivateMessageModel(
          message: message,
          senderId: senderId,
          receiverId: receiverId,
          dateTime: dateTime);

      // set my chat
      FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(CacheHelper.getData(key: 'uId'))
          .collection(privateChatCollection)
          .doc(CacheHelper.getData(key: 'userId'))
          .collection(privateMessagesCollection)
          .add(privateMessageModel.toJason())
          .then((value) {
        //emit(SendMessageSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(SendMessageFailurStates());
      });

// set receiver chat
      FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(CacheHelper.getData(key: 'userId'))
          .collection(privateChatCollection)
          .doc(CacheHelper.getData(key: 'uId'))
          .collection(privateMessagesCollection)
          .add(privateMessageModel.toJason())
          .then((value) {
        //emit(SendMessageSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(SendMessageFailurStates());
      });
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }

  List<PrivateMessageModel> messages = [];

  void GetMessages({required receiverId}) {
    messages = [];

    try {
      FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(uId)
          .collection(privateChatCollection)
          .doc(receiverId)
          .collection(privateMessagesCollection)
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((event) {
        messages = [];

        event.docs.forEach((element) {
          messages.add(PrivateMessageModel.fromJason(element.data()));
          print(
              "########################### Private Messages Here #############################");
          print(messages[0]);
          emit(GetMessageSuccessStates(MessegesList: messages));
        });
      });
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }
}
