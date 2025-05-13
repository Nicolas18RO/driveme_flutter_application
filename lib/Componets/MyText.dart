import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String texto;
  final double fontSizeText;

  const MyText({super.key, required this.texto, required this.fontSizeText});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
          color: Colors.white,
          fontSize: fontSizeText,
          fontWeight: FontWeight.bold),
    );
  }
}
