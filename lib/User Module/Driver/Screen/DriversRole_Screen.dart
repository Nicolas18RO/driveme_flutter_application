import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Login%20Module/Style/background_style.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Data/DataSources/driver_remote_datasources_impl.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Domain/driver.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Screen/VehicleDriver_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Data/Repositories/driver_repositories_impl.dart';
import '../Domain/Use Cases/create_new_driver_usecase.dart';

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
                            // MyTextField(
                            //     controller: emailDriver,
                            //     obscureText: false,
                            //     hintText: 'Correo Electronico'),

                            const SizedBox(
                              height: 20,
                            ),

                            MyButton(
                              onTap: () async {
                                final String userEmail =
                                    FirebaseAuth.instance.currentUser!.email!;

                                final driver = Driver(
                                  id_drive:
                                      0, // It's zero because is generated for the Backend
                                  document_driver: documentDriver.text,
                                  full_name_driver: nameDriver.text,
                                  email_driver: userEmail,
                                  phone_driver: phoneDriver.text,
                                );

                                final client = http.Client();
                                final dataSource =
                                    DriverRemoteDataSourceImpl(client: client);
                                final repository = DriverRepositoryImpl(
                                    remoteDataSource: dataSource);

                                final createDriverUseCase =
                                    CreateDriver(repository);

                                try {
                                  await createDriverUseCase(driver);
                                  // Clear the text fields
                                  documentDriver.clear();
                                  nameDriver.clear();
                                  emailDriver.clear();
                                  phoneDriver.clear();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VehicleDriverScreen(),
                                    ),
                                  );
                                } catch (e) {
                                  // Mostrar error en la UI
                                  print('Error creating driver: $e');
                                }
                              },
                              text: 'Siguiente',
                            )
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
