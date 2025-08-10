import 'dart:convert';

import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/auth/data/models/authenticated_user.dart';
import 'package:dmms/Features/notifications/data/data_providers/notifications_data_provider.dart';
import 'package:dmms/Features/notifications/data/models/api_notification.dart';

class NotificationsRepository {
  final _notificationsDataProvider =
      serviceLocator.get<NotificationsDataProvider>();

  Future<void> regiterFCMToken({required Map<String, dynamic> data}) async {
    await _notificationsDataProvider.registerFCMToken(data: data);
  }

  Future<void> deleteFCMToken({required Map<String, dynamic> data}) async {
    await _notificationsDataProvider.deleteFCMToken(data: data);
  }

  Future<void> readNotification({required String notificationId}) async {
    await _notificationsDataProvider.readNotifications(
        notificationId: notificationId);
  }

  Future<void> unReadNotification({required String notificationId}) async {
    await _notificationsDataProvider.unreadNotifications(
        notificationId: notificationId);
  }

  Future<List<APINotification>> getAll() async {
    final data = await _notificationsDataProvider.getAll();
    return data.map((e) => APINotification.fromJson(e)).toList();
  }

  Future<void> enableNotifications() async {
    await _notificationsDataProvider.enableNotifications();
    var user = AuthenticatedUser.fromJson(
        json.decode(CachedData.getData(key: CacheStrings.user)!));
    user = user.copyWith(isNotificationEnabled: true);
    CachedData.saveData(
        key: CacheStrings.user, data: json.encode(user.toJson()));
  }

  Future<void> disableNotifications() async {
    await _notificationsDataProvider.disableNotifications();
    var user = AuthenticatedUser.fromJson(
        json.decode(CachedData.getData(key: CacheStrings.user)!));
    user = user.copyWith(isNotificationEnabled: false);
    CachedData.saveData(
        key: CacheStrings.user, data: json.encode(user.toJson()));
  }
}
