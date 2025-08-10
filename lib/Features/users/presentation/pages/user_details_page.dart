import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/info_tile.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/users/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UserDetailsPage extends StatelessWidget {
  static const routeName = '/UserDetailsPage';
  final User user;
  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButtonWidget(),
          title: Text(AppStrings.userDetails.tr()),
        ),
        body: Card(
          elevation: AppSize.s0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppPadding.p12)),
          color: context.appColors.surfaceContainerLowest,
          margin: const EdgeInsets.symmetric(
              horizontal: AppPadding.p8, vertical: AppPadding.p8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InfoTile(
                    title: AppStrings.fullName.tr(),
                    value: '${user.firstName}  ${user.lastName}',
                    icon: Icons.person),
                InfoTile(
                    title: AppStrings.nationalId.tr(),
                    value: user.nationalId,
                    icon: Icons.credit_card_rounded),
                InfoTile(
                    title: AppStrings.birthDate.tr(),
                    value: user.birthDate,
                    icon: Icons.calendar_month),
                InfoTile(
                    title: AppStrings.role.tr(),
                    value: user.roles[0],
                    icon: Icons.security),
                InfoTile(
                    title: AppStrings.department.tr(),
                    value: user.department.name,
                    icon: Icons.work),
                InfoTile(
                    title: AppStrings.branch.tr(),
                    value: user.department.branch?.name ?? "",
                    icon: Icons.location_city),
                InfoTile(
                  title: AppStrings.status.tr(),
                  value: user.isActive
                      ? AppStrings.active.tr()
                      : AppStrings.inactive.tr(),
                  icon: Icons.check_circle,
                ),
              ],
            ),
          ),
        ));
  }
}
