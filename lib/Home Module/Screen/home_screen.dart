import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(texto: 'Home Screen', fontSizeText: 20),
      ),
    );
  }
}
