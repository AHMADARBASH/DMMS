import 'package:dmms/Features/branches/data/models/branch.dart';
import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_user.freezed.dart';
part 'mission_user.g.dart';

@freezed
abstract class MissionUser with _$MissionUser {
  factory MissionUser({
    required String id,
    required String firstName,
    required String lastName,
    required String birthDate,
    required Department department,
    required Branch branch,
    required bool isActive,
    required String nationalId,
  }) = _MissionUser;

  factory MissionUser.fromJson(Map<String, Object?> json) =>
      _$MissionUserFromJson(json);
}
