import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class MissionTypesDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();

  Future<List<dynamic>> getAll() async {
    return await _apiHelper.get(
      URL: '${Env.baseUrl}/MissionTypes/GetAll',
      token: CachedData.getData(key: CacheStrings.token),
    );
  }

  Future<dynamic> getById({required String id}) async {
    return await _apiHelper.get(
      URL: '${Env.baseUrl}/MissionTypes/GetById/$id',
      token: CachedData.getData(key: CacheStrings.token),
    );
  }

  Future<dynamic> add({required Map<String, dynamic> data}) async {
    return await _apiHelper.post(
      URL: '${Env.baseUrl}/MissionTypes/Add',
      body: data,
      token: CachedData.getData(key: CacheStrings.token),
    );
  }

  Future<dynamic> update({required Map<String, dynamic> data}) async {
    return await _apiHelper.put(
      URL: '${Env.baseUrl}/MissionTypes/Update',
      body: data,
      token: CachedData.getData(key: CacheStrings.token),
    );
  }
}
