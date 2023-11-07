import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = "/main-menu";
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Main Menu'),
      ),
    );
  }
}
