part of 'branches_bloc.dart';

@freezed
sealed class BranchesEvent with _$BranchesEvent {
  const factory BranchesEvent.getAll() = GetAll;
  const factory BranchesEvent.getById({required String branchId}) = GetById;
}
