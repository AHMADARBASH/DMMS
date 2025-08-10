part of 'vehicles_bloc.dart';

@freezed
abstract class VehiclesEvent with _$VehiclesEvent {
  const factory VehiclesEvent.getVehicles() = GetVehicles;
  const factory VehiclesEvent.getBrandsAndTypes() = GetBrandsAndTypes;
  const factory VehiclesEvent.addVehicleBrand(
      {required Map<String, dynamic> data}) = AddVehicleBrand;
  const factory VehiclesEvent.addVehicleType(
      {required Map<String, dynamic> data}) = AddVehicleType;
  const factory VehiclesEvent.clearMessage() = ClearMessage;
  const factory VehiclesEvent.updateVehicle(
      {required Map<String, dynamic> data}) = UpdateVehicle;
  const factory VehiclesEvent.resetFlags() = ResetFlags;
  const factory VehiclesEvent.deActivateVehicle({required String vehicleId}) =
      DeActivateVehicle;
  const factory VehiclesEvent.activateVehicle({required String vehicleId}) =
      ActivateVehicle;
  const factory VehiclesEvent.addVehicle({required Map<String, dynamic> data}) =
      AddVehicle;
  const factory VehiclesEvent.search({required String query}) = Search;
}
