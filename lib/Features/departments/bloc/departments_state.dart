part of 'departments_bloc.dart';

@freezed
abstract class DepartmentsState with _$DepartmentsState {
  const factory DepartmentsState({
    @Default(false) bool isLoading,
    @Default([]) List<Department> departments,
    ErrorResponse? errorResponse,
    String? successMessage,
  }) = _DepartmentsState;
}
