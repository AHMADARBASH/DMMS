import 'package:freezed_annotation/freezed_annotation.dart';

part 'canceled_mission.g.dart';
part 'canceled_mission.freezed.dart';

@freezed
abstract class CanceledMission with _$CanceledMission {
  factory CanceledMission(
      {required String cancelationDate,
      required String cancelationReason,
      required String canceledBy}) = _CanceledMission;

  factory CanceledMission.fromJson(Map<String, Object?> json) =>
      _$CanceledMissionFromJson(json);
}
