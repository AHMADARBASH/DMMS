import 'package:dmms/Features/branches/data/models/branch.dart';
import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:dmms/Features/employees/data/models/employee.dart';
import 'package:dmms/Features/mission_types/data/models/mission_type.dart';
import 'package:dmms/Features/missions/data/models/canceled_mission.dart';
import 'package:dmms/Features/missions/data/models/mission_escort.dart';
import 'package:dmms/Features/missions/data/models/mission_user.dart';
import 'package:dmms/Features/missions/data/models/request_status.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission.freezed.dart';
part 'mission.g.dart';

@freezed
abstract class Mission with _$Mission {
  const factory Mission({
    required String id,
    required int serial_number,
    required String statusId,
    required String typeId,
    required String departmentId,
    required String branchId,
    required String vehicleId,
    required String driverId,
    required String missionLeaderId,
    required String userId,
    String? canceled_at,
    required RequestStatus status,
    required Department department,
    required Branch branch,
    required Vehicle vehicle,
    required Employee driver,
    required Employee missionLeader,
    required bool isExternal,
    required MissionType type,
    required String from,
    required String to,
    required int going_KM,
    int? back_KM,
    required int going_Fuel,
    int? back_Fuel,
    required String startDate,
    required String endDate,
    required MissionUser user,
    List<MissionEscort>? missionEscorts,
    CanceledMission? canceledMission,
    List<Map<String, dynamic>>? alertPoints,
  }) = _Mission;

  factory Mission.fromJson(Map<String, Object?> json) =>
      _$MissionFromJson(json);
}
