import 'package:drive_me_application_v02/User%20Module/Driver/Domain/Repository/driver_repository.dart';
import 'package:drive_me_application_v02/User%20Module/Driver/Domain/driver.dart';

class CreateDriver {
  final DriverRepository repository;

  CreateDriver(this.repository);

  Future<void> call(Driver driver) async {
    return await repository.createDriver(driver);
  }
}
