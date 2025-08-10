part of 'vehicles_bloc.dart';

@freezed
abstract class VehiclesState with _$VehiclesState {
  const factory VehiclesState({
    @Default(false) bool isLoading,
    @Default(<VehicleType>[]) List<VehicleType> types,
    @Default(<VehicleBrand>[]) List<VehicleBrand> brands,
    @Default(<Vehicle>[]) List<Vehicle> vehicles,
    ErrorResponse? errorResponse,
    String? successMessage,
  }) = _VehiclesState;
}
