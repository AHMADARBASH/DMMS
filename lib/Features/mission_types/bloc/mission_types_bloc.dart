import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/mission_types/data/models/mission_type.dart';
import 'package:dmms/Features/mission_types/data/repositories/mission_types_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'mission_types_event.dart';
part 'mission_types_state.dart';
part 'mission_types_bloc.freezed.dart';

class MissionTypesBloc extends Bloc<MissionTypesEvent, MissionTypesState> {
  final _repo = serviceLocator.get<MissionTypesRepository>();

  void errorHandler(Exception e, Emitter<MissionTypesState> emit) {
    if (e is SocketException) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.connectionError.tr(),
              details: AppStrings.noInternetConnection.tr())));
    } else if (e is UnauthorizedException) {
      emit(state.copyWith(
        errorResponse: e.errorResponse,
        isLoading: false,
      ));
    } else if (e is EmptyException) {
      emit(state.copyWith(
        errorResponse: e.errorResponse,
        isLoading: false,
      ));
    } else if (e is ServerException) {
      emit(state.copyWith(
        errorResponse: e.errorResponse,
        isLoading: false,
      ));
    } else if (e is NoInternetException) {
      emit(state.copyWith(
        errorResponse: e.errorResponse,
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  MissionTypesBloc() : super(MissionTypesState()) {
    on<GetAll>(_getAll);
    on<GetById>(_getById);
    on<Add>(_add);
    on<Update>(_update);
    on<ResetFlags>(_resetFlags);
  }
  _getAll(GetAll event, Emitter<MissionTypesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      final types = await _repo.getAll();
      emit(state.copyWith(isLoading: false, types: types));
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

  _getById(GetById event, Emitter<MissionTypesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      final type = await _repo.getById(id: event.id);
      emit(state.copyWith(isLoading: false, types: [type]));
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

  _add(Add event, Emitter<MissionTypesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      final type = await _repo.add(data: event.data);
      final updatedTypeList = List<MissionType>.from(state.types)..add(type);
      emit(state.copyWith(isLoading: false, types: updatedTypeList));
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

  _update(Update event, Emitter<MissionTypesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      final type = await _repo.update(data: event.data);
      final types = state.types.map((t) {
        if (t.id == type.id) {
          return type;
        } else {
          return t;
        }
      }).toList();
      emit(state.copyWith(isLoading: false, types: types));
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

  _resetFlags(ResetFlags event, Emitter<MissionTypesState> emit) async {
    emit(state.copyWith(
        isLoading: false, errorResponse: null, successMessage: null));
  }
}
