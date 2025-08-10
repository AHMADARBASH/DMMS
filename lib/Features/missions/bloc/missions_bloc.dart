import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/missions/data/models/mission.dart';
import 'package:dmms/Features/missions/data/repositories/missions_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'missions_event.dart';
part 'missions_state.dart';
part 'missions_bloc.freezed.dart';

class MissionsBloc extends Bloc<MissionsEvent, MissionsState> {
  final _repo = serviceLocator.get<MissionsRepository>();
  List<Mission> _allItems = [];
  void errorHandler(Exception e, Emitter<MissionsState> emit) {
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
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  MissionsBloc() : super(MissionsState()) {
    on<GetAll>(_getAll);
    on<Search>(_search, transformer: restartable());
  }
  _search(Search event, Emitter<MissionsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (event.query.isEmpty) {
        emit(state.copyWith(
            isLoading: false, missions: _allItems, errorResponse: null));
      } else {
        List<Mission> filtered = _allItems
            .where((m) =>
                m.serial_number
                    .toString()
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                m.from.toLowerCase().contains(event.query.toLowerCase()) ||
                m.to.toLowerCase().contains(event.query.toLowerCase()) ||
                m.missionLeader.firstName
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                m.missionLeader.lastName
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                m.department.name
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                m.driver.firstName
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                m.driver.lastName
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                m.type.name.toLowerCase().contains(event.query.toLowerCase()) ||
                m.startDate.toLowerCase().contains(event.query.toLowerCase()) ||
                m.endDate.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(state.copyWith(
            isLoading: false, missions: filtered, errorResponse: null));
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

  _getAll(GetAll event, Emitter<MissionsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final missions = await _repo.getAll();
      _allItems = missions;
      emit(state.copyWith(missions: _allItems, isLoading: false));
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
