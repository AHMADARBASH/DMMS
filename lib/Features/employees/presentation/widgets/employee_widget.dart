import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/confirmation_dialog.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/employees/bloc/employees_bloc.dart';
import 'package:dmms/Features/employees/data/models/employee.dart';
import 'package:dmms/Features/employees/presentation/pages/edit_employee_page.dart';
import 'package:dmms/Features/employees/presentation/pages/employee_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class EmployeeWidget extends StatelessWidget {
  final Employee employee;
  const EmployeeWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: ValueKey(employee.id),
        padding: EdgeInsets.symmetric(vertical: AppPadding.p5),
        child: Row(
          spacing: AppSize.s10,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(EmployeeDetailsPage.routeName,
                      extra: employee);
                },
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p12),
                  decoration: BoxDecoration(
                    color: context.appColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '${employee.firstName} ${employee.lastName}',
                        maxLines: 1,
                      )),
                      Icon(
                        Icons.circle,
                        color: employee.isActive
                            ? context.activeColor
                            : context.pendingColor,
                        size: AppSize.s15,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(EditEmployeePage.routeName, extra: employee);
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: context.appColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                child: Icon(
                  Icons.edit,
                  color: context.appColors.primary,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (employee.isActive) {
                  showConfirmationDialog(
                      context: context,
                      onYesPressed: () {
                        context.pop();
                        context.read<EmployeesBloc>().add(
                              EmployeesEvent.deActivate(
                                  employeeId: employee.id),
                            );
                      },
                      onNoPressed: context.pop,
                      content:
                          '${AppStrings.areYouSureYouWantToDeactivate.tr()} ${employee.firstName} ${employee.lastName}?');
                } else {
                  context
                      .read<EmployeesBloc>()
                      .add(EmployeesEvent.activate(employeeId: employee.id));
                }
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: context.appColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                child: Icon(
                  employee.isActive ? Icons.block : Icons.check_circle,
                  color: context.appColors.primary,
                  size: AppSize.s22,
                ),
              ),
            ),
          ],
        ));
  }
}
