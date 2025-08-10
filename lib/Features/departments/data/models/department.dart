import 'package:dmms/Features/branches/data/models/branch.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'department.freezed.dart';
part 'department.g.dart';

@freezed
sealed class Department with _$Department {
  const factory Department({
    required String id,
    required String name,
    required String branchId,
    Branch? branch,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
}
