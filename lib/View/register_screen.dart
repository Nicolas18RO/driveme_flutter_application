import 'dart:ui';

import 'package:drive_me_application_v02/Componets/ImageLoginOption.dart';
import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Componets/Text_Continua_Con.dart';
import 'package:drive_me_application_v02/Services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void mostrarMensajeError(String mensaje) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                mensaje,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  //Metodo Registrar ususario de Sesion
  void registrarSesion() async {
    //Mostrar un circulo de carga mientras se inisia la sesion
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //Intento de crear usuario de sesion
    try {
      //Confirmar si la contraseña está confirmada
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        //Mostrar mensaje de Error
        mostrarMensajeError("¡Las contraseñas no Coinciden!");
      }
      //Finalizacion de ciruculo de carga
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //Finalizacion de ciruculo de carga
      Navigator.pop(context);
      //Mostrar mensaje de Error
      mostrarMensajeError(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Backgorund
          const Background(),

          //Contianer bottom-left
          const Positioned(
              bottom: -50, left: -50, child: ContainerBackground()),

          //Container top-right
          const Positioned(top: -50, right: -50, child: ContainerBackground()),

          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Logo
                  //Logo
                  const Logo(),
                  const SizedBox(height: 20),

                  //ContainerBlur
                  ContainerBlur(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Text Register Now!
                          const Text(
                            'Register Now!',
                            style: TextStyle(
                                color: Color(0xffffe6d5),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 0),

                          //TextFiel e-mail
                          MyTextField(
                              controller: emailController,
                              obscureText: false,
                              hintText: 'e-mail'),

                          //TextFiel Passsword
                          MyTextField(
                              controller: passwordController,
                              obscureText: true,
                              hintText: 'Enter your password'),

                          //TextFiel Confirm Password
                          MyTextField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              hintText: 'Confirm your password'),

                          //Button Login
                          const SizedBox(height: 10),
                          MyButton(
                              onTap: () => registrarSesion(), text: 'Register'),

                          //Text Continua Con...
                          const SizedBox(height: 35),
                          const Text_Continua_Con(),

                          //Login with google
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageLoginOption(
                                  onTap: AuthService().singInWithGoogle,
                                  imagePath: 'lib/Images/Google_Logo.png'),
                            ],
                          ),

                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Ya tienes una cuenta?',
                                style: TextStyle(color: Color(0xfff7e6ff)),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: widget.onTap,
                                child: const Text(
                                  'Inicia Ahora',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color(0xff740f80),
        Color(0xFFBD11DF),
        Color(0xFFEB6AFF)
      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
    );
  }
}

//--------------------------- WIDGETS ------------------------------------------
class ContainerBackground extends StatelessWidget {
  const ContainerBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: <Color>[
          Color(0xFFF90909),
          Color(0xFFFF5B5B),
          Color(0xFFFFDEDE)
        ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CircleAvatar(
        minRadius: 70,
        backgroundImage: AssetImage(
          'lib/Images/LogoDM.png',
        ),
      ),
    );
  }
}

class ContainerBlur extends StatelessWidget {
  final Widget child;
  const ContainerBlur({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 300,
          height: 480,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(40)),
          child: child,
        ),
      ),
    );
  }
}
