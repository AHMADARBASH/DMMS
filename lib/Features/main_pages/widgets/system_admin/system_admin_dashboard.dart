import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/chart_card.dart';
import 'package:dmms/Core/presentation/widgets/error_refresh_widget.dart';
import 'package:dmms/Core/presentation/widgets/four_indicators_chart_card.dart';
import 'package:dmms/Core/presentation/widgets/loading_widget.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/Dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class SystemAdminDashboard extends StatelessWidget {
  const SystemAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      lazy: false,
      create: (context) =>
          DashboardBloc()..add(DashboardEvent.getSuperAdminData()),
      child:
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
        if (state.isLoading) {
          return LoadingWidget(
            color: context.appColors.primary,
          );
        }
        if (state.errorResponse != null) {
          return ErrorRefreshWidget(
              onPressed: () {
                context
                    .read<DashboardBloc>()
                    .add(DashboardEvent.getSuperAdminData());
              },
              text:
                  '${state.errorResponse!.errorMessage} \n ${state.errorResponse!.details}');
        } else {
          if (state.data == null) {
            return Center(
              child: Text(
                AppStrings.noDataAvailable.tr(),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<DashboardBloc>()
                    .add(DashboardEvent.getSuperAdminData());
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(spacing: AppSize.s10, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(AppStrings.superAdminDashboard.tr()),
                    ],
                  ),
                  ChartCard(
                    title: AppStrings.vehicles.tr(),
                    icon: FontAwesome5.car,
                    total: state.data['vehciles']['total'],
                    active: state.data['vehciles']['activeVehicles'],
                    inactive: state.data['vehciles']['inActiveVehicles'],
                  ),
                  ChartCard(
                    title: AppStrings.users.tr(),
                    icon: FontAwesome5.users,
                    total: state.data['users']['total'],
                    active: state.data['users']['activeUsers'],
                    inactive: state.data['users']['inActiveUsers'],
                  ),
                  ChartCard(
                    title: AppStrings.employees.tr(),
                    icon: FontAwesome5.users,
                    total: state.data['employees']['total'],
                    active: state.data['employees']['activeUsers'],
                    inactive: state.data['employees']['inActiveUsers'],
                  ),
                  FourIndicatorsChartCard(
                    title: AppStrings.missions.tr(),
                    icon: FontAwesome5.tasks,
                    total: state.data['missions']['total'],
                    active: state.data['missions']['activeMisisons'],
                    pending: state.data['missions']['pendingMissions'],
                    completed: state.data['missions']['completedMissions'],
                    canceled: state.data['missions']['canceledMissions'],
                  ),
                  FourIndicatorsChartCard(
                    title: AppStrings.fuelRequests.tr(),
                    icon: FontAwesome5.tasks,
                    total: state.data['fuelRequests']['total'],
                    active: state.data['fuelRequests']['activeRequests'],
                    pending: state.data['fuelRequests']['pendingRequests'],
                    completed: state.data['fuelRequests']['completedRequests'],
                    canceled: state.data['fuelRequests']['canceledRequests'],
                  ),
                  FourIndicatorsChartCard(
                    title: AppStrings.maintenanceRequests.tr(),
                    icon: FontAwesome5.tasks,
                    total: state.data['maintenaceRequests']['total'],
                    active: state.data['maintenaceRequests']['activeRequests'],
                    pending: state.data['maintenaceRequests']
                        ['pendingRequests'],
                    completed: state.data['maintenaceRequests']
                        ['completedRequests'],
                    canceled: state.data['maintenaceRequests']
                        ['canceledRequests'],
                  ),
                ]),
              ),
            ),
          );
        }
      }),
    );
  }
}
