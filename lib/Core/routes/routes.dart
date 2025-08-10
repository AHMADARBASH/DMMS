import 'package:dmms/Core/presentation/pages/settings_page.dart';
import 'package:dmms/Features/employees/data/models/employee.dart';
import 'package:dmms/Features/employees/presentation/pages/add_employee_page.dart';
import 'package:dmms/Features/employees/presentation/pages/edit_employee_page.dart';
import 'package:dmms/Features/employees/presentation/pages/employee_details_page.dart';
import 'package:dmms/Features/employees/presentation/pages/employees_page.dart';
import 'package:dmms/Features/employees/presentation/pages/employees_flow_shell.dart';
import 'package:dmms/Features/mission_types/presentation/pages/mission_types_page.dart';
import 'package:dmms/Features/missions/data/models/mission.dart';
import 'package:dmms/Features/missions/presentation/pages/mission_details_page.dart';
import 'package:dmms/Features/missions/presentation/pages/missions_flow_shell.dart';
import 'package:dmms/Features/missions/presentation/pages/missions_page.dart';
import 'package:dmms/Features/vehicles/presentation/pages/vehicles_flow_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../Features/departments/presentation/pages/departments_page.dart';
import '../../Features/main_pages/root_page.dart';
import '../../Features/notifications/presentation/pages/notifications_page.dart';
import '../../Features/users/data/models/user.dart';
import '../../Features/users/presentation/pages/add_user_page.dart';
import '../../Features/users/presentation/pages/edit_user_page.dart';
import '../../Features/users/presentation/pages/user_details_page.dart';
import '../../Features/users/presentation/pages/users_flow_shell.dart';
import '../../Features/users/presentation/pages/users_page.dart';
import '../../Features/vehicles/data/models/vehicle.dart';
import '../../Features/vehicles/presentation/pages/add_vehicle_page.dart';
import '../../Features/vehicles/presentation/pages/edit_vehicle_page.dart';
import '../../Features/vehicles/presentation/pages/vehicle_details_page.dart';
import '../../Features/vehicles/presentation/pages/vehicles_brands_page.dart';
import '../../Features/vehicles/presentation/pages/vehicles_page.dart';
import '../../Features/vehicles/presentation/pages/vehicles_types_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: navigatorKey, routes: [
  //Users Shell Route
  ShellRoute(
      builder: (context, state, child) => UsersFlowShell(child: child),
      routes: [
        GoRoute(
          path: EditUserPage.routeName,
          name: EditUserPage.routeName,
          builder: (context, state) => EditUserPage(
            user: state.extra as User,
          ),
        ),
        GoRoute(
          path: AddUserPage.routeName,
          name: AddUserPage.routeName,
          builder: (context, state) => AddUserPage(),
        ),
        GoRoute(
          path: UsersPage.routeName,
          name: UsersPage.routeName,
          builder: (context, state) => UsersPage(
            userRole: state.extra.toString(),
          ),
        ),
        GoRoute(
          name: UserDetailsPage.routeName,
          path: UserDetailsPage.routeName,
          builder: (context, state) =>
              UserDetailsPage(user: state.extra as User),
        ),
      ]),

  //Vehicles Shell Route
  ShellRoute(
      builder: (context, state, child) => VehiclesFlowShell(child: child),
      routes: [
        GoRoute(
          name: VehiclesPage.routeName,
          path: VehiclesPage.routeName,
          builder: (context, state) => VehiclesPage(),
        ),
        GoRoute(
          name: EditVehiclePage.routeName,
          path: EditVehiclePage.routeName,
          builder: (context, state) => EditVehiclePage(
            vehicle: state.extra as Vehicle,
          ),
        ),
        GoRoute(
          name: VehicleDetailsPage.routeName,
          path: VehicleDetailsPage.routeName,
          builder: (context, state) => VehicleDetailsPage(
            vehicle: state.extra as Vehicle,
          ),
        ),
        GoRoute(
          name: AddVehiclePage.routeName,
          path: AddVehiclePage.routeName,
          builder: (context, state) => AddVehiclePage(),
        ),
      ]),
  //Employees Route Shell
  ShellRoute(
      builder: (context, state, child) => EmployeesFlowShell(child: child),
      routes: [
        GoRoute(
          name: EmployeeDetailsPage.routeName,
          path: EmployeeDetailsPage.routeName,
          builder: (context, state) => EmployeeDetailsPage(
            employee: state.extra as Employee,
          ),
        ),
        GoRoute(
          name: EmployeesPage.routeName,
          path: EmployeesPage.routeName,
          builder: (context, state) => EmployeesPage(),
        ),
        GoRoute(
          name: EditEmployeePage.routeName,
          path: EditEmployeePage.routeName,
          builder: (context, state) =>
              EditEmployeePage(employee: state.extra as Employee),
        ),
        GoRoute(
          name: AddEmployeePage.routeName,
          path: AddEmployeePage.routeName,
          builder: (context, state) => AddEmployeePage(),
        )
      ]),
  //Missions Route Shell
  ShellRoute(
      builder: (context, state, child) => MissionsFlowShell(child: child),
      routes: [
        GoRoute(
          name: MissionsPage.routeName,
          path: MissionsPage.routeName,
          builder: (context, state) => MissionsPage(),
        ),
        GoRoute(
          name: MissionDetailsPage.routeName,
          path: MissionDetailsPage.routeName,
          builder: (context, state) => MissionDetailsPage(
            mission: state.extra as Mission,
          ),
        ),
      ]),
  GoRoute(
    name: '/',
    path: '/',
    builder: (context, state) => RootPage(),
  ),
  GoRoute(
    path: NotificationsPage.routeName,
    name: NotificationsPage.routeName,
    builder: (context, state) => NotificationsPage(),
  ),
  GoRoute(
    name: VehiclesTypesPage.routeName,
    path: VehiclesTypesPage.routeName,
    builder: (context, state) => VehiclesTypesPage(),
  ),
  GoRoute(
    name: VehiclesBrandsPage.routeName,
    path: VehiclesBrandsPage.routeName,
    builder: (context, state) => VehiclesBrandsPage(),
  ),

  GoRoute(
    name: DepartmentsPage.routeName,
    path: DepartmentsPage.routeName,
    builder: (context, state) => DepartmentsPage(),
  ),
  GoRoute(
    name: MissionTypesPage.routeName,
    path: MissionTypesPage.routeName,
    builder: (context, state) => MissionTypesPage(),
  ),
  GoRoute(
    name: SettingsPage.routeName,
    path: SettingsPage.routeName,
    builder: (context, state) => SettingsPage(),
  ),
]);
