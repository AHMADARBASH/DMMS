part of 'branches_bloc.dart';

@freezed
abstract class BranchesState with _$BranchesState {
  const factory BranchesState({
    @Default(false) bool isLoading,
    @Default([]) List<Branch> branches,
    ErrorResponse? errorResponse,
  }) = _BranchesState;
}
