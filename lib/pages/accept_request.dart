import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hobby_hive/pages/view_profile_page.dart';
import 'package:hobby_hive/models/user_model.dart' as user_model;

class AcceptRequest extends StatefulWidget {
  static const routeName = '/AcceptRequest';

  @override
  State<AcceptRequest> createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
  @override
  Widget build(BuildContext context) {
    EventArgument args =
        ModalRoute.of(context)!.settings.arguments as EventArgument;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Requested Participants',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 15),

              // Display the list of users who have requested to participate
              CandidateListWidget(eventID: args.eventID),
            ],
          ),
        ),
      ),
      // ... existing code ...
    );
  }
}

class CandidateListWidget extends StatelessWidget {
  final String eventID;

  const CandidateListWidget({Key? key, required this.eventID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('events')
          .doc(eventID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final eventData = snapshot.data!.data();
          final candidates = eventData?['candidates'] as List<dynamic>?;

          if (candidates == null || candidates.isEmpty) {
            return const Text('No candidate requests');
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: candidates.length,
            itemBuilder: (context, index) {
              final candidate = candidates[index];
              return ListTile(
                title: Text(candidate),
                onTap: () {
                  _addParticipant(candidate);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Error retrieving candidates');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  void _addParticipant(String userID) async {
    final eventRef =
        FirebaseFirestore.instance.collection('events').doc(eventID);
    try {
      final userRef =
          FirebaseFirestore.instance.collection('profiles').doc(userID);

      final userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        await eventRef.update({
          'participants': FieldValue.arrayUnion([userID]),
        });

        await eventRef.update({
          'candidates': FieldValue.arrayRemove([userID]),
        });
      }
    } catch (e) {
      print('Error adding participant: $e');
    }
  }
}
