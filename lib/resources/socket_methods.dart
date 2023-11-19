import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

import 'socket_client.dart';

class SocketMethod {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  void createRoom(String playerName) {
    if (playerName.isNotEmpty) {
      //Emit an event so that server can listen to it.
      _socketClient.emit("createRoom", {'playername': playerName});
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on("createRoomSuccess", (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      print(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }
}
