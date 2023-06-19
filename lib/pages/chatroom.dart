import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobby_hive/models/chat_model.dart';
import 'package:hobby_hive/models/chatroom_model.dart';

class ChatRoomWidget extends StatefulWidget {
  const ChatRoomWidget({Key? key}) : super(key: key);

  @override
  _ChatRoomWidgetState createState() => _ChatRoomWidgetState();
}

class _ChatRoomWidgetState extends State<ChatRoomWidget> {
  late CollectionReference _chatCollection =
      FirebaseFirestore.instance.collection('chat_rooms');
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final ChatRoom _chatRoom = ChatRoom(
    id: 'YOUR_CHAT_ROOM_ID',
    eventId: 'YOUR_EVENT_ID',
    messages: [],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    DocumentReference chatRoomDoc = _chatCollection.doc('YOUR_CHAT_ROOM_ID');

    // Check if the chat room document exists
    bool chatRoomExists =
        await chatRoomDoc.get().then((docSnapshot) => docSnapshot.exists);

    if (!chatRoomExists) {
      // Chat room document doesn't exist, create a new one
      await chatRoomDoc.set(_chatRoom.toJson());
    }
  }

  TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      Message newMessage = Message(
        text: messageText,
        sender: userId,
      );

      DocumentReference chatRoomDoc = _chatCollection.doc('YOUR_CHAT_ROOM_ID');

      // Check if the chat room document exists
      bool chatRoomExists =
          await chatRoomDoc.get().then((docSnapshot) => docSnapshot.exists);

      if (chatRoomExists) {
        // Chat room document exists, update the messages field
        await chatRoomDoc.update({
          'messages': FieldValue.arrayUnion([newMessage.toJson()]),
        });
      } else {
        // Chat room document doesn't exist, create a new one
        await chatRoomDoc.set({
          'messages': [newMessage.toJson()],
        });
      }

      setState(() {
        _chatRoom.messages.add(newMessage);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Title'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: _chatCollection.doc('YOUR_CHAT_ROOM_ID').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final messages = (snapshot.data!.data()
                      as Map<String, dynamic>)['messages'];
                  _chatRoom.messages.clear();
                  for (var messageData in messages) {
                    _chatRoom.messages.add(Message.fromJson(messageData));
                  }

                  return ListView.builder(
                    itemCount: _chatRoom.messages.length,
                    itemBuilder: (context, index) {
                      final message = _chatRoom.messages[index];
                      return Align(
                        alignment: message.sender == userId
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MessageBubble(
                              text: message.text,
                              isSentByMe: message.sender == userId),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.isSentByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSentByMe ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSentByMe ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
