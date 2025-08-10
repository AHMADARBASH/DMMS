import 'package:dmms/Features/employees/data/models/employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_escort.freezed.dart';
part 'mission_escort.g.dart';

@freezed
abstract class MissionEscort with _$MissionEscort {
  factory MissionEscort({
    required String missionId,
    required String escortId,
    required Employee escort,
  }) = _MissionEscort;

  factory MissionEscort.fromJson(Map<String, Object?> json) =>
      _$MissionEscortFromJson(json);
}
