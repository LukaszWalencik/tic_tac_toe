import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/widgets/custom_textfield.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController idController = TextEditingController();

  @override
  void initState() {
    idController =
        Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 50),
          const Text('Waiting for another player to join'),
          const SizedBox(height: 20),
          CustomTextField(
            controller: idController,
            hintText: '',
            isReadOnly: true,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }
}
