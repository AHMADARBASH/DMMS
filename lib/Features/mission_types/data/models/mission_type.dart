import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_type.freezed.dart';
part 'mission_type.g.dart';

@freezed
abstract class MissionType with _$MissionType {
  const factory MissionType({
    required String id,
    required String name,
  }) = _MissionType;
  factory MissionType.fromJson(Map<String, Object?> json) =>
      _$MissionTypeFromJson(json);
}
