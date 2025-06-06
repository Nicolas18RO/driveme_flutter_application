import 'package:drive_me_application_v02/Componets/MyButton.dart';
import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:drive_me_application_v02/Componets/MyTextField.dart';
import 'package:drive_me_application_v02/Home%20Module/Screen/home_screen.dart';
import 'package:drive_me_application_v02/Login%20Module/Style/background_style.dart';
import 'package:drive_me_application_v02/User%20Module/Customer/Data/DataSources/customer_remote_datasource_impl.dart';
import 'package:drive_me_application_v02/User%20Module/Customer/Data/Repositories/customer_repository_impl.dart';
import 'package:drive_me_application_v02/User%20Module/Customer/Domain/Use%20Cases/create_new_customer_use_case.dart';
import 'package:drive_me_application_v02/User%20Module/Customer/Domain/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                            // MyTextField(
                            //     controller: emailCustomer,
                            //     obscureText: false,
                            //     hintText: 'Correo Electronico'),

                            const SizedBox(
                              height: 20,
                            ),

                            MyButton(
                                onTap: () async {
                                  final String userEmail =
                                      FirebaseAuth.instance.currentUser!.email!;
                                  final customer = Customer(
                                    id_customer:
                                        0, // It's zero because is generated for the Backend
                                    document_customer: documentCustomer.text,
                                    email_customer: userEmail,
                                    full_name_customer: nameCustomer.text,
                                    phone_customer: phoneCustomer.text,
                                  );

                                  final client = http.Client();
                                  final dataSource =
                                      CustomerRemoteDataSourceImpl(
                                          client: client);
                                  final repository = CustomerRepositoryImpl(
                                      remoteDataSource: dataSource);

                                  final createCustomerUseCase =
                                      CreateCustomer(repository);

                                  try {
                                    await createCustomerUseCase(customer);
                                    // Clear the text fields
                                    documentCustomer.clear();
                                    emailCustomer.clear();
                                    nameCustomer.clear();
                                    phoneCustomer.clear();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  } catch (e) {
                                    // Mostrar error en la UI
                                    print('Error creating Customer: $e');
                                  }
                                },
                                text: 'Enviar')
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
