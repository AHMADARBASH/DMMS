import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/employees/data/models/employee.dart';
import 'package:dmms/Features/employees/data/repositories/employees_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'employees_event.dart';
part 'employees_state.dart';
part 'employees_bloc.freezed.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final _repo = serviceLocator.get<EmployeesRepository>();
  List<Employee> _allItems = [];
  void errorHandler(Exception e, Emitter<EmployeesState> emit) {
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

  EmployeesBloc() : super(EmployeesState()) {
    on<GetAll>(_getAll);
    on<Activate>(_activate);
    on<Deactivate>(_deactivate);
    on<Update>(_update);
    on<Add>(_add);
    on<Search>(_search, transformer: restartable());
  }
  _search(Search event, Emitter<EmployeesState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (event.query.isEmpty) {
        emit(state.copyWith(
            isLoading: false, employees: _allItems, errorResponse: null));
      } else {
        List<Employee> filtered = _allItems
            .where((u) =>
                u.firstName.toLowerCase().contains(event.query.toLowerCase()) ||
                u.lastName.toLowerCase().contains(event.query.toLowerCase()) ||
                u.nationalId
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                u.phoneNumber1
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                u.position.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(state.copyWith(
            isLoading: false, employees: filtered, errorResponse: null));
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

  _add(Add event, Emitter<EmployeesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      await _repo.add(data: event.data);
      final employees = await _repo.getAll();
      _allItems = employees;
      emit(state.copyWith(
          isLoading: false,
          employees: employees,
          successMessage: AppStrings.employeeAddedSuccessfully.tr()));
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

  _update(Update event, Emitter<EmployeesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      await _repo.update(data: event.data);
      final employees = await _repo.getAll();
      _allItems = employees;
      emit(state.copyWith(
          isLoading: false,
          employees: employees,
          successMessage: AppStrings.employeeUpdatedSuccessfully.tr()));
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

  _getAll(GetAll event, Emitter<EmployeesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      final employees = await _repo.getAll();
      _allItems = employees;
      emit(state.copyWith(isLoading: false, employees: employees));
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

  _activate(Activate event, Emitter<EmployeesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      await _repo.activate(employeeId: event.employeeId);

      final employees = state.employees.map((e) {
        if (e.id == event.employeeId) {
          return e.copyWith(isActive: true);
        } else {
          return e;
        }
      }).toList();
      _allItems = employees;
      emit(state.copyWith(isLoading: false, employees: employees));
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

  _deactivate(Deactivate event, Emitter<EmployeesState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true, errorResponse: null, successMessage: null));
      await _repo.deActivate(employeeId: event.employeeId);
      final employees = state.employees.map((e) {
        if (e.id == event.employeeId) {
          return e.copyWith(isActive: false);
        } else {
          return e;
        }
      }).toList();
      _allItems = employees;
      emit(state.copyWith(isLoading: false, employees: employees));
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
