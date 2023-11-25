import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  SocketMethod socketMethod = SocketMethod();
  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        // if true then cannot clic. If false its clicable.
        absorbing: roomDataProvider.roomData['turn']['socketID'] !=
            socketMethod.socketClient.id,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                socketMethod.updateGrid(index, roomDataProvider.roomData['_id'],
                    roomDataProvider.displayElements);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                  child: Text(
                    roomDataProvider.displayElements[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      shadows: [
                        Shadow(
                            color:
                                roomDataProvider.displayElements[index] == '0'
                                    ? Colors.blue
                                    : Colors.red,
                            blurRadius: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
