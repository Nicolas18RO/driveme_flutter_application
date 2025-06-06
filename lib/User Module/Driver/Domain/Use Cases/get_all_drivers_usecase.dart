import '../driver.dart';
import '../Repository/driver_repository.dart';

class GetAllDriversUseCase {
  final DriverRepository repository;

  GetAllDriversUseCase({required this.repository});

  Future<List<Driver>> call() async {
    return await repository.getAllDrivers();
  }
}
