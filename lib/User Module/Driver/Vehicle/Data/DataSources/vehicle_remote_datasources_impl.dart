import 'dart:convert';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Data/DataSources/vehicle_remote_datasource.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Data/Models/vehicle_model.dart';
import 'package:http/http.dart' as http;

class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {
  final http.Client client;

  VehicleRemoteDataSourceImpl({required this.client});

  final String baseUrl = 'http://10.0.2.2:8000/api/vehicle/';

  @override
  Future<List<VehicleModel>> getAllVehicles() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      return decoded.map((json) => VehicleModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  @override
  Future<VehicleModel> getVehicleByPlate(String plate) async {
    final response = await client.get(Uri.parse('$baseUrl$plate/'));

    if (response.statusCode == 200) {
      return VehicleModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Vehicle not found');
    }
  }

  @override
  Future<void> createVehicle(VehicleModel vehicle) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(vehicle.toJson()),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode != 201) {
      throw Exception('Failed to create vehicle');
    }
  }

  @override
  Future<void> updateVehicle(VehicleModel vehicle) async {
    final response = await client.put(
      Uri.parse('$baseUrl${vehicle.plate}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(vehicle.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update vehicle');
    }
  }

  @override
  Future<void> deleteVehicle(String plate) async {
    final response = await client.delete(Uri.parse('$baseUrl$plate/'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete vehicle');
    }
  }
}
