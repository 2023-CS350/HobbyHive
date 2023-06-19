import 'chat_model.dart';

class ChatRoom {
  final String id;
  final String eventId;
  final List<Message> messages;

  ChatRoom({
    required this.id,
    required this.eventId,
    required this.messages,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'],
      eventId: json['event_id'],
      messages: List<Message>.from(
        json['messages'].map((messageJson) => Message.fromJson(messageJson)),
      ),
    );
  }
}
