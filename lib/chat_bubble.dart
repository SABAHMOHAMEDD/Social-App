import 'package:flutter/material.dart';
import 'package:social_app/core/core.dart';

import 'core/utils/constants.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String? userName;

  ChatBubble({required this.message, this.userName});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: KPrimaryColor.withOpacity(.8),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                topLeft: Radius.circular(14))),
        margin: const EdgeInsets.only(top: 15, left: 10, right: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Text(
                //   userName!,
                //   style: TextStyle(color: Colors.orangeAccent),
                // ),
                Text(
                  message!,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleFriend extends StatelessWidget {
  final String message;
  final String? userName;
  final bool isPrivateChat;
  final Color? userBubbleColor;

  ChatBubbleFriend(
      {required this.message,
      required this.isPrivateChat,
      this.userName,
      this.userBubbleColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(14),
                bottomRight: Radius.circular(14),
                topLeft: Radius.circular(14))),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isPrivateChat
                    ? SizedBox()
                    : Text(
                        "$userName",
                        style: TextStyle(
                            color: userBubbleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.black38, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
