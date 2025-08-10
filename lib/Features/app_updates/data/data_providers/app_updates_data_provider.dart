import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdatesDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();

  Future<bool> checkForUpdates() async {
    var deviceInfo = await PackageInfo.fromPlatform();
    var currentVersion = deviceInfo.version;
    await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> apiVersion = await _apiHelper.get(
        URL:
            '${Env.baseUrl}/MobileApplicatioSettings/GetSettingsByPlatform/android',
        token: CachedData.getData(key: CacheStrings.token));
    return currentVersion == apiVersion['version'];
  }
}
