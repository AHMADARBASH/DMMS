import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class AuthDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();
  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials) async {
    Map<String, dynamic> response = await _apiHelper.post(
        URL: '${Env.baseUrl}/Auth/Login', body: credentials);
    return response;
  }

  Future<dynamic> createBranchAdmin(
      {required Map<String, dynamic> userData}) async {
    await _apiHelper.post(
        URL: '${Env.baseUrl}/Auth/CreateBranchAdmin',
        body: userData,
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<dynamic> createNormalUser(
      {required Map<String, dynamic> userData}) async {
    await _apiHelper.post(
        URL: '${Env.baseUrl}/Auth/CreateNormalUser',
        body: userData,
        token: CachedData.getData(key: CacheStrings.token));
  }
}
