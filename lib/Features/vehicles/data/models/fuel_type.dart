import 'package:freezed_annotation/freezed_annotation.dart';

part 'fuel_type.freezed.dart';
part 'fuel_type.g.dart';

@freezed
sealed class FuelType with _$FuelType {
  const factory FuelType({
    required String id,
    required String name,
  }) = _FuelType;

  factory FuelType.fromJson(Map<String, dynamic> json) =>
      _$FuelTypeFromJson(json);
}
