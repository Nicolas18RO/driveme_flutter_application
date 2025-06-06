import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Componets/myTextFieldDate.dart';
import 'package:drive_me_application_v02/Login%20Module/Style/background_style.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Data/DataSources/vehicle_remote_datasources_impl.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Data/Repository/vehicle_repositories_impl.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Domain/Use%20Cases/create_new_vehicle_usecase.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Domain/vehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleDriverScreen extends StatefulWidget {
  const VehicleDriverScreen({
    super.key,
  });

  @override
  State<VehicleDriverScreen> createState() => _VehicleDriverScreenState();
}

class _VehicleDriverScreenState extends State<VehicleDriverScreen> {
  final TextEditingController documentDriver = TextEditingController();
  final TextEditingController plateVehicle = TextEditingController();
  final TextEditingController modelVehicle = TextEditingController();
  final TextEditingController yearVehicle = TextEditingController();
  final TextEditingController soatVehicle = TextEditingController();
  final TextEditingController tecnicoMecanicaVehicle = TextEditingController();

  final List<String> vehicleTypes = ['Taxi', 'Taxi Camioneta', 'Furgon'];
  String? selectedVehicle;

  DateTime? _parseVehicleDate(String dateText) {
    if (dateText.isEmpty) return null;

    try {
      // Matches the format used in MyTextFieldDate (dd/mm/yyyy)
      final parts = dateText.split('/');
      if (parts.length != 3) return null;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      return DateTime(year, month, day);
    } catch (e) {
      debugPrint('Error parsing vehicle date: $e');
      return null;
    }
  }

  //========================================================================================================

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
                                  controller: plateVehicle,
                                  obscureText: false,
                                  hintText: 'Placa del vehiculo'),

                              //TextField model of vehicle
                              MyTextField(
                                  controller: modelVehicle,
                                  obscureText: false,
                                  hintText: 'Modelo de vehiculo'),

                              //TextField year of vehicle
                              MyTextField(
                                  controller: yearVehicle,
                                  obscureText: false,
                                  hintText: 'Año del vehiculo'),

                              MyTextFieldDate(
                                controller: soatVehicle,
                                obscureText: false,
                                hintText: 'Expiración SOAT',
                                isDate: true,
                              ),

                              MyTextFieldDate(
                                controller: tecnicoMecanicaVehicle,
                                obscureText: false,
                                hintText: 'Expiracion Técnico-Mecánica',
                                isDate: true,
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              MyButton(
                                  onTap: () async {
                                    final String userEmail = FirebaseAuth
                                        .instance.currentUser!.email!;

                                    final vehicle = Vehicle(
                                      plate: plateVehicle.text,
                                      driver: 0,
                                      model: modelVehicle.text,
                                      typeVehicle: 0,
                                      year: yearVehicle.text,
                                      soatExpiration:
                                          _parseVehicleDate(soatVehicle.text),
                                      tecnicoMecanicaExpiration:
                                          _parseVehicleDate(
                                              tecnicoMecanicaVehicle.text),
                                    );

                                    final client = http.Client();
                                    final dataSource =
                                        VehicleRemoteDataSourceImpl(
                                            client: client);
                                    final repository = VehicleRepositoryImpl(
                                        remoteDataSource: dataSource);

                                    final createDriverUseCase =
                                        CreateVehicle(repository);

                                    try {
                                      await createDriverUseCase(vehicle);
                                      // Clear the text fields
                                      plateVehicle.clear();
                                      modelVehicle.clear();
                                      yearVehicle.clear();
                                      soatVehicle.clear();
                                      tecnicoMecanicaVehicle.clear();
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
                                  text: 'Enviar')
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
