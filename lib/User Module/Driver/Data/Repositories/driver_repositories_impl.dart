import 'package:drive_me_application_v02/User%20Module/Driver/Data/DataSources/driver_remote_datasource.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Domain/Repository/driver_repository.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Domain/driver.dart';
import '../Models/driver_model.dart';

class DriverRepositoryImpl implements DriverRepository {
  final DriverRemoteDataSource remoteDataSource;

  DriverRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Driver>> getAllDrivers() async {
    final models = await remoteDataSource.getAllDrivers();
    return models;
  }

  @override
  Future<Driver> getDriverById(int id) async {
    return await remoteDataSource.getDriverById(id);
  }

  @override
  @override
  Future<void> createDriver(Driver driver) async {
    final model = DriverModel(
      id_drive: driver.id_drive,
      document_driver: driver.document_driver,
      full_name_driver: driver.full_name_driver,
      email_driver: driver.email_driver,
      phone_driver: driver.phone_driver,
    );
    await remoteDataSource.createDriver(model);
  }

  @override
  Future<void> updateDriver(Driver driver) async {
    await remoteDataSource.updateDriver(driver as DriverModel);
  }

  @override
  Future<void> deleteDriver(int id) async {
    await remoteDataSource.deleteDriver(id);
  }
}
