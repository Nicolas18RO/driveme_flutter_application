import 'package:drive_me_application_v02/View/_login_or_register.dart';
import 'package:drive_me_application_v02/View/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //Inicio de sesion Correcto
          if (!snapshot.hasData) {
            return const HomeScreen();
          }

          //Inicio de sesion Incorrecto
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
