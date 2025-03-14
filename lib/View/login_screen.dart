import 'dart:ui';
import 'package:drive_me_application_v02/Componets/ImageLoginOption.dart';
import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Componets/Text_Continua_Con.dart';
import 'package:drive_me_application_v02/Services/auth_service.dart';
import 'package:drive_me_application_v02/View/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  // Método para iniciar sesión
  void iniciarSesion() async {
    // Mostrar un círculo de carga mientras se inicia la sesión
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // Intento de inicio de sesión
    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Navigator.pop(context);
        mostrarMensajeError("Por favor, Ingresa el correo y la contraseña");
        return;
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // Finalización del círculo de carga
      Navigator.pop(context);

      // Redireccionar a HomePage
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      // Finalización del círculo de carga
      Navigator.pop(context);

      //Mensajes de Error
      switch (e.code) {
        case 'invalid-email':
          mostrarMensajeError('Correo electrónico inválido');
          break;
        case 'user-not-found':
          mostrarMensajeError(
              'No se encontró un usuario con ese correo electrónico');
          break;
        case 'wrong-password':
          mostrarMensajeError('Contraseña incorrecta');
          break;
        default:
          mostrarMensajeError('Error desconocido: ${e.code}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        //Background
        const Background(),
        //ContainerBackground top-left
        Positioned(
            top: -60,
            left: -60,
            child: Transform.rotate(
              angle: 4.4,
              child: const ContainerBackground(),
            )),

        //ContainerBackground bottom-right
        Positioned(
            bottom: -60,
            right: -90,
            child: Transform.rotate(
              angle: 4.3,
              child: const ContainerBackground(),
            )),

        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Logo
                const Logo(),
                const SizedBox(height: 20),

                //ContainerBlur
                ContainerBlur(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //TextFiel e-mail
                      MyTextField(
                          controller: emailController,
                          obscureText: false,
                          hintText: 'e-mail'),

                      //TextFiel Passsword
                      MyTextField(
                          controller: passwordController,
                          obscureText: true,
                          hintText: 'Password'),

                      //Button Login
                      const SizedBox(height: 10),
                      MyButton(onTap: () => iniciarSesion(), text: 'Login'),

                      //Text Continua Con...
                      const SizedBox(height: 65),
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
                            'No estás registrado?',
                            style: TextStyle(color: Color(0xfff7e6ff)),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Regístrate Ahora',
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
              ],
            ),
          ),
        ),
      ],
    ));
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
