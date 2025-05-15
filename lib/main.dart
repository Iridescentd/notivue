import 'package:flutter/material.dart';
import 'splash1.dart';
import 'splash2.dart';
import 'login.dart';
import 'signup.dart';
import 'welcome.dart';
import 'dashboard.dart';
import 'dashboard2.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard2(),
    );
  }
}
