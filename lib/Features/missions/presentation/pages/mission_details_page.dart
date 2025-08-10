import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/info_tile.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/missions/data/models/mission.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class MissionDetailsPage extends StatelessWidget {
  static const String routeName = '/MissionDetailsPage';
  final Mission mission;
  const MissionDetailsPage({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButtonWidget(),
          title: Text(AppStrings.missionDetails.tr()),
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
                    title: AppStrings.number.tr(),
                    value: mission.serial_number.toString(),
                    icon: Icons.tag),
                InfoTile(
                    title: AppStrings.from.tr(),
                    value: mission.from,
                    icon: FontAwesome5.route),
                InfoTile(
                  title: AppStrings.to.tr(),
                  value: mission.to,
                  icon: FontAwesome5.route,
                ),
                InfoTile(
                  title: AppStrings.startDate.tr(),
                  value: mission.startDate,
                  icon: Icons.calendar_month,
                ),
                InfoTile(
                  title: AppStrings.endDate.tr(),
                  value: mission.endDate,
                  icon: Icons.calendar_month,
                ),
                InfoTile(
                  title: AppStrings.department.tr(),
                  value: mission.department.name,
                  icon: Icons.location_city,
                ),
                InfoTile(
                  title: AppStrings.vehicle.tr(),
                  value:
                      '${mission.vehicle.brand.name} ${mission.vehicle.model} (${mission.vehicle.sarcNumber})',
                  icon: FontAwesome5.car,
                ),
                InfoTile(
                  title: AppStrings.driver.tr(),
                  value:
                      '${mission.driver.firstName} ${mission.driver.lastName}',
                  icon: Iconic.steering_wheel,
                ),
                InfoTile(
                  title: AppStrings.missionLeader.tr(),
                  value:
                      '${mission.missionLeader.firstName} ${mission.missionLeader.lastName}',
                  icon: Icons.person,
                ),
                InfoTile(
                  title: AppStrings.user.tr(),
                  value: '${mission.user.firstName} ${mission.user.lastName}',
                  icon: Icons.person,
                ),
                InfoTile(
                  title: AppStrings.goingKM.tr(),
                  value: '${mission.going_KM}',
                  icon: Icons.speed,
                ),
                InfoTile(
                  title: AppStrings.backKM.tr(),
                  value: '${mission.back_KM ?? "N/A"}',
                  icon: Icons.speed,
                ),

                // InfoTile(
                //     title: AppStrings.position.tr(),
                //     value: employee.position,
                //     icon: Icons.laptop),
                // InfoTile(
                //     title: AppStrings.nationalId.tr(),
                //     value: employee.nationalId,
                //     icon: Icons.credit_card_rounded),
                // InfoTile(
                //     title: AppStrings.birthDate.tr(),
                //     value: employee.birthDate,
                //     icon: Icons.calendar_month),
                // InfoTile(
                //     title: AppStrings.bloodType.tr(),
                //     value: employee.bloodType,
                //     icon: Icons.bloodtype_outlined),
                // InfoTile(
                //     title: AppStrings.phoneNumber.tr(),
                //     value: employee.phoneNumber1,
                //     icon: Icons.phone_android_outlined),
                // if (employee.phoneNumber2 != null) ...[
                //   InfoTile(
                //       title: AppStrings.phoneNumber.tr(),
                //       value: employee.phoneNumber2!,
                //       icon: Icons.phone_android_outlined)
                // ],
                // InfoTile(
                //     title: AppStrings.branch.tr(),
                //     value: employee.department.branch?.name ?? "",
                //     icon: Icons.location_city),
                // InfoTile(
                //     title: AppStrings.department.tr(),
                //     value: employee.department.name,
                //     icon: Icons.work),
                // InfoTile(
                //     title: AppStrings.type.tr(),
                //     value: employee.type.name,
                //     icon: Icons.category),
                // InfoTile(
                //   title: AppStrings.status.tr(),
                //   value: employee.isActive
                //       ? AppStrings.active.tr()
                //       : AppStrings.inactive.tr(),
                //   icon: Icons.check_circle,
                // ),
              ],
            ),
          ),
        ));
  }
}
