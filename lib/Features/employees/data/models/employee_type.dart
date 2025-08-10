import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_type.freezed.dart';
part 'employee_type.g.dart';

@freezed
abstract class EmployeeType with _$EmployeeType {
  const factory EmployeeType({
    required String id,
    required String name,
  }) = _EmployeeType;

  factory EmployeeType.fromJson(Map<String, Object?> json) =>
      _$EmployeeTypeFromJson(json);
}
