import 'package:dmms/Features/app_updates/bloc/app_updates_bloc.dart'
    as app_updates;
import 'package:dmms/Features/app_updates/presentation/pages/check_for_updates_page.dart';
import 'package:dmms/Features/auth/bloc/auth_bloc.dart';
import 'package:dmms/Features/auth/presentation/pages/auth_page.dart';
import 'package:dmms/Features/main_pages/branch_admin_home_page.dart';
import 'package:dmms/Features/main_pages/normal_user_home_page.dart';
import 'package:dmms/Features/main_pages/region_admin_home_page.dart';
import 'package:dmms/Features/main_pages/system_admin_home_page.dart';
import 'package:dmms/Features/notifications/presentation/pages/notifications_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Core/resources/app_strings.dart';

class RootPage extends StatelessWidget {
  static const String routeName = '/RootPage';
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (context.mounted) {
        context.pushNamed(NotificationsPage.routeName);
      }
    });

    return BlocBuilder<app_updates.AppUpdatesBloc, app_updates.AppUpdatesState>(
      builder: (context, appUpdatestate) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          switch (appUpdatestate) {
            case app_updates.Loading():
              return CheckForUpdatesPage();
            case app_updates.Updated():
              return switch (state) {
                Initial() => const AuthPage(),
                Authenticated(user: final user) =>
                  user.roles[0] == RolesStrings.normalUser
                      ? NormalUserHomePage(user: user)
                      : user.roles[0] == RolesStrings.branchAdmin
                          ? BranchAdminHomePage(user: user)
                          : user.roles[0] == RolesStrings.regionAdmin
                              ? RegionAdminHomePage(user: user)
                              : SystemAdminHomePage(user: user),
                LoggedOut() => const AuthPage(),
                _ => const AuthPage(),
              };
            default:
              return CheckForUpdatesPage();
          }
        },
      ),
    );
  }
}
