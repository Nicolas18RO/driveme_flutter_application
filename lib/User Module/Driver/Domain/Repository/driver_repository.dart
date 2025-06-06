import '../driver.dart';

abstract class DriverRepository {
  Future<List<Driver>> getAllDrivers();
  Future<Driver> getDriverById(int id);
  Future<void> createDriver(Driver driver);
  Future<void> updateDriver(Driver driver);
  Future<void> deleteDriver(int id);
}
