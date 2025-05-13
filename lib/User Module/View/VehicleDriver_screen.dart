import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Componets/myTextFieldDate.dart';
import 'package:drive_me_application_v02/Login%20Module/Style/background_style.dart';
import 'package:flutter/material.dart';

class VehicleDriverScreen extends StatefulWidget {
  final TextEditingController documentDriver;
  final TextEditingController nameDriver;
  final TextEditingController phoneDriver;
  final TextEditingController emailDriver;
  final TextEditingController soatVehicle;

  const VehicleDriverScreen(
      {super.key,
      required this.nameDriver,
      required this.phoneDriver,
      required this.emailDriver,
      required this.documentDriver,
      required this.soatVehicle});

  @override
  State<VehicleDriverScreen> createState() => _VehicleDriverScreenState();
}

class _VehicleDriverScreenState extends State<VehicleDriverScreen> {
  final List<String> vehicleTypes = ['Taxi', 'Taxi Camioneta', 'Furgon'];
  String? selectedVehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Background
          const Background(),

          //ContainerBackground top-right
          Positioned(
              top: -60,
              right: 240,
              child: Transform.rotate(
                angle: 5,
                child: const ContainerBackground(),
              )),

          //ContainerBackground top-right
          Positioned(
              top: -150,
              right: 80,
              child: Transform.rotate(
                angle: 9,
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
                        texto: 'Información del Vehiculo: ', fontSizeText: 20),

                    const SizedBox(height: 20),
                    ContainerBlur(
                        widthContainerBlur: 300,
                        heigthContainerBlur: 430,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              //Dropdown Menu - Type of vehicle
                              DropDownMenu_TypeVehicle(context),

                              //TextFiel Plate of Vehicle
                              MyTextField(
                                  controller: widget.nameDriver,
                                  obscureText: false,
                                  hintText: 'Placa del vehiculo'),

                              //TextField model of vehicle
                              MyTextField(
                                  controller: widget.phoneDriver,
                                  obscureText: false,
                                  hintText: 'Modelo de vehiculo'),

                              //TextField year of vehicle
                              MyTextField(
                                  controller: widget.emailDriver,
                                  obscureText: false,
                                  hintText: 'Año del vehiculo'),

                              MyTextFieldDate(
                                controller: widget.soatVehicle,
                                obscureText: false,
                                hintText: 'Expiración SOAT',
                                isDate: true,
                              ),

                              MyTextFieldDate(
                                controller: widget.soatVehicle,
                                obscureText: false,
                                hintText: 'Expiracion Técnico-Mecánica',
                                isDate: true,
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              MyButton(onTap: () => (), text: 'Enviar')
                            ],
                          ),
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

  DropDownMenu_TypeVehicle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        width: 400,
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.grey.shade200),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              labelStyle: const TextStyle(
                color: Color(0xfff7e6ff),
              ),
            ),
          ),
          child: DropdownMenu<String>(
            initialSelection: vehicleTypes.first,
            label: const Text('Tipo de vehículo'),
            textStyle: const TextStyle(
                color: Color(0xfff7e6ff), fontWeight: FontWeight.bold),
            onSelected: (String? value) {
              setState(() {
                selectedVehicle = value;
              });
            },
            dropdownMenuEntries:
                vehicleTypes.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
