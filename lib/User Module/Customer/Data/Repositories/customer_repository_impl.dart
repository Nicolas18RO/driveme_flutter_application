import 'package:drive_me_application_v02/User%20Module/Customer/Data/Models/customer_model.dart';

import '../../Domain/Repository/customer_repository.dart';
import '../../Domain/customer.dart';
import '../DataSources/customer_remote_datasource.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Customer>> getAllCustomers() async {
    final models = await remoteDataSource.getAllCustomers();
    return models;
  }

  @override
  Future<Customer> getCustomerById(int id) async {
    return await remoteDataSource.getCustomerById(id);
  }

  @override
  @override
  Future<void> createCustomer(Customer customer) async {
    final model = CustomerModel(
      id_customer: customer.id_customer,
      full_name_customer: customer.full_name_customer,
      phone_customer: customer.phone_customer,
      document_customer: customer.document_customer,
      email_customer: customer.email_customer,
    );
    await remoteDataSource.createCustomer(model);
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await remoteDataSource.updateCustomer(customer as CustomerModel);
  }

  @override
  Future<void> deleteCustomer(int id) async {
    await remoteDataSource.deleteCustomer(id);
  }
}
