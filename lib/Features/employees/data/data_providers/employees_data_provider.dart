import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class EmployeesDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();

  Future<List<dynamic>> getAll() async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/Employees/GetAll',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<dynamic> getById({required String id}) async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/Employees/GetById/$id',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<List<dynamic>> getInactive() async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/Employees/GetInActive',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<List<dynamic>> getByTypeId({required String typeId}) async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/Employees/GetByTypeId/$typeId',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> activate({required String employeeId}) async {
    await _apiHelper.put(
        URL: '${Env.baseUrl}/Employees/Activate/$employeeId',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> deActivate({required String employeeId}) async {
    await _apiHelper.put(
        URL: '${Env.baseUrl}/Employees/Dectivate/$employeeId',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> update({required Map<String, dynamic> data}) async {
    await _apiHelper.put(
        URL: '${Env.baseUrl}/Employees/Update',
        body: data,
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<void> add({required Map<String, dynamic> data}) async {
    await _apiHelper.post(
        URL: '${Env.baseUrl}/Employees/Add',
        body: data,
        token: CachedData.getData(key: CacheStrings.token));
  }
}
