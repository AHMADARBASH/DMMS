import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/resources/app_fuel_types.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle_brand.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle_type.dart';
import 'package:dmms/Features/vehicles/data/repositories/vehicles_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'vehicles_event.dart';
part 'vehicles_state.dart';
part 'vehicles_bloc.freezed.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  final _repo = serviceLocator.get<VehiclesRepository>();
  List<Vehicle> _allItems = [];

  void errorHandler(Exception e, Emitter<VehiclesState> emit) {
    if (e is SocketException) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.connectionError.tr(),
              details: AppStrings.noInternetConnection.tr())));
    } else if (e is UnauthorizedException) {
      emit(state.copyWith(isLoading: false, errorResponse: e.errorResponse));
    } else if (e is EmptyException) {
      emit(state.copyWith(isLoading: false, errorResponse: e.errorResponse));
    } else if (e is ServerException) {
      emit(state.copyWith(isLoading: false, errorResponse: e.errorResponse));
    } else if (e is NoInternetException) {
      emit(state.copyWith(isLoading: false, errorResponse: e.errorResponse));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorResponse: ErrorResponse(
            errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
            details: e.toString()),
      ));
    }
  }

  VehiclesBloc() : super(VehiclesState()) {
    on<GetBrandsAndTypes>(_getBrandsAndTypes);
    on<AddVehicleBrand>(_addVehicleBrand);
    on<GetVehicles>(_getVehicles);
    on<AddVehicleType>(_addVehicleType);
    on<ClearMessage>(_clearMessage);
    on<UpdateVehicle>(_updateVehicle);
    on<ResetFlags>(_resetFlags);
    on<ActivateVehicle>(_activateVehicle);
    on<DeActivateVehicle>(_deActivateVehicle);
    on<AddVehicle>(_addVehicle);
    on<Search>(_search, transformer: restartable());
  }
  _search(Search event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (event.query.isEmpty) {
        emit(state.copyWith(
            isLoading: false, vehicles: _allItems, errorResponse: null));
      } else {
        List<Vehicle> filtered = _allItems
            .where((v) =>
                v.sarcNumber
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                v.model.toLowerCase().contains(event.query.toLowerCase()) ||
                v.plateNumber
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                v.brand.name.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(state.copyWith(
            isLoading: false, vehicles: filtered, errorResponse: null));
      }
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  _addVehicle(AddVehicle event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _repo.addVehicle(data: event.data);
      final newVehicles = await _repo.getVehicles();
      _allItems = newVehicles;
      emit(state.copyWith(
          isLoading: false,
          vehicles: newVehicles,
          errorResponse: null,
          successMessage: AppStrings.vehicleAddedSuccessfully.tr()));
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  _deActivateVehicle(
      DeActivateVehicle event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _repo.deActivateVehicle(vehicleId: event.vehicleId);
      final newVehicles = state.vehicles.map((v) {
        if (v.id == event.vehicleId) {
          return v.copyWith(isActive: false);
        } else {
          return v;
        }
      }).toList();
      _allItems = newVehicles;
      emit(state.copyWith(
          isLoading: false,
          vehicles: newVehicles,
          errorResponse: null,
          successMessage: AppStrings.vehicleDeactivatedSuccessfully.tr()));
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  _activateVehicle(ActivateVehicle event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _repo.activateVehicle(vehicleId: event.vehicleId);
      final newVehicles = state.vehicles.map((v) {
        if (v.id == event.vehicleId) {
          return v.copyWith(isActive: true);
        } else {
          return v;
        }
      }).toList();
      _allItems = newVehicles;
      emit(state.copyWith(
          isLoading: false,
          vehicles: newVehicles,
          errorResponse: null,
          successMessage: AppStrings.vehicleActivatedSuccessfully.tr()));
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  _resetFlags(ResetFlags event, Emitter<VehiclesState> emit) {
    emit(state.copyWith(
      isLoading: false,
      errorResponse: null,
      successMessage: null,
    ));
  }

  _updateVehicle(UpdateVehicle event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _repo.updateVehicle(data: event.data);
      final newVehicles = state.vehicles.map((v) {
        if (v.id == event.data['id']) {
          return v.copyWith(
              maxPassengers: event.data['maxPassengers'],
              cityId: event.data['cityId'],
              plateNumber: event.data['plateNumber'],
              hasWirelessStation: event.data['hasWirelessStation'],
              fuelType: AppFuelTypes.fuelTypes
                  .where((f) => f.id == event.data['fuelTypeId'])
                  .first,
              chaseNumber: event.data['chaseNumber'],
              engineNumber: event.data['engineNumber'],
              insuranceExpirationDate: event.data['insuranceExpirationDate']);
        } else {
          return v;
        }
      }).toList();
      _allItems = newVehicles;
      emit(state.copyWith(
          isLoading: false,
          vehicles: newVehicles,
          successMessage: AppStrings.vehicleUpdatedSuccessfully.tr()));
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  _clearMessage(ClearMessage event, Emitter<VehiclesState> emit) async {
    emit(state.copyWith(successMessage: null));
  }

  _addVehicleType(AddVehicleType event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _repo.addVehicleType(data: event.data);
      final brands = await _repo.getVehicleBrands();
      final types = await _repo.getVehicleTypes();
      emit(state.copyWith(
          isLoading: false,
          brands: brands,
          types: types,
          successMessage: AppStrings.typeAddedSuccessfully.tr()));
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  _getBrandsAndTypes(
      GetBrandsAndTypes event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final brands = await _repo.getVehicleBrands();
      final types = await _repo.getVehicleTypes();
      emit(state.copyWith(
        isLoading: false,
        brands: brands,
        types: types,
        errorResponse: null,
      ));
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  _addVehicleBrand(AddVehicleBrand event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _repo.addVehicleBrand(data: event.data);
      final brands = await _repo.getVehicleBrands();
      final types = await _repo.getVehicleTypes();
      emit(state.copyWith(
          isLoading: false,
          brands: brands,
          types: types,
          errorResponse: null,
          successMessage: AppStrings.brandAddeddSuccessfully.tr()));
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  _getVehicles(GetVehicles event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final vehicles = await _repo.getVehicles();
      _allItems = vehicles;
      emit(state.copyWith(
          vehicles: vehicles, errorResponse: null, isLoading: false));
    } on Exception catch (e) {
      errorHandler(e, emit);
    } catch (e) {
      emit(state.copyWith(
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }
}
