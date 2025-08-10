part of 'dashboard_bloc.dart';

@freezed
abstract class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.getNormalUserData() = GetNormalUserData;
  const factory DashboardEvent.getBranchAdminData() = GetBranchAdminData;
  const factory DashboardEvent.getRegionAdminData() = GetRegionAdminData;
  const factory DashboardEvent.getSuperAdminData() = GetSuperAdminData;
}
