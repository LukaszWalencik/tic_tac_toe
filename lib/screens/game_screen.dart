import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';
import 'package:tic_tac_toe/widgets/scoreboard.dart';
import 'package:tic_tac_toe/widgets/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethod _socketMethod = SocketMethod();
  @override
  void initState() {
    _socketMethod.updateRoomListener(context);
    _socketMethod.updatePlayerListener(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : const SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Scoreboard()],
              ),
            ),
    );
  }
}
