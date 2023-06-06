import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hive/pages/main_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;
  final _pageList = [
    MainPage(),
    Placeholder(),
    TempSignOut(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class TempSignOut extends StatefulWidget {
  const TempSignOut({super.key});

  @override
  State<TempSignOut> createState() => _TempSignOutState();
}

class _TempSignOutState extends State<TempSignOut> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth _auth = FirebaseAuth.instance;
    print("d");
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
