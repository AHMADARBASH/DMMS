import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const factory User({
    required String id,
    required String firstName,
    required String lastName,
    required String userName,
    required String nationalId,
    required String birthDate,
    required List<String> roles,
    required bool isActive,
    required Department department,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
