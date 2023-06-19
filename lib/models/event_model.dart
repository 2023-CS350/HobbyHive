import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String event_name;
  final String address;
  final String description;
  final DateTime? date;
  final String event_image;
  final String host_id;

  //변수만 입력하고 toJson하고 fromJson 만들어달라고 챗지피티에게 요청하면 코드 다 짜줍니다.

  Event({
    required this.event_name,
    required this.address,
    required this.description,
    required this.date,
    required this.event_image,
    required this.host_id,
  });

  Map<String, dynamic> toJson() => {
        'event_name': event_name,
        'address': address,
        'description': description,
        'date': Timestamp.fromDate(date!),
        'event_image': event_image,
        'host_id': host_id,
      };
  factory Event.fromJson(Map<String, dynamic> json) {
    
    return Event(
      event_name: json['event_name'],
      address: json['address'],
      description: json['description'],
      date: json['date'].toDate(),
      event_image: json['event_image'],
      host_id: json['host_id'],
    );
  }
}
