import 'package:dmms/Features/branches/data/models/branch.dart';
import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authenticated_user.freezed.dart';
part 'authenticated_user.g.dart';

@freezed
sealed class AuthenticatedUser with _$AuthenticatedUser {
  const factory AuthenticatedUser({
    required String id,
    required String firstName,
    required String lastName,
    required String userName,
    required String nationalId,
    required String branchId,
    required String departmentId,
    required bool isNotificationEnabled,
    required Department department,
    required List<String> roles,
    required Branch branch,
  }) = _AuthenticatedUser;
  factory AuthenticatedUser.fromJson(Map<String, Object?> json) =>
      _$AuthenticatedUserFromJson(json);
}
