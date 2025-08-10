import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/employees/data/data_providers/employees_data_provider.dart';
import 'package:dmms/Features/employees/data/models/employee.dart';

class EmployeesRepository {
  final _dataProvider = serviceLocator.get<EmployeesDataProvider>();

  Future<List<Employee>> getAll() async {
    final data = await _dataProvider.getAll();
    return data.map((e) => Employee.fromJson(e)).toList();
  }

  Future<dynamic> getById({required String id}) async {
    final data = await _dataProvider.getById(id: id);
    return Employee.fromJson(data);
  }

  Future<List<dynamic>> getInactive() async {
    final data = await _dataProvider.getInactive();
    return data.map((e) => Employee.fromJson(e)).toList();
  }

  Future<List<dynamic>> getByTypeId({required String typeId}) async {
    final data = await _dataProvider.getByTypeId(typeId: typeId);
    return data.map((e) => Employee.fromJson(e)).toList();
  }

  Future<void> activate({required String employeeId}) async {
    await _dataProvider.activate(employeeId: employeeId);
  }

  Future<void> deActivate({required String employeeId}) async {
    await _dataProvider.deActivate(employeeId: employeeId);
  }

  Future<void> update({required Map<String, dynamic> data}) async {
    await _dataProvider.update(data: data);
  }

  Future<void> add({required Map<String, dynamic> data}) async {
    await _dataProvider.add(data: data);
  }
}
