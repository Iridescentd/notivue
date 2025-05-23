import 'package:flutter/material.dart';
import 'splash1.dart';
import 'splash2.dart';
import 'login.dart';
import 'signup.dart';
import 'welcome.dart';
import 'dashboard.dart';
import 'dashboard2.dart';
import 'settings.dart';
import 'edit_profile.dart';
import 'create_note.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            initialRoute: '/',
      routes: {
        '/': (context) => const Splash1(),     // First screen
        '/splash2': (context) => const Splash2(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUp(),
        '/dashboard': (context) => const Dashboard(),
        '/dashboard2': (context) => const Dashboard2(),
        '/settings': (context) => const SettingsScreen(),
        '/notes': (context) => const CreateNoteScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
      },
    );
  }
}
