import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_type.freezed.dart';
part 'vehicle_type.g.dart';

@freezed
sealed class VehicleType with _$VehicleType {
  const factory VehicleType({required String id, required String name}) =
      _VehicleType;

  factory VehicleType.fromJson(Map<String, Object?> json) =>
      _$VehicleTypeFromJson(json);
}
