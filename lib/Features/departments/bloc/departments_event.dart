part of 'departments_bloc.dart';

@freezed
class DepartmentsEvent with _$DepartmentsEvent {
  const factory DepartmentsEvent.getAll() = GetAll;
  const factory DepartmentsEvent.getByBranchId({required String branchId}) =
      GetByBranchId;
  const factory DepartmentsEvent.addDepartment(
      {required Map<String, dynamic> data}) = AddDepartment;
}
