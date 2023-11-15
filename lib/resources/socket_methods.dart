import 'package:socket_io_client/socket_io_client.dart';

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
}
