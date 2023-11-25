import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/resources/game_methods.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

import 'socket_client.dart';

class SocketMethod {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  void createRoom(String playername) {
    if (playername.trim().isNotEmpty) {
      //Emit an event so that server can listen to it.
      _socketClient.emit("createRoom", {'playername': playername});
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      "createRoomSuccess",
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        print(room);
        Navigator.pushNamed(context, GameScreen.routeName);
      },
    );
  }

  void joinRoom(String playername, String roomID) {
    if (playername.trim().isNotEmpty && roomID.isNotEmpty) {
      _socketClient
          .emit("joinRoom", {'playername': playername, 'roomID': roomID});
    }
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      "joinRoomSuccess",
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        print(room);
        Navigator.pushNamed(context, GameScreen.routeName);
      },
    );
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on(
      "errorOccured",
      (data) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data),
          ),
        );
      },
    );
  }

  void updatePlayerListener(BuildContext context) {
    _socketClient.on("updatePlayers", (playersData) {
      Provider.of<RoomDataProvider>(context).updatePlayer1(playersData[0]);
      Provider.of<RoomDataProvider>(context).updatePlayer2(playersData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    socketClient.on("updateRoom", (room) {
      Provider.of<RoomDataProvider>(context).updateRoomData(room);
    });
  }

  void updateGrid(int index, String roomID, List<String> displayElements) {
    if (displayElements[index] == '') {
      socketClient.emit('tap', {'index': index, 'roomID': roomID});
    }
  }

  void updateGridListener(BuildContext context) {
    _socketClient.on("tapped", (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(data['index'], data['choice']);
      roomDataProvider.updateRoomData(data['room']);
      //Check for winner
      GameMethods().checkWinner(context, socketClient);
    });
  }
}
