import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/departments/data/data_providers/departments_data_provider.dart';
import 'package:dmms/Features/departments/data/models/department.dart';

class DepartmentsRepository {
  final _dataProvider = serviceLocator.get<DepartmentsDataProvider>();

  Future<List<Department>> getAllDepartments() async {
    final data = await _dataProvider.getAllDepartments();
    return data.map((e) => Department.fromJson(e)).toList();
  }

  Future<List<Department>> getByBranchId({required String branchId}) async {
    final data = await _dataProvider.getByBranchId(branchId: branchId);
    return data.map((e) => Department.fromJson(e)).toList();
  }

  Future<void> addDepartment({required Map<String, dynamic> data}) async {
    await _dataProvider.addDepartment(data: data);
  }
}
