import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Login%20Module/Style/background_style.dart';
import 'package:flutter/material.dart';

class CustomersRole extends StatelessWidget {
  final TextEditingController documentCustomer;
  final TextEditingController nameCustomer;
  final TextEditingController phoneCustomer;
  final TextEditingController emailCustomer;

  const CustomersRole(
      {super.key,
      required this.nameCustomer,
      required this.phoneCustomer,
      required this.emailCustomer,
      required this.documentCustomer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Background
          const Background(),

          //ContainerBackground top-right
          Positioned(
              top: -50,
              left: 200,
              child: Transform.rotate(
                angle: 4.5,
                child: const ContainerBackground(),
              )),

          //ContainerBackground top-right
          Positioned(
              top: -150,
              left: 80,
              child: Transform.rotate(
                angle: 8,
                child: const ContainerBackground(),
              )),

          Align(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    //Logo
                    const SizedBox(height: 30),
                    const Logo(),
                    const SizedBox(height: 20),

                    const MyText(
                        texto: 'Completa todos los campos: ', fontSizeText: 20),

                    const SizedBox(height: 20),
                    ContainerBlur(
                        widthContainerBlur: 300,
                        heigthContainerBlur: 430,
                        child: Column(
                          children: [
                            //TextFiel document Customer
                            MyTextField(
                                controller: documentCustomer,
                                obscureText: false,
                                hintText: 'Documento de identidad'),

                            //TextFiel nameFull Customer
                            MyTextField(
                                controller: nameCustomer,
                                obscureText: false,
                                hintText: 'Nombre Completo'),

                            //TextField phone Customer
                            MyTextField(
                                controller: phoneCustomer,
                                obscureText: false,
                                hintText: 'Numero de telefono'),

                            //TextField email Customer
                            MyTextField(
                                controller: emailCustomer,
                                obscureText: false,
                                hintText: 'Correo Electronico'),

                            const SizedBox(
                              height: 20,
                            ),

                            MyButton(onTap: () => (), text: 'Enviar')
                          ],
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
