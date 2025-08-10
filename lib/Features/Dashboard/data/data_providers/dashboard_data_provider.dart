import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class DashboardDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();

  Future<dynamic> getSuperAdminDashboardData() async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/SaReporting/GetAllData',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<dynamic> getRegionAdminDashboardData() async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/RegionAdminReporting/GetRegionAdminData',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<dynamic> getBranchAdminDashboardData() async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/BranchAdminReporting/GetBranchAdminData',
        token: CachedData.getData(key: CacheStrings.token));
  }

  Future<dynamic> getNormalUserDashboardData() async {
    return await _apiHelper.get(
        URL: '${Env.baseUrl}/NormalUserReporting/GetNormalUserData',
        token: CachedData.getData(key: CacheStrings.token));
  }
}
