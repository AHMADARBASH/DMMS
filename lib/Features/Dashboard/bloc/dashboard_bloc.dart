import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/Dashboard/data/repositories/dashboard_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final _repo = serviceLocator.get<DashboardRepository>();

  void errorHandler(Exception e, Emitter<DashboardState> emit) {
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

  DashboardBloc() : super(DashboardState()) {
    on<GetSuperAdminData>(_getSuperAdminDashboardData);
    on<GetRegionAdminData>(_getRegionAdminDashboarData);
    on<GetBranchAdminData>(_getBranchAdminDashboarData);
    on<GetNormalUserData>(_getNormalUserDashboarData);
  }

  _getSuperAdminDashboardData(
    GetSuperAdminData event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      var data = await _repo.getSuperAdminDashboardData();
      emit(state.copyWith(isLoading: false, data: data));
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

  _getRegionAdminDashboarData(
    GetRegionAdminData event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      var data = await _repo.getRegionAdminDashboardData();
      emit(state.copyWith(isLoading: false, data: data));
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

  _getBranchAdminDashboarData(
    GetBranchAdminData event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      var data = await _repo.getBranchAdminDashboardData();
      emit(state.copyWith(isLoading: false, data: data));
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

  _getNormalUserDashboarData(
    GetNormalUserData event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      var data = await _repo.getNormalUserDashboardData();
      emit(state.copyWith(isLoading: false, data: data));
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
}
