import 'dart:ffi';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hive/pages/accept_request_page.dart';
import 'package:hobby_hive/widgets/interest_chip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobby_hive/models/user_model.dart' as user_model;

import '../models/event_model.dart';
import '../widgets/loading_indicator.dart';
import 'chatroom_page.dart';
import 'fix_profile_page.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({Key? key});

  static const routeName = '/ViewProfilePage';

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  late DocumentSnapshot userSnapshot;
  late String userName = "";
  late String biography = "";
  late int score = 5;
  late List<String> interests = [];
  late String address = "";
  late user_model.User user;
  late String _image = "";
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      var userID = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userID)
          .get();
      if (userDoc.exists) {
        print(userDoc.data());
        setState(() {
          userSnapshot = userDoc;
          userName = userSnapshot.data().toString().contains("user_name")
              ? userSnapshot.get("user_name")
              : "";
          biography = userSnapshot.data().toString().contains("biographie")
              ? userSnapshot.get("biographie")
              : "";
          score = userSnapshot.data().toString().contains("score")
              ? userSnapshot.get("score")
              : "";
          interests = userSnapshot.data().toString().contains("interest")
              ? List<String>.from(userSnapshot['interest'])
              : [];
          address = userSnapshot.data().toString().contains("address")
              ? userSnapshot.get("address")
              : "";
          _image = userSnapshot.data().toString().contains("profile_image")
              ? userSnapshot.get("profile_image")
              : "";
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: _image != ""
                              ? _image
                              : "https://i.imgur.com/BoN9kdC.png",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    _score(score),
                    const SizedBox(height: 15),
                    Text(
                      biography,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Interests',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 15.0,
                      alignment: WrapAlignment.center,
                      children: interests
                          .map(
                            (interest) => interestChip(
                              interest,
                              const Color(0xFFff6666),
                              (_) => {},
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Hosting Events',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildEventList(true),
                    const Text(
                      'Participating Events',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildEventList(false),
                  ],
                ),
              )),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FixProfileWidget()),
                );
              },
              label: const Text('Edit'),
              icon: const Icon(Icons.edit),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
          );
  }

  Widget _buildEventList(bool isHost) {
    final stream = isHost
        ? FirebaseFirestore.instance
            .collection('events')
            .where('host_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots()
        : FirebaseFirestore.instance
            .collection('events')
            .where('participants',
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final events = snapshot.data!.docs;
          if (events.isEmpty) {
            return const Text('No events hosted');
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              print(events[index].data().toString());
              Map<String, dynamic> eachEvent =
                  events[index].data() as Map<String, dynamic>;
              final eventJson = Event.fromJson(eachEvent);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _generateRandomColor(),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(eventJson.event_name),
                    subtitle: Text(eventJson.date.toString()),
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          isHost
                              ? AcceptRequest.routeName
                              : ChatRoomWidget.routeName,
                          arguments: EventArgument(events[index].id));
                    },
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Error retrieving events');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Color _generateRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }
}

Widget _score(int score) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      for (int i = 0; i < 5; i++)
        Icon(
          i < score ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 30,
        ),
    ],
  );
}

class EventArgument {
  final String eventID;
  EventArgument(this.eventID);
}
