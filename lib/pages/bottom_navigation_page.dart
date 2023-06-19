import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hive/pages/main_page.dart';
import 'package:hobby_hive/pages/view_profile_page.dart';
import 'package:hobby_hive/widgets/loading_indicator.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  final _pageList = [
    MainPage(),
    Placeholder(),
    ViewProfilePage(),
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
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth _auth = FirebaseAuth.instance;
    print("d");
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    _signOut();
    if (mounted) {
      _isLoading = false;
    }
  }

  Future<bool> _signOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      // 로그아웃 성공 후 수행할 작업
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        print('The user account has been disabled.');
      } else if (e.code == 'user-not-found') {
        print('The user account was not found.');
      } else if (e.code == 'invalid-credential') {
        print('Invalid credentials.');
      } else if (e.code == 'operation-not-allowed') {
        print('Sign-out operation is not allowed.');
      } else {
        print('An error occurred during sign-out: ${e.code}');
      }
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading?LoadingIndicator(): Placeholder();
  }
}
