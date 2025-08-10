part of 'notifications_bloc.dart';

@freezed
sealed class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.registerFCMToken(
      {required Map<String, dynamic> data}) = RegisterFCMToken;
  const factory NotificationsEvent.deleteFCMToken(
      {required Map<String, dynamic> data}) = DeleteFCMToken;
  const factory NotificationsEvent.disableNotifications() =
      DisableNotifications;
  const factory NotificationsEvent.enableNotifications() = EnableNotifications;
  const factory NotificationsEvent.readNotification(
      {required String notificationId}) = ReadNotification;
  const factory NotificationsEvent.unReadNotification(
      {required String notificationId}) = UnReadNotification;
  const factory NotificationsEvent.readAll() = ReadAll;
  const factory NotificationsEvent.deleteNotification(
      {required String notificationId}) = DeleteNotification;
  const factory NotificationsEvent.getAll() = GetAll;
  const factory NotificationsEvent.getById({required String notificationId}) =
      GetById;
  const factory NotificationsEvent.filterNotifications(
      {required NotificationsFilter filter}) = FilterNotifications;
}
