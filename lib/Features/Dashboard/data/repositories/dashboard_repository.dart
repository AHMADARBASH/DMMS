import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/Dashboard/data/data_providers/dashboard_data_provider.dart';

class DashboardRepository {
  final _dashboardDataProvider = serviceLocator.get<DashboardDataProvider>();

  Future<dynamic> getSuperAdminDashboardData() async {
    return await _dashboardDataProvider.getSuperAdminDashboardData();
  }

  Future<dynamic> getRegionAdminDashboardData() async {
    return await _dashboardDataProvider.getRegionAdminDashboardData();
  }

  Future<dynamic> getBranchAdminDashboardData() async {
    return await _dashboardDataProvider.getBranchAdminDashboardData();
  }

  Future<dynamic> getNormalUserDashboardData() async {
    return await _dashboardDataProvider.getNormalUserDashboardData();
  }
}
