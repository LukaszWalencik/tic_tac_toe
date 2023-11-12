import 'package:flutter/material.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                  text: 'Join Room',
                  fontSize: 50,
                  shadows: [Shadow(blurRadius: 40, color: Colors.blue)]),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                  controller: _nameController, hintText: 'Enter Player Name'),
              SizedBox(height: size.height * 0.02),
              CustomTextField(
                  controller: _gameIdController, hintText: 'Enter Game ID'),
              SizedBox(height: size.height * 0.05),
              CustomButton(onTap: () {}, text: 'Join')
            ],
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gameIdController.dispose();

    super.dispose();
  }
}
