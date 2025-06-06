import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Data/Models/vehicle_model.dart';

abstract class VehicleRemoteDataSource {
  Future<List<VehicleModel>> getAllVehicles();
  Future<VehicleModel> getVehicleByPlate(String plate);
  Future<void> createVehicle(VehicleModel vehicle);
  Future<void> updateVehicle(VehicleModel vehicle);
  Future<void> deleteVehicle(String plate);
}
