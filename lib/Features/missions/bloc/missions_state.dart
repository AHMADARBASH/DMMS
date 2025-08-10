part of 'missions_bloc.dart';

@freezed
abstract class MissionsState with _$MissionsState {
  const factory MissionsState({
    @Default(false) bool isLoading,
    @Default([]) List<Mission> missions,
    ErrorResponse? errorResponse,
    String? successMessage,
  }) = _MissionState;
}
