import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethod _socketMethod = SocketMethod();
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
                  text: 'Create Room',
                  fontSize: 50,
                  shadows: [Shadow(blurRadius: 40, color: Colors.blue)]),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                  controller: _nameController, hintText: 'Enter Player Name'),
              SizedBox(height: size.height * 0.05),
              CustomButton(
                  onTap: () {
                    _socketMethod.createRoom(_nameController.text);
                  },
                  text: 'Create')
            ],
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
