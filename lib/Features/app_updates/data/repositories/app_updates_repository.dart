import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/app_updates/data/data_providers/app_updates_data_provider.dart';

class AppUpdatesRepository {
  final _dataProvider = serviceLocator.get<AppUpdatesDataProvider>();

  Future<bool> checkForUdpdates() {
    return _dataProvider.checkForUpdates();
  }
}
