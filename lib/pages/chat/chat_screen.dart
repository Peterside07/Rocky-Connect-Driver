// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../models/trip_response.dart';
import '../../services/firebase_api.dart';
import '../../theme/colors.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final TripResponse tripResponse;

 const ChatScreen({
    Key? key,
    required this.chatRoomId,
    required this.tripResponse,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textFieldController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

 

  void sendMessage(String message) {
 
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatRoomId.toString())
        .collection('messages')
        .add({
      'senderId': FirebaseAuth.instance.currentUser?.uid,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((value) => FirebaseApi.sendPushNotification(widget.tripResponse.deviceId, message ));
  }

  

  Stream<QuerySnapshot> getChatMessages() {
    debugPrint('Listening to Chat Messages for chatRoomId: ${widget.chatRoomId}');

    return FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatRoomId.toString())
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  void sendNotification(String senderId, String message) async {

    RemoteMessage(
      data: {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'message': message,
        'senderId': senderId,
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )),
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getChatMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    var messageText = message['message'];
                    var messageSender = message['senderId'];

                    var isCurrentUser =
                        FirebaseAuth.instance.currentUser?.uid == messageSender;

                    return Align(
                      alignment: isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? Colors.white
                              : AppColors.PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              messageText ?? '',
                              style: TextStyle(
                                color:
                                    isCurrentUser ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage(_textFieldController.text);
                    _textFieldController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
