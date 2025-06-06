import 'package:drive_me_application_v02/User%20Module/Driver/Domain/driver.dart';

class DriverModel extends Driver {
  DriverModel({
    required int id_drive,
    required String document_driver,
    required String full_name_driver,
    required String email_driver,
    required String phone_driver,
  }) : super(
          id_drive: id_drive,
          document_driver: document_driver,
          full_name_driver: full_name_driver,
          email_driver: email_driver,
          phone_driver: phone_driver,
        );

  // Factory constructor to create a DriverModel from JSON
  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id_drive: json['id_drive'],
      document_driver: json['document_driver'],
      full_name_driver: json['full_name_driver'],
      email_driver: json['email_driver'],
      phone_driver: json['phone_driver'],
    );
  }

  // Method to convert a DriverModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_drive': id_drive,
      'document_driver': document_driver,
      'full_name_driver': full_name_driver,
      'email_driver': email_driver,
      'phone_driver': phone_driver,
    };
  }
}
