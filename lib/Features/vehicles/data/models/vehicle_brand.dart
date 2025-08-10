import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_brand.freezed.dart';
part 'vehicle_brand.g.dart';

@freezed
sealed class VehicleBrand with _$VehicleBrand {
  const factory VehicleBrand({
    required String id,
    required String name,
  }) = _VehicleBrand;

  factory VehicleBrand.fromJson(Map<String, Object?> json) =>
      _$VehicleBrandFromJson(json);
}
