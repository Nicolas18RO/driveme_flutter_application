import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Login%20Module/Style/background_style.dart';
import 'package:drive_me_application_v02/User%20Module/View/VehicleDriver_screen.dart';
import 'package:flutter/material.dart';

class DriversRole extends StatelessWidget {
  final TextEditingController documentDriver;
  final TextEditingController nameDriver;
  final TextEditingController phoneDriver;
  final TextEditingController emailDriver;
  final TextEditingController soatVehicle;

  const DriversRole(
      {super.key,
      required this.nameDriver,
      required this.phoneDriver,
      required this.emailDriver,
      required this.documentDriver,
      required this.soatVehicle});

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
                            //TextFiel document Driver
                            MyTextField(
                                controller: documentDriver,
                                obscureText: false,
                                hintText: 'Documento de identidad'),

                            //TextFiel nameFull Driver
                            MyTextField(
                                controller: nameDriver,
                                obscureText: false,
                                hintText: 'Nombre Completo'),

                            //TextField phone Driver
                            MyTextField(
                                controller: phoneDriver,
                                obscureText: false,
                                hintText: 'Numero de telefono'),

                            //TextField email Driver
                            MyTextField(
                                controller: emailDriver,
                                obscureText: false,
                                hintText: 'Correo Electronico'),

                            const SizedBox(
                              height: 20,
                            ),

                            MyButton(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VehicleDriverScreen(
                                                nameDriver: nameDriver,
                                                phoneDriver: phoneDriver,
                                                emailDriver: emailDriver,
                                                documentDriver: documentDriver,
                                                soatVehicle: soatVehicle,
                                              )));
                                },
                                text: 'Siguiente')
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
