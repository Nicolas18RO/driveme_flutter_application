import 'package:drive_me_application_v02/Login%20Module/View/_login_or_register.dart';
import 'package:drive_me_application_v02/User%20Module/Screen/Role_Selection_Screen.dart';
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
          //**
          //IMPORTANTE
          //POR CUESTIONES DE TESTING SE NIEGA LA FUNCION !snapshot.hasData
          //PARA SU CORRECTO FUNCIONAMIENTO SE DEBE DE ELIMIAR => !
          //*/
          if (!snapshot.hasData) {
            return const RoleSelectionScreen();
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
