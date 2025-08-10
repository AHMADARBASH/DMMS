import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/pages/settings_page.dart';
import 'package:dmms/Core/presentation/widgets/confirmation_dialog.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/auth/bloc/auth_bloc.dart';
import 'package:dmms/Features/auth/data/models/authenticated_user.dart';
import 'package:dmms/Features/notifications/bloc/notifications_bloc.dart';
import 'package:dmms/Features/users/presentation/pages/users_page.dart';
import 'package:dmms/Features/vehicles/presentation/pages/vehicles_brands_page.dart';
import 'package:dmms/Features/vehicles/presentation/pages/vehicles_types_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class Systemadmindrawer extends StatelessWidget {
  final AuthenticatedUser user;
  const Systemadmindrawer({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.appColors.surface,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: AppSize.s40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p16, vertical: AppPadding.p20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.account_circle,
                          size: AppSize.s48, color: context.appColors.primary),
                      const SizedBox(height: AppSize.s12),
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.appColors.onSurface,
                                ),
                      ),
                      const SizedBox(height: AppSize.s4),
                      Text(
                        '${user.branch.name} | ${user.department.name}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: context.appColors.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.people, color: context.appColors.primary),
                  title: Text(AppStrings.users.tr()),
                  onTap: () {
                    context.pushNamed(UsersPage.routeName,
                        extra: user.roles[0]);
                  },
                ),
                ListTile(
                  leading: Icon(
                    FontAwesome5.list,
                    color: context.appColors.primary,
                  ),
                  title: Text(AppStrings.vehcilesTypes.tr()),
                  onTap: () {
                    context.pushNamed(VehiclesTypesPage.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(
                    FontAwesome5.tags,
                    color: context.appColors.primary,
                  ),
                  title: Text(AppStrings.vehcilesBrands.tr()),
                  onTap: () {
                    context.pushNamed(VehiclesBrandsPage.routeName);
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.settings, color: context.appColors.primary),
                  title: Text(AppStrings.settings.tr()),
                  onTap: () {
                    context.pushNamed(SettingsPage.routeName);
                  },
                ),
              ],
            ),
          ),
          BlocConsumer<NotificationsBloc, NotificationsState>(
            listener: (context, state) {
              if (state.isLoading) {
                EasyLoading.show();
              } else {
                EasyLoading.dismiss();
              }
              if (state.loggedOut) {
                context.pop();
                EasyLoading.dismiss();
                BlocProvider.of<AuthBloc>(context).add(AuthEvent.logout());
              }
            },
            builder: (context, state) => ListTile(
              leading: Icon(
                Icons.logout,
                color: context.appColors.primary,
              ),
              title: Text(AppStrings.logout.tr()),
              onTap: () async {
                showConfirmationDialog(
                    context: context,
                    onYesPressed: () {
                      context.pop();
                      BlocProvider.of<NotificationsBloc>(context).add(
                          DeleteFCMToken(data: {
                        "fcmToken":
                            CachedData.getData(key: CacheStrings.fcmToken)
                      }));
                    },
                    onNoPressed: () {
                      context.pop();
                    },
                    content: AppStrings.areYouSureToLogout.tr());
              },
            ),
          ),
        ],
      ),
    );
  }
}
