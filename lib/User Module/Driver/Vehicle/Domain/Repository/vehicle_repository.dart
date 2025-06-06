import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Domain/vehicle.dart';

abstract class VehicleRepository {
  Future<List<Vehicle>> getAllVehicles();
  Future<Vehicle> getVehicleByPlate(String plate);
  Future<void> createVehicle(Vehicle vehicle);
  Future<void> updateVehicle(Vehicle vehicle);
  Future<void> deleteVehicle(String plate);
}
