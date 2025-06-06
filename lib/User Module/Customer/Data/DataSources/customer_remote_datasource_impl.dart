import 'dart:convert';
import 'package:drive_me_application_v02/User%20Module/Customer/Data/DataSources/customer_remote_datasource.dart';
import 'package:drive_me_application_v02/User%20Module/Customer/Data/Models/customer_model.dart';
import 'package:http/http.dart' as http;

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final http.Client client;

  CustomerRemoteDataSourceImpl({required this.client});

  final String baseUrl = 'http://10.0.2.2:8000/api/customer/';

  @override
  Future<List<CustomerModel>> getAllCustomers() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      return decoded.map((json) => CustomerModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  @override
  Future<CustomerModel> getCustomerById(int id) async {
    final response = await client.get(Uri.parse('$baseUrl$id/'));

    if (response.statusCode == 200) {
      return CustomerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Customer not found');
    }
  }

  @override
  Future<void> createCustomer(CustomerModel customer) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(customer.toJson()),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode != 201) {
      throw Exception('Failed to create customer');
    }
  }

  @override
  Future<void> updateCustomer(CustomerModel customer) async {
    final response = await client.put(
      Uri.parse('$baseUrl${customer.id_customer}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(customer.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update customer');
    }
  }

  @override
  Future<void> deleteCustomer(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl$id/'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete customer');
    }
  }
}
