import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:drive_me_application_v02/Login%20Module/Style/background_style.dart';
import 'package:drive_me_application_v02/User%20Module/Customer/Screen/CustomersRole_Screen.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Screen/DriversRole_Screen.dart';
import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Background
          const Background(),

          //ContainerBackground top-left
          Positioned(
              top: -50,
              left: -130,
              child: Transform.rotate(
                angle: 4.4,
                child: const ContainerBackground(),
              )),

          //ContainerBackground top-right
          Positioned(
              top: -50,
              left: 200,
              child: Transform.rotate(
                angle: 4.5,
                child: const ContainerBackground(),
              )),

          //ContainerBackground bottom-right
          Positioned(
              bottom: -60,
              right: -90,
              child: Transform.rotate(
                angle: 4.2,
                child: const ContainerBackground(),
              )),

          Align(
            child: Center(
              child: Column(
                children: [
                  //Logo
                  const SizedBox(height: 50),
                  const Logo(),

                  const SizedBox(height: 30),
                  ContainerBlur(
                      heigthContainerBlur: 300,
                      widthContainerBlur: 300,
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          const MyText(
                            texto: 'Selecciona el Rol:',
                            fontSizeText: 25,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //My button Pasajero
                                MyButton(
                                  onTap: () {
                                    TextEditingController _documentController =
                                        TextEditingController();
                                    TextEditingController _nameController =
                                        TextEditingController();
                                    TextEditingController _phoneController =
                                        TextEditingController();
                                    TextEditingController _emailController =
                                        TextEditingController();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CustomersRole(
                                          documentCustomer: _documentController,
                                          nameCustomer: _nameController,
                                          phoneCustomer: _phoneController,
                                          emailCustomer: _emailController,
                                        ),
                                      ),
                                    );
                                  },
                                  text: 'Pasajero',
                                ),

                                //My button Conductor
                                MyButton(
                                  onTap: () {
                                    TextEditingController _documentController =
                                        TextEditingController();
                                    TextEditingController _nameController =
                                        TextEditingController();
                                    TextEditingController _phoneController =
                                        TextEditingController();
                                    TextEditingController _emailController =
                                        TextEditingController();
                                    TextEditingController _vehicleController =
                                        TextEditingController();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DriversRole(
                                          documentDriver: _documentController,
                                          nameDriver: _nameController,
                                          phoneDriver: _phoneController,
                                          emailDriver: _emailController,
                                          soatVehicle: _vehicleController,
                                        ),
                                      ),
                                    );
                                  },
                                  text: 'Conductor',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
