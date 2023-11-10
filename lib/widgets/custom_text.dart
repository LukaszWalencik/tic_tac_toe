import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<Shadow> shadows;
  const CustomText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.shadows});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows),
    );
  }
}
