import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hive/widgets/interest_chip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobby_hive/models/user_model.dart' as user_model;

import 'chatroom.dart';
import 'fix_profile_page.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({Key? key});

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
        });
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const CircleAvatar(radius: 60.0),
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
              const SizedBox(height: 15),
              Text(
                address,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
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
