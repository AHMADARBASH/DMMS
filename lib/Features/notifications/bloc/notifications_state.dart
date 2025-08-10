part of 'notifications_bloc.dart';

@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(false) bool isLoading,
    @Default([]) List<APINotification> notifications,
    ErrorResponse? errorResponse,
    @Default(false) bool loggedOut,
  }) = _NotificationState;
}
