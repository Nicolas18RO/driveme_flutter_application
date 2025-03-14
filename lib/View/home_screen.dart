import 'package:drive_me_application_v02/View/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Home Screen"),
      leading: IconButton(
        icon: Icon(Icons.home),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(
                        onTap: () {},
                      )), // Reemplaza con tu pantalla de inicio
              (route) => false // Elimina todas las pantallas anteriores
              );
        },
      ),
    );
  }
}
