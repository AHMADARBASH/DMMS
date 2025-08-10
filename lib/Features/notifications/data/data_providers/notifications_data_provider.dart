import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class NotificationsDataProvider {
  final _apiProvider = serviceLocator.get<ApiHelper>();

  Future<List<dynamic>> getAll() async {
    final data = await _apiProvider.get(
        URL: '${Env.baseUrl}/Notifications/GetAll',
        token: CachedData.getData(key: CacheStrings.token));
    return data;
  }

  Future<void> registerFCMToken({required Map<String, dynamic> data}) async {
    await _apiProvider.post(
        URL: '${Env.baseUrl}/Notifications/RegisterFCMToken',
        body: data,
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> deleteFCMToken({required Map<String, dynamic> data}) async {
    await _apiProvider.delete(
        URL: '${Env.baseUrl}/Notifications/DeleteFCMToken',
        body: data,
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> enableNotifications() async {
    await _apiProvider.put(
        URL: '${Env.baseUrl}/Notifications/EnableNotifications',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> readNotifications({required String notificationId}) async {
    await _apiProvider.put(
        URL: '${Env.baseUrl}/Notifications/ReadNotification/$notificationId',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> unreadNotifications({required String notificationId}) async {
    await _apiProvider.put(
        URL: '${Env.baseUrl}/Notifications/UnReadNotification/$notificationId',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> disableNotifications() async {
    await _apiProvider.put(
        URL: '${Env.baseUrl}/Notifications/DisableNotifications',
        token: CachedData.getData(key: CacheStrings.token));
  }
}
