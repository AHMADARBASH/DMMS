import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/show_snack_bar.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/auth/bloc/auth_bloc.dart';
import 'package:dmms/Features/notifications/bloc/notifications_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/SettingsPage';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
        child: Column(
          children: [
            Card(
              elevation: AppSize.s0,
              color: context.appColors.surface,
              child: ExpansionTile(
                leading: Icon(
                  Icons.translate,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  AppStrings.language.tr(),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: AppPadding.p12),
                    child: ListTile(
                      leading: Icon(
                        Icons.language,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'English',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                      onTap: () async {
                        await context.setLocale(const Locale("en", "US"));
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: AppPadding.p12),
                    child: ListTile(
                      leading: Icon(
                        Icons.language,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'العربية',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                      onTap: () async {
                        await context.setLocale(const Locale("ar", "SA"));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: AppSize.s0,
              color: context.appColors.surface,
              child: ListTile(
                title: Text(AppStrings.notifications.tr()),
                leading: Icon(
                  Icons.notifications,
                  color: context.appColors.primary,
                ),
                trailing:
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  if (state is Authenticated) {
                    return Padding(
                      padding: EdgeInsets.all(AppPadding.p4),
                      child: Switch(
                        value: state.user.isNotificationEnabled,
                        onChanged: (value) {
                          if (!value) {
                            try {
                              context.read<NotificationsBloc>().add(
                                  NotificationsEvent.disableNotifications());
                              context.read<AuthBloc>().add(
                                  AuthEvent.updateUserData(state.user
                                      .copyWith(isNotificationEnabled: false)));
                              showSnackBar(
                                  context,
                                  AppStrings.notificationDisabledSuccessfully
                                      .tr());
                            } catch (e) {
                              context.read<AuthBloc>().add(
                                  AuthEvent.updateUserData(state.user
                                      .copyWith(isNotificationEnabled: true)));
                            }
                          } else {
                            try {
                              context.read<NotificationsBloc>().add(
                                  NotificationsEvent.enableNotifications());
                              context.read<AuthBloc>().add(
                                  AuthEvent.updateUserData(state.user
                                      .copyWith(isNotificationEnabled: true)));
                              showSnackBar(
                                  context,
                                  AppStrings.notificationEnabledSuccessfully
                                      .tr());
                            } catch (e) {
                              context.read<AuthBloc>().add(
                                  AuthEvent.updateUserData(state.user
                                      .copyWith(isNotificationEnabled: false)));
                            }
                          }
                        },
                        activeTrackColor: context.appColors.primary,
                        activeColor: context.appColors.onPrimary,
                      ),
                    );
                  }
                  return SizedBox();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
