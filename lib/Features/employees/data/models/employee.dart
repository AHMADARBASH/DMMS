import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:dmms/Features/employees/data/models/employee_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.g.dart';
part 'employee.freezed.dart';

@freezed
abstract class Employee with _$Employee {
  const factory Employee({
    required String id,
    required String firstName,
    required String lastName,
    required String birthDate,
    required String nationalId,
    required String departmentId,
    required String typeId,
    required String position,
    required String phoneNumber1,
    String? phoneNumber2,
    required bool isActive,
    required String bloodType,
    required Department department,
    required EmployeeType type,
  }) = _Employee;
  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
}
