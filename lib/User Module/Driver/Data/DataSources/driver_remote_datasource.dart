import '../Models/driver_model.dart';

abstract class DriverRemoteDataSource {
  Future<List<DriverModel>> getAllDrivers();
  Future<DriverModel> getDriverById(int id);
  Future<void> createDriver(DriverModel driver);
  Future<void> updateDriver(DriverModel driver);
  Future<void> deleteDriver(int id);
}
