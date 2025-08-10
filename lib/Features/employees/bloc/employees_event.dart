part of 'employees_bloc.dart';

@freezed
class EmployeesEvent with _$EmployeesEvent {
  const factory EmployeesEvent.getAll() = GetAll;
  const factory EmployeesEvent.getById({required String id}) = GetById;
  const factory EmployeesEvent.getInactive() = GetInactive;
  const factory EmployeesEvent.getByTypeId({required String typeId}) =
      _GetByTypeId;
  const factory EmployeesEvent.add({required Map<String, dynamic> data}) = Add;
  const factory EmployeesEvent.update({required Map<String, dynamic> data}) =
      Update;
  const factory EmployeesEvent.activate({required String employeeId}) =
      Activate;
  const factory EmployeesEvent.deActivate({required String employeeId}) =
      Deactivate;
  const factory EmployeesEvent.search({required String query}) = Search;
}
