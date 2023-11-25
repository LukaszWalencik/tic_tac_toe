import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/utils/utils.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    String winner = ''; //Name of plater or player display element  'X' or 'O'

    //Check horizontally
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[1] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[2] &&
        roomDataProvider.displayElements[0] != '') {
      winner == roomDataProvider.displayElements[0];
    }

    if (roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[3] != '') {
      winner == roomDataProvider.displayElements[3];
    }

    if (roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[6] != '') {
      winner == roomDataProvider.displayElements[6];
    }

    //Check vertically

    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[3] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[0] != '') {
      winner == roomDataProvider.displayElements[0];
    }

    if (roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[1] != '') {
      winner == roomDataProvider.displayElements[1];
    }

    if (roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[2] != '') {
      winner == roomDataProvider.displayElements[2];
    }

    //Check diagonally
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[0] != '') {
      winner == roomDataProvider.displayElements[0];
    }

    if (roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[2] != '') {
      winner == roomDataProvider.displayElements[2];
    }

    if (winner != '') {
      if (roomDataProvider.playerModel1.playerType == winner) {
        showGameDialog(context,
            '${roomDataProvider.playerModel1.playername} won the round');
        socketClient.emit('winner', {
          'winnerSocketID': roomDataProvider.playerModel1.socketID,
          'roomID': roomDataProvider.roomData['_id']
        });
      } else {
        showGameDialog(context,
            '${roomDataProvider.playerModel2.playername} won the round');
        socketClient.emit('winner', {
          'winnerSocketID': roomDataProvider.playerModel2.socketID,
          'roomID': roomDataProvider.roomData['_id']
        });
      }
    }
  }
}
