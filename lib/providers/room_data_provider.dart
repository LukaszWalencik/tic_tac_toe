import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/player_model.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];

  int _filledBoxes = 0;

  bool _absorbingValue = true;

  bool get absorbingValue => _absorbingValue;

  PlayerModel _playerModel1 =
      PlayerModel(playername: '', socketID: '', points: 0, playerType: 'X');

  PlayerModel _playerModel2 =
      PlayerModel(playername: '', socketID: '', points: 0, playerType: '0');

  PlayerModel get playerModel1 => _playerModel1;
  PlayerModel get playerModel2 => _playerModel2;

  Map<String, dynamic> get roomData => _roomData;

  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;

  void updateAbsorbingToTrue() {
    _absorbingValue = true;
  }

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    _absorbingValue =
        _roomData['turn']['socketID'] != SocketMethod().socketClient.id;
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

  void setFilledBoxesTo0() {
    _filledBoxes = 0;
  }
}
