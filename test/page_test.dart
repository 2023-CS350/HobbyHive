import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hobby_hive/pages/bottom_navigation_page.dart';
import 'package:hobby_hive/pages/chatroom.dart';
import 'package:hobby_hive/pages/create_event_page.dart';
import 'package:hobby_hive/pages/fix_profile_page.dart';
import 'package:hobby_hive/pages/main_page.dart';
import 'package:hobby_hive/pages/setting_page.dart';
import 'package:hobby_hive/pages/sign_in_page.dart';
import 'package:hobby_hive/pages/sign_up_page.dart';
import 'package:hobby_hive/pages/view_profile_page.dart';

import 'extensions.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp(
        name: "TestApp",
        options: const FirebaseOptions(
          apiKey: "my-app-key",
          appId: "my-app-id",
          messagingSenderId: "my-messaging-sender-id",
          projectId: "my-project-id",
          storageBucket: "cs350-hobby-hive.appspot.com",
        ));
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    final auth = MockFirebaseAuth(mockUser: user);
  });

  testWidgets('NavigationPage', (WidgetTester tester) async {
    // await tester.pumpWidget(const NavigationPage().material);
  });

  testWidgets('ChatRoomWidget', (WidgetTester tester) async {
    await tester.pumpWidget(const ChatRoomWidget().material);
  });

  testWidgets('CreateEventPage', (WidgetTester tester) async {
    await tester.pumpWidget(const CreateEventPage().material);
  });

  testWidgets('FixProfileWidget', (WidgetTester tester) async {
    await tester.pumpWidget(const FixProfileWidget().material);
  });

  testWidgets('MainPage', (WidgetTester tester) async {
    // await tester.pumpWidget(const MainPage().material);
  });

  testWidgets('SettingPage', (widgetTester) async {
    await widgetTester.pumpWidget(const SettingPage().material);
  });

  testWidgets('LandingPage', (widgetTester) async {
    await widgetTester.pumpWidget(const LandingPage().material);
  });

  testWidgets('SignUpPage', (widgetTester) async {
    await widgetTester.pumpWidget(const SignUpPage().material);
  });

  testWidgets('ViewProfilePage', (widgetTester) async {
    await widgetTester.pumpWidget(const ViewProfilePage().material);
  });
}
