import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class MissionsDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();

  Future<List<dynamic>> getAll() async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/Missions/GetAll',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<dynamic> getById({required String missionId}) async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/Missions/GetById/$missionId',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> add({required Map<String, dynamic> data}) async {
    await _apiHelper.post(
        URL: '${Env.baseUrl}/Missions/Add',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> setActive({required String missionId}) async {
    await _apiHelper.put(
        URL: '${Env.baseUrl}/Missions/SetActive/$missionId',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> update({required Map<String, dynamic> data}) async {
    await _apiHelper.post(
        URL: '${Env.baseUrl}/Missions/Update',
        body: data,
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> setCanceled({required Map<String, dynamic> data}) async {
    await _apiHelper.post(
        URL: '${Env.baseUrl}/Missions/SetCanceled',
        body: data,
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> setComplete({required Map<String, dynamic> data}) async {
    await _apiHelper.post(
        URL: '${Env.baseUrl}/Missions/SetComplete',
        body: data,
        token: CachedData.getData(key: CacheStrings.token));
  }
}
