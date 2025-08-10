import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class UsersDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();

  Future<List<dynamic>> getAllUsers() async {
    final data = await _apiHelper.get(
      URL: '${Env.baseUrl}/Users/GetAll',
      token: CachedData.getData(key: CacheStrings.token),
    );
    return data;
  }

  Future<void> updateUserInfo({required Map<String, dynamic> data}) async {
    await _apiHelper.put(
      URL: '${Env.baseUrl}/Users/Update',
      token: CachedData.getData(key: CacheStrings.token),
      body: data,
    );
  }

  Future<void> deActivateUser({required String userId}) async {
    await _apiHelper.put(
      URL: '${Env.baseUrl}/Users/Deactivate/$userId',
      token: CachedData.getData(key: CacheStrings.token),
    );
  }

  Future<void> activateUser({required String userId}) async {
    await _apiHelper.put(
      URL: '${Env.baseUrl}/Users/Activate/$userId',
      token: CachedData.getData(key: CacheStrings.token),
    );
  }

  Future<void> resetUserPassword({required Map<String, dynamic> data}) async {
    await _apiHelper.post(
        URL: '${Env.baseUrl}/Auth/ResetAccountPassword',
        body: data,
        token: CachedData.getData(
          key: CacheStrings.token,
        ));
  }
}
