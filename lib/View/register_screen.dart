import 'package:drive_me_application_v02/Componets/imageLoginOption.dart';
import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Componets/myTextField_Password.dart';
import 'package:drive_me_application_v02/Services/auth_service.dart';
import 'package:drive_me_application_v02/Style/background_style.dart';
import 'package:drive_me_application_v02/View/login_screen.dart';
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
  Future<void> registrarSesion() async {
    // Mostrar un círculo de carga mientras se inicia la sesión
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      // Confirmar si la contraseña está confirmada
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

        // Obtener el usuario actual
        User? user = userCredential.user;

        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();

          // Cerrar el círculo de carga
          Navigator.pop(context);

          // Mostrar mensaje de verificación y esperar a que el usuario lo cierre
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: const Color.fromARGB(255, 198, 178, 233),
                title: const Text(
                  'Verificación de correo',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  'Se ha enviado un correo de verificación a: ${user.email}',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Cerrar el diálogo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(onTap: () {}),
                        ),
                      );
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Cerrar el círculo de carga
        Navigator.pop(context);
        // Mostrar mensaje de error
        mostrarMensajeError("¡Las contraseñas no coinciden!");
      }
    } on FirebaseAuthException catch (e) {
      // Cerrar el círculo de carga
      Navigator.pop(context);
      // Mostrar mensaje de error
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
                          MyTextFielPassword(
                              controller: passwordController,
                              hintText: 'Enter your password'),

                          //TextFiel Confirm Password
                          MyTextFielPassword(
                              controller: confirmPasswordController,
                              hintText: 'Confirm your password'),

                          //Button Register
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
