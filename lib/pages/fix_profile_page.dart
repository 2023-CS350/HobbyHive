import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hive/models/user_model.dart' as user_model;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:hobby_hive/models/user_model.dart';

import '../widgets/interest_chip.dart';

class FixProfileWidget extends StatefulWidget {
  const FixProfileWidget({Key? key}) : super(key: key);

  @override
  State<FixProfileWidget> createState() => _FixProfileWidgetState();
}

class _FixProfileWidgetState extends State<FixProfileWidget> {
  var _image = null;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _biographyController = TextEditingController();
  List<String> _selectedInterests = [];
  List<String> _interests = [
    'Exercise',
    'Movies',
    'Travel',
    'Music',
    'Cooking',
    'Art',
    'Reading',
    // Add more interests as desired
  ];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                    onTap: _getPhotoLibraryImage,
                    child: CircleAvatar(
                      radius: 64.0,
                      child: ClipOval(
                          child: _image == null
                              ? Icon(Icons.photo_filter)
                              : Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                  width: 200,
                                  height: 200,
                                )),
                    )),
              ),
              SizedBox(height: 16.0),
              Text('Name', style: TextStyle(fontSize: 18.0)),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 16.0),
              Text('Biographie', style: TextStyle(fontSize: 18.0)),
              TextFormField(
                controller: _biographyController,
                decoration: InputDecoration(
                  hintText: 'Enter your biography',
                ),
              ),
              SizedBox(height: 16.0),
              Text('Interests', style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _buildInterestChips(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInterestChips() {
    List<Widget> chips = [];
    for (String interest in _interests) {
      final isSelected = _selectedInterests.contains(interest);
      chips.add(
        FilterChip(
          label: Text(interest),
          selected: isSelected,
          backgroundColor: isSelected ? Colors.grey : null,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedInterests.add(interest);
              } else {
                _selectedInterests.remove(interest);
              }
            });
          },
        ),
      );
    }
    return chips;
  }

  _getPhotoLibraryImage() async {
    var status = await Permission.photos.request().isGranted;
    if (status) {
      // Here you can open app settings so that the user can give permission
      openAppSettings();
    }
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = (File(pickedImage.path));
      });
    }
  }

  _updateProfile() async {
    try {
      // Create a reference to the Firestore collection where user profiles are stored
      var userID = FirebaseAuth.instance.currentUser!.uid;
      final profileRef = FirebaseFirestore.instance.collection('profiles');
      var image = "";

      // Upload the profile image if available
      if (_image != null) {
        final imageUrl = await _uploadImage(userID);
        image = imageUrl;
      }

      user_model.User user = user_model.User(
          id: userID,
          userName: _nameController.text,
          profileImage: image,
          score: 5,
          biography: _biographyController.text,
          interest: _selectedInterests);

      // Update the profile data in Firestore
      await profileRef.doc(userID).set(user.toJson());

      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      // Handle any errors that occur during the profile update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
      print(e);
    }
  }

  Future<String> _uploadImage(String userId) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
    final uploadTask = storageRef.putFile(_image!);
    final snapshot = await uploadTask.whenComplete(() => null);
    final imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }
}

void permission() async {
  Map<Permission, PermissionStatus> permissions = await [
    Permission.photos,
  ].request();
  print(permissions[Permission.photos]);
}
