import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class BranchesDataProvider {
  var apiHelper = serviceLocator.get<ApiHelper>();

  Future<List<dynamic>> getAllBranches() async {
    List<dynamic> response = await apiHelper.get(
      URL: '${Env.baseUrl}/Branches/GetAll',
      token: CachedData.getData(key: CacheStrings.token),
    );
    return response;
  }

  Future<Map<String, dynamic>> getById({required String branchId}) async {
    var response = await apiHelper.get(
      URL: '${Env.baseUrl}/Branches/GetAll/$branchId',
      token: CachedData.getData(key: CacheStrings.token),
    );
    return response;
  }
}
