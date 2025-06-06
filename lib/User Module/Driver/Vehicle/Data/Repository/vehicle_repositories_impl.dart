import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Data/DataSources/vehicle_remote_datasource.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Data/Models/vehicle_model.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Domain/Repository/vehicle_repository.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Domain/vehicle.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Vehicle>> getAllVehicles() async {
    final models = await remoteDataSource.getAllVehicles();
    return models;
  }

  @override
  Future<Vehicle> getVehicleByPlate(String plate) async {
    return await remoteDataSource.getVehicleByPlate(plate);
  }

  @override
  @override
  Future<void> createVehicle(Vehicle vehicle) async {
    final model = VehicleModel(
      plate: vehicle.plate,
      driver: vehicle.driver,
      typeVehicle: vehicle.typeVehicle,
      model: vehicle.model,
      year: vehicle.year,
      soatExpiration: vehicle.soatExpiration,
      tecnicoMecanicaExpiration: vehicle.tecnicoMecanicaExpiration,
    );
    await remoteDataSource.createVehicle(model);
  }

  @override
  Future<void> updateVehicle(Vehicle vehicle) async {
    await remoteDataSource.updateVehicle(vehicle as VehicleModel);
  }

  @override
  Future<void> deleteVehicle(String plate) async {
    await remoteDataSource.deleteVehicle(plate);
  }
}
