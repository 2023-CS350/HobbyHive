import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hive/pages/accept_request.dart';
import 'package:hobby_hive/pages/bottom_navigation_page.dart';
import 'package:hobby_hive/pages/create_event_page.dart';
import 'package:hobby_hive/pages/main_page.dart';
import 'package:hobby_hive/pages/sign_in_page.dart';
import 'package:hobby_hive/pages/sign_up_page.dart';
import 'package:hobby_hive/pages/view_profile_page.dart';
import 'package:hobby_hive/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth? _auth;
  User? _currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _currentUser = _auth?.currentUser;

    _auth?.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.pink,
        ),
        //  home: SignInPage(),
        home: _currentUser == null ? LandingPage() : NavigationPage(),
        routes: {
          AcceptRequest.routeName: (context) => AcceptRequest(),
        },
        // home:MainPage(title: "d"),
      ),
    );
  }
}
