part of 'mission_types_bloc.dart';

@freezed
abstract class MissionTypesState with _$MissionTypesState {
  const factory MissionTypesState({
    @Default(false) bool isLoading,
    @Default([]) List<MissionType> types,
    ErrorResponse? errorResponse,
    String? successMessage,
  }) = _MissionTypesState;
}
