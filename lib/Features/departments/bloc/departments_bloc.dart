import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:dmms/Features/departments/data/repositories/departments_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'departments_event.dart';
part 'departments_state.dart';
part 'departments_bloc.freezed.dart';

class DepartmentsBloc extends Bloc<DepartmentsEvent, DepartmentsState> {
  final repo = serviceLocator.get<DepartmentsRepository>();

  DepartmentsBloc() : super(const DepartmentsState()) {
    on<GetAll>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        errorResponse: null,
      ));
      try {
        final departments = await repo.getAllDepartments();
        emit(state.copyWith(
          isLoading: false,
          departments: departments,
        ));
      } on Exception catch (e) {
        _handleError(e, emit);
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
            errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
            details: e.toString(),
          ),
        ));
      }
    });

    on<GetByBranchId>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        errorResponse: null,
      ));
      try {
        final departments = await repo.getByBranchId(branchId: event.branchId);
        emit(state.copyWith(
          isLoading: false,
          departments: departments,
        ));
      } on Exception catch (e) {
        _handleError(e, emit);
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
            errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
            details: e.toString(),
          ),
        ));
      }
    });
    on<AddDepartment>((event, emit) async {
      try {
        emit(state.copyWith(
          isLoading: true,
          errorResponse: null,
        ));
        await repo.addDepartment(data: event.data);
        final departments = await repo.getAllDepartments();
        emit(state.copyWith(
            isLoading: false,
            departments: departments,
            successMessage: AppStrings.departmentAddedSuccessfully.tr()));
      } on Exception catch (e) {
        _handleError(e, emit);
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
            errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
            details: e.toString(),
          ),
        ));
      }
    });
  }

  void _handleError(Exception e, Emitter<DepartmentsState> emit) {
    ErrorResponse response;

    if (e is SocketException) {
      response = ErrorResponse(
        errorMessage: AppStrings.connectionError.tr(),
        details: AppStrings.noInternetConnection.tr(),
      );
    } else if (e is UnauthorizedException ||
        e is EmptyException ||
        e is ServerException ||
        e is NoInternetException) {
      response = (e as dynamic).errorResponse;
    } else {
      response = ErrorResponse(
        errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
        details: e.toString(),
      );
    }

    emit(state.copyWith(
      isLoading: false,
      errorResponse: response,
    ));
  }
}
