import 'package:drive_me_application_v02/Componets/error_message.dart';
import 'package:drive_me_application_v02/Componets/imageLoginOption.dart';
import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Componets/myTextField_Password.dart';
import 'package:drive_me_application_v02/User%20Module/Screen/Role_Selection_Screen.dart';
import 'package:drive_me_application_v02/Login%20Module/Services/auth_service.dart';
import 'package:drive_me_application_v02/Login%20Module/Style/background_style.dart';
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

  // Método para iniciar sesión
  Future<void> iniciarSesion() async {
    // Mostrar un círculo de carga mientras se inicia la sesión
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Navigator.pop(context);
        mostrarMensajeError(
            context, "Por favor, ingresa el correo y la contraseña");
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      // Obtener el usuario actual
      User? user = userCredential.user;

      if (user != null) {
        // Recargar usuario para asegurarse de que emailVerified esté actualizado
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        if (!user!.emailVerified) {
          // Si el email no está verificado, mostrar mensaje y opción para reenviar
          Navigator.pop(context); // Cerrar el círculo de carga
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.deepPurple,
                title: const Text(
                  'Correo no verificado',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  'Debes verificar tu correo electrónico antes de iniciar sesión.\n\n¿Quieres que te enviemos un nuevo correo de verificación?',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Cerrar el diálogo
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await user?.sendEmailVerification();
                      Navigator.pop(context); // Cerrar el diálogo
                      mostrarMensajeError(context,
                          'Se ha enviado un nuevo correo de verificación a: ${user?.email}');
                    },
                    child: const Text(
                      'Reenviar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
          return;
        }

        // Finalización del círculo de carga
        Navigator.pop(context);

        // Redireccionar a HomePage si el correo está verificado
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const RoleSelectionScreen()));
      }
    } on FirebaseAuthException catch (e) {
      // Finalización del círculo de carga
      Navigator.pop(context);

      // Mensajes de error
      switch (e.code) {
        case 'invalid-email':
          mostrarMensajeError(context, 'E-mail inválido');
          break;
        case 'user-not-found':
          mostrarMensajeError(
              context, 'No se encontró un usuario con ese correo electrónico');
          break;
        case 'wrong-password':
          mostrarMensajeError(context, 'Contraseña incorrecta');
          break;
        default:
          mostrarMensajeError(context, 'Error desconocido: ${e.code}');
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
                  heigthContainerBlur: 480,
                  widthContainerBlur: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //TextFiel e-mail
                      MyTextField(
                          controller: emailController,
                          obscureText: false,
                          hintText: 'e-mail'),

                      //TextFiel Passsword
                      MyTextFielPassword(
                          controller: passwordController, hintText: 'Password'),

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
