import 'package:drive_me_application_v02/View/login_screen.dart';
import 'package:drive_me_application_v02/View/register_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //Inicialmente se mostrará LoginPage
  bool showLoginScreen = true;

  //Luego entre login y Register page
  void togglePage() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        onTap: togglePage,
      );
    } else {
      return RegisterScreen(onTap: togglePage);
    }
  }
}
