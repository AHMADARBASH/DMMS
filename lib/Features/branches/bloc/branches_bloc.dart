import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import '../../../Core/service_locator/service_locator.dart';
import '../data/models/branch.dart';
import '../data/repositories/branches_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'branches_event.dart';
part 'branches_state.dart';
part 'branches_bloc.freezed.dart';

class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  final repo = serviceLocator.get<BranchesRepository>();
  void errorHandler(Exception e, Emitter<BranchesState> emit) {
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
              details: e.toString())));
    }
  }

  BranchesBloc() : super(BranchesState()) {
    on<GetAll>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
          errorResponse: null,
        ));
        try {
          var branches = await repo.getAllBranches();
          emit(state.copyWith(branches: branches, isLoading: false));
        } on Exception catch (e) {
          errorHandler(e, emit);
        } catch (e) {
          emit(state.copyWith(
              isLoading: false,
              errorResponse: ErrorResponse(
                  errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                  details: e.toString())));
        }
      },
    );
  }
}
