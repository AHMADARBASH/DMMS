import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_notification.freezed.dart';
part 'api_notification.g.dart';

@freezed
sealed class APINotification with _$APINotification {
  const factory APINotification(
      {required String id,
      required String title,
      required String content,
      required bool isRead,
      required DateTime createdAt}) = _APINotification;

  factory APINotification.fromJson(Map<String, Object?> json) =>
      _$APINotificationFromJson(json);
}
