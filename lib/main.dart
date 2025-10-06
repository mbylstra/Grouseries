import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        ConnectionState,
        MaterialApp,
        Scaffold,
        StatelessWidget,
        StreamBuilder,
        Widget,
        runApp,
        WidgetsFlutterBinding;
import 'firebase_options.dart' as firebase_options;
import 'layout/layout.dart' as layout;
import 'screens/sign_in_screen.dart' as screens;
import 'services/auth_service.dart' as auth;
import 'theme.dart' as theme;
import 'package:flutter/material.dart';
import 'screens/scan_page.dart';
import 'screens/ratings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp(
    options: firebase_options.DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.appTheme,
      home: StreamBuilder(
        stream: auth.AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData) {
            return const layout.Layout(title: 'Flutter Demo Home Page');
          }

          return const screens.SignInScreen();
        },
      ),
    );
  }
}
