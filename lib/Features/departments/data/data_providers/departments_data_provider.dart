import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class DepartmentsDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();

  Future<List<dynamic>> getAllDepartments() async {
    final data = await _apiHelper.get(
        URL: '${Env.baseUrl}/Departments/GetAll',
        token: CachedData.getData(key: CacheStrings.token));
    return data;
  }

  Future<List<dynamic>> getByBranchId({required String branchId}) async {
    final data = await _apiHelper.get(
        URL: '${Env.baseUrl}/Departments/GetByBranchId/$branchId',
        token: CachedData.getData(key: CacheStrings.token));
    return data;
  }

  Future<void> addDepartment({required Map<String, dynamic> data}) async {
    await _apiHelper.post(
      URL: '${Env.baseUrl}/Departments/Add',
      body: data,
      token: CachedData.getData(key: CacheStrings.token),
    );
  }
}
