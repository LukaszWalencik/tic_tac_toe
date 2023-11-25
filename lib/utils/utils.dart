import 'package:flutter/material.dart';

void showGameDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Play Again'),
          ),
        ],
      );
    },
  );
}
