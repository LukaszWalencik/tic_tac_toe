// import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlayerModel {
  final String playername;
  final String socketID;
  final double points;
  final String playerType;
  PlayerModel({
    required this.playername,
    required this.socketID,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'playername': playername,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      playername: map['playername'] ?? 'BRAK',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0,
      playerType: map['playerType'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory PlayerModel.fromJson(String source) =>
  //     PlayerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlayerModel(playername: $playername, socketID: $socketID, points: $points, playerType: $playerType)';
  }
}
