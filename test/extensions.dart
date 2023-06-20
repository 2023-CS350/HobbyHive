import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

extension WidgetForTest on Widget {
  Widget get material => MaterialApp(home: this);

  Widget get scaffold => MaterialApp(
        home: Scaffold(
          body: this,
        ),
      );

  Widget materialAndNotifier<T extends ChangeNotifier>(T model) {
    return ChangeNotifierProvider(
        create: (_) => model, child: MaterialApp(home: this));
  }

  Widget scaffoldAndNotifier<T extends ChangeNotifier>(T model) {
    return ChangeNotifierProvider<T>(
        create: (_) => model,
        child: MaterialApp(
          home: Scaffold(
            body: this,
          ),
        ));
  }
}

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}
