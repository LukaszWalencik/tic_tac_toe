import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/player_model.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  Map<String, dynamic> get roomData => _roomData;
  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;

  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;
  PlayerModel _playerModel1 =
      PlayerModel(playername: '', socketID: '', points: 0, playerType: ')');

  PlayerModel _playerModel2 =
      PlayerModel(playername: '', socketID: '', points: 0, playerType: 'X');

  PlayerModel get playerModel1 => _playerModel1;
  PlayerModel get playerModel2 => _playerModel2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _playerModel1 = PlayerModel.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _playerModel2 = PlayerModel.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }
}
