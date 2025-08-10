import 'package:dmms/Core/models/city.dart';
import 'package:dmms/Features/branches/data/models/branch.dart';
import 'package:dmms/Features/vehicles/data/models/fuel_type.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle_brand.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

@freezed
sealed class Vehicle with _$Vehicle {
  const factory Vehicle({
    required String id,
    required String brandId,
    required String typeId,
    required String model,
    required String sarcNumber,
    required int maxPassengers,
    required String cityId,
    required String plateNumber,
    required int currentKM,
    required int currentFuel,
    required int distancePer20Litter,
    required bool hasWirelessStation,
    required String fuelTypeId,
    required String branchId,
    required bool isActive,
    required String chaseNumber,
    required String engineNumber,
    required String insuranceExpirationDate,
    required VehicleBrand brand,
    required VehicleType type,
    required City city,
    required FuelType fuelType,
    required Branch branch,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
}
