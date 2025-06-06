import 'dart:convert';
import 'package:drive_me_application_v02/User%20Module/Driver/Data/DataSources/driver_remote_datasource.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Data/Models/driver_model.dart';
import 'package:http/http.dart' as http;

class DriverRemoteDataSourceImpl implements DriverRemoteDataSource {
  final http.Client client;

  DriverRemoteDataSourceImpl({required this.client});

  final String baseUrl = 'http://10.0.2.2:8000/api/driver/';

  @override
  Future<List<DriverModel>> getAllDrivers() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      return decoded.map((json) => DriverModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load drivers');
    }
  }

  @override
  Future<DriverModel> getDriverById(int id) async {
    final response = await client.get(Uri.parse('$baseUrl$id/'));

    if (response.statusCode == 200) {
      return DriverModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Driver not found');
    }
  }

  @override
  Future<void> createDriver(DriverModel driver) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(driver.toJson()),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode != 201) {
      throw Exception('Failed to create driver');
    }
  }

  @override
  Future<void> updateDriver(DriverModel driver) async {
    final response = await client.put(
      Uri.parse('$baseUrl${driver.id_drive}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(driver.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update driver');
    }
  }

  @override
  Future<void> deleteDriver(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl$id/'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete driver');
    }
  }
}
