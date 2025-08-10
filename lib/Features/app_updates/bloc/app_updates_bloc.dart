import 'dart:io';
import 'package:easy_localization/easy_localization.dart';

import 'package:bloc/bloc.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/app_updates/data/repositories/app_updates_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_updates_event.dart';
part 'app_updates_state.dart';
part 'app_updates_bloc.freezed.dart';

class AppUpdatesBloc extends Bloc<AppUpdatesEvent, AppUpdatesState> {
  var repo = serviceLocator.get<AppUpdatesRepository>();

  void errorHandler(Exception e, Emitter<AppUpdatesState> emit) {
    if (e is SocketException) {
      emit(Error(
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.connectionError.tr(),
              details: AppStrings.noInternetConnection.tr())));
    } else if (e is UnauthorizedException) {
      emit(Error(errorResponse: e.errorResponse));
    } else if (e is EmptyException) {
      emit(Error(errorResponse: e.errorResponse));
    } else if (e is ServerException) {
      emit(Error(errorResponse: e.errorResponse));
    } else if (e is NoInternetException) {
      emit(Error(errorResponse: e.errorResponse));
    } else {
      emit(Error(
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  AppUpdatesBloc() : super(Initial()) {
    on<CheckForUpdates>((event, emit) async {
      emit(Loading());
      try {
        var isUpdated = await repo.checkForUdpdates();
        if (isUpdated) {
          emit(Updated());
        } else {
          emit(NotUpdate());
        }
      } on Exception catch (e) {
        errorHandler(e, emit);
      } catch (e) {
        emit(Error(
            errorResponse: ErrorResponse(
                errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                details: e.toString())));
      }
    });
  }
}
