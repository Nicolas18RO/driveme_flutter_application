import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Domain/Repository/vehicle_repository.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Domain/vehicle.dart';

class CreateVehicle {
  final VehicleRepository repository;

  CreateVehicle(this.repository);

  Future<void> call(Vehicle vehicle) async {
    return await repository.createVehicle(vehicle);
  }
}
