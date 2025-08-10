import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/vehicles/data/data_providers/vehicles_data_provider.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle_brand.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle_type.dart';

class VehiclesRepository {
  final _vehiclesDataProvider = serviceLocator.get<VehiclesDataProvider>();

  Future<List<VehicleBrand>> getVehicleBrands() async {
    final data = await _vehiclesDataProvider.getVehicleBrands();
    return data.map((e) => VehicleBrand.fromJson(e)).toList();
  }

  Future<List<VehicleType>> getVehicleTypes() async {
    final data = await _vehiclesDataProvider.getVehicleTypes();
    return data.map((e) => VehicleType.fromJson(e)).toList();
  }

  Future<VehicleBrand> addVehicleBrand(
      {required Map<String, dynamic> data}) async {
    final brand = await _vehiclesDataProvider.addVehicleBrand(data);
    return VehicleBrand.fromJson(brand);
  }

  Future<VehicleType> addVehicleType(
      {required Map<String, dynamic> data}) async {
    final brand = await _vehiclesDataProvider.addVehicleType(data);
    return VehicleType.fromJson(brand);
  }

  Future<List<Vehicle>> getVehicles() async {
    final vehicles = await _vehiclesDataProvider.getVehicles();
    return vehicles.map((e) => Vehicle.fromJson(e)).toList();
  }

  Future<void> updateVehicle({required Map<String, dynamic> data}) async {
    await _vehiclesDataProvider.updateVehicle(data: data);
  }

  Future<void> activateVehicle({required String vehicleId}) async {
    await _vehiclesDataProvider.activateVehicle(vehicleId: vehicleId);
  }

  Future<void> deActivateVehicle({required String vehicleId}) async {
    await _vehiclesDataProvider.deActivateVehicle(vehicleId: vehicleId);
  }

  Future<void> addVehicle({required Map<String, dynamic> data}) async {
    await _vehiclesDataProvider.addVehicle(data: data);
  }
}
