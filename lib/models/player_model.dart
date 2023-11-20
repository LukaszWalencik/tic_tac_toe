import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlayerModel {
  final String playerName;
  final String socketID;
  final double points;
  final String playerType;
  PlayerModel({
    required this.playerName,
    required this.socketID,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playerName': playerName,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      playerName: map['playerName'] ?? '',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0,
      playerType: map['playerType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerModel.fromJson(String source) =>
      PlayerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
