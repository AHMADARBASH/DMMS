import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/info_tile.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/employees/data/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EmployeeDetailsPage extends StatelessWidget {
  static const String routeName = '/EmployeeDetailsPage';
  final Employee employee;
  const EmployeeDetailsPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButtonWidget(),
          title: Text(AppStrings.employeeDetails.tr()),
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
                    value: '${employee.firstName}  ${employee.lastName}',
                    icon: Icons.person),
                InfoTile(
                    title: AppStrings.position.tr(),
                    value: employee.position,
                    icon: Icons.laptop),
                InfoTile(
                    title: AppStrings.nationalId.tr(),
                    value: employee.nationalId,
                    icon: Icons.credit_card_rounded),
                InfoTile(
                    title: AppStrings.birthDate.tr(),
                    value: employee.birthDate,
                    icon: Icons.calendar_month),
                InfoTile(
                    title: AppStrings.bloodType.tr(),
                    value: employee.bloodType,
                    icon: Icons.bloodtype_outlined),
                InfoTile(
                    title: AppStrings.phoneNumber.tr(),
                    value: employee.phoneNumber1,
                    icon: Icons.phone_android_outlined),
                if (employee.phoneNumber2 != null) ...[
                  InfoTile(
                      title: AppStrings.phoneNumber.tr(),
                      value: employee.phoneNumber2!,
                      icon: Icons.phone_android_outlined)
                ],
                InfoTile(
                    title: AppStrings.branch.tr(),
                    value: employee.department.branch?.name ?? "",
                    icon: Icons.location_city),
                InfoTile(
                    title: AppStrings.department.tr(),
                    value: employee.department.name,
                    icon: Icons.work),
                InfoTile(
                    title: AppStrings.type.tr(),
                    value: employee.type.name,
                    icon: Icons.category),
                InfoTile(
                  title: AppStrings.status.tr(),
                  value: employee.isActive
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
