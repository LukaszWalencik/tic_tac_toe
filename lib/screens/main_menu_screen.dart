import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = "/main-menu";
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(onTap: () {}, text: 'Create Room'),
            const SizedBox(height: 10),
            CustomButton(onTap: () {}, text: 'Join Room')
          ],
        ),
      ),
    );
  }
}
