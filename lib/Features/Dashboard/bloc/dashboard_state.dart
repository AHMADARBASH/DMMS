part of 'dashboard_bloc.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(false) bool isLoading,
    @Default(null) dynamic data,
    ErrorResponse? errorResponse,
  }) = _DashboardState;
}
