import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String event_name;
  final String address;
  final String description;
  final DateTime? date;
  final String event_image;
  final String host_id;
  final List<String>? participants;
  final List<String>? candidates;

  Event({
    required this.event_name,
    required this.address,
    required this.description,
    required this.date,
    required this.event_image,
    required this.host_id,
    List<String>? participants,
    List<String>? candidates,
  })  : participants = participants ?? [],
        candidates = candidates ?? [];

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      event_name: json['event_name'],
      address: json['address'],
      description: json['description'],
      date: json['date'].toDate(),
      event_image: json['event_image'],
      host_id: json['host_id'],
      participants: List<String>.from(json['participants'] ?? []),
      candidates: List<String>.from(json['candidates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_name': event_name,
      'address': address,
      'description': description,
      'date': Timestamp.fromDate(date!),
      'event_image': event_image,
      'host_id': host_id,
      'participants': participants,
      'candidates': candidates,
    };
  }
}
