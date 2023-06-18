import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FixProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfileProvider>(
      create: (_) => UserProfileProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fix User Profile'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 64.0,
                  backgroundImage: AssetImage('profile_image_path'),
                  // Update profile photo functionality can be added here
                ),
              ),
              SizedBox(height: 16.0),
              Text('Name', style: TextStyle(fontSize: 18.0)),
              TextFormField(
                onChanged: (value) {
                  Provider.of<UserProfileProvider>(context, listen: false)
                      .setName(value);
                },
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 16.0),
              Text('Biography', style: TextStyle(fontSize: 18.0)),
              TextFormField(
                onChanged: (value) {
                  Provider.of<UserProfileProvider>(context, listen: false)
                      .setBiography(value);
                },
                decoration: InputDecoration(
                  hintText: 'Enter your biography',
                ),
              ),
              SizedBox(height: 16.0),
              Text('Interests', style: TextStyle(fontSize: 18.0)),
              Consumer<UserProfileProvider>(
                builder: (context, userProfileProvider, _) {
                  List<String> interests = userProfileProvider.interests;
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: _buildInterestChips(
                        interests, userProfileProvider.toggleInterest),
                  );
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Profile update functionality can be added here
                  Provider.of<UserProfileProvider>(context, listen: false)
                      .updateProfile();
                },
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInterestChips(
      List<String> interests, Function(String) onInterestToggled) {
    List<Widget> chips = [];
    for (String interest in interests) {
      chips.add(
        FilterChip(
          label: Text(interest),
          selected: true, // You can modify this based on your implementation
          onSelected: (_) => onInterestToggled(interest),
        ),
      );
    }
    return chips;
  }
}

class UserProfileProvider with ChangeNotifier {
  String _name = "";
  String _biography = "";
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

  String get name => _name;
  String get biography => _biography;
  List<String> get interests => _interests;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setBiography(String biography) {
    _biography = biography;
    notifyListeners();
  }

  void toggleInterest(String interest) {
    if (_interests.contains(interest)) {
      _interests.remove(interest);
    } else {
      _interests.add(interest);
    }
    notifyListeners();
  }

  void updateProfile() {
    // Implement your logic for updating the profile
  }
}
