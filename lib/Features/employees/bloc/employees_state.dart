part of 'employees_bloc.dart';

@freezed
abstract class EmployeesState with _$EmployeesState {
  const factory EmployeesState({
    @Default(false) bool isLoading,
    @Default([]) List<Employee> employees,
    ErrorResponse? errorResponse,
    String? successMessage,
  }) = _EmployeesState;
}
