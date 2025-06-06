import '../Repository/customer_repository.dart';
import '../customer.dart';

class CreateCustomer {
  final CustomerRepository repository;

  CreateCustomer(this.repository);

  Future<void> call(Customer customer) async {
    return await repository.createCustomer(customer);
  }
}
