import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Features/Dashboard/data/data_providers/dashboard_data_provider.dart';
import 'package:dmms/Features/Dashboard/data/repositories/dashboard_repository.dart';
import 'package:dmms/Features/app_updates/data/data_providers/app_updates_data_provider.dart';
import 'package:dmms/Features/app_updates/data/repositories/app_updates_repository.dart';
import 'package:dmms/Features/auth/bloc/auth_bloc.dart';
import 'package:dmms/Features/auth/data/data_providers/auth_data_provider.dart';
import 'package:dmms/Features/auth/data/repositories/auth_repo.dart';
import 'package:dmms/Features/branches/data/data_providers/branches_data_provider.dart';
import 'package:dmms/Features/branches/data/repositories/branches_repository.dart';
import 'package:dmms/Features/departments/data/data_providers/departments_data_provider.dart';
import 'package:dmms/Features/departments/data/repositories/departments_repository.dart';
import 'package:dmms/Features/employees/data/data_providers/employees_data_provider.dart';
import 'package:dmms/Features/employees/data/repositories/employees_repository.dart';
import 'package:dmms/Features/mission_types/data/data_providers/mission_types_data_provider.dart';
import 'package:dmms/Features/mission_types/data/repositories/mission_types_repository.dart';
import 'package:dmms/Features/missions/data/data_providers/missions_data_provider.dart';
import 'package:dmms/Features/missions/data/repositories/missions_repository.dart';
import 'package:dmms/Features/notifications/data/data_providers/notifications_data_provider.dart';
import 'package:dmms/Features/notifications/data/repositories/notifications_repository.dart';
import 'package:dmms/Features/users/data/data_providers/users_data_provider.dart';
import 'package:dmms/Features/users/data/repositories/users_repository.dart';
import 'package:dmms/Features/vehicles/data/data_providers/vehicles_data_provider.dart';
import 'package:dmms/Features/vehicles/data/repositories/vehicles_repository.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void serviceLocatorSetup() {
  serviceLocator
    ..registerLazySingleton(() => ApiHelper())
    ..registerLazySingleton(() => AuthDataProvider())
    ..registerLazySingleton(() => AuthRepo())
    ..registerLazySingleton(() => AuthBloc())
    ..registerLazySingleton(() => BranchesDataProvider())
    ..registerLazySingleton(() => BranchesRepository())
    ..registerLazySingleton(() => VehiclesDataProvider())
    ..registerLazySingleton(() => VehiclesRepository())
    ..registerLazySingleton(() => UsersDataProvider())
    ..registerLazySingleton(() => UsersRepository())
    ..registerLazySingleton(() => DepartmentsDataProvider())
    ..registerLazySingleton(() => DepartmentsRepository())
    ..registerLazySingleton(() => NotificationsDataProvider())
    ..registerLazySingleton(() => NotificationsRepository())
    ..registerLazySingleton(() => AppUpdatesDataProvider())
    ..registerLazySingleton(() => AppUpdatesRepository())
    ..registerLazySingleton(() => DashboardDataProvider())
    ..registerLazySingleton(() => DashboardRepository())
    ..registerLazySingleton(() => MissionTypesRepository())
    ..registerLazySingleton(() => MissionTypesDataProvider())
    ..registerLazySingleton(() => EmployeesDataProvider())
    ..registerLazySingleton(() => EmployeesRepository())
    ..registerLazySingleton(() => MissionsRepository())
    ..registerLazySingleton(() => MissionsDataProvider());
}
