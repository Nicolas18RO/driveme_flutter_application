import 'package:drive_me_application_v02/User%20Module/Customer/Domain/customer.dart';

class CustomerModel extends Customer {
  CustomerModel({
    required int id_customer,
    required String full_name_customer,
    required String phone_customer,
    required String document_customer,
    required String email_customer,
  }) : super(
          id_customer: id_customer,
          full_name_customer: full_name_customer,
          phone_customer: phone_customer,
          document_customer: document_customer,
          email_customer: email_customer,
        );

  // Factory constructor to create a DriverModel from JSON
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id_customer: json['id_customer'],
      full_name_customer: json['full_name_customer'],
      phone_customer: json['phone_customer'],
      document_customer: json['document_customer'],
      email_customer: json['email_customer'],
    );
  }

  // Method to convert a DriverModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_customer': id_customer,
      'full_name_customer': full_name_customer,
      'phone_customer': phone_customer,
      'document_customer': document_customer,
      'email_customer': email_customer,
    };
  }
}
