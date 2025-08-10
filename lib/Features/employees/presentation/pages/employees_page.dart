import 'package:dmms/Core/presentation/widgets/add_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/resources/app_validators.dart';
import 'package:dmms/Features/employees/presentation/pages/add_employee_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../Core/presentation/widgets/back_button_widget.dart';
import '../../../../Core/presentation/widgets/error_refresh_widget.dart';
import '../../../../Core/resources/app_strings.dart';
import '../../../../Core/resources/app_values.dart';
import '../../bloc/employees_bloc.dart';
import '../widgets/employee_widget.dart';

class EmployeesPage extends StatelessWidget {
  static const String routeName = '/EmployeesPage';
  EmployeesPage({super.key});

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(),
        title: CustomTextField(
          controller: searchController,
          hasSuffix: false,
          action: TextInputAction.search,
          lable: AppStrings.searchInEmployees.tr(),
          validator: AppValidators.notRequired,
          onChanged: (value) {
            context
                .read<EmployeesBloc>()
                .add(EmployeesEvent.search(query: searchController.text));
          },
        ),
        actions: [
          AddButtonWidget(onPressed: () {
            context.pushNamed(AddEmployeePage.routeName);
          })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child: Column(
          children: [
            BlocConsumer<EmployeesBloc, EmployeesState>(
              listener: (context, state) {
                if (state.isLoading) {
                  EasyLoading.show();
                } else {
                  EasyLoading.dismiss();
                }
              },
              builder: (context, state) {
                if (state.errorResponse != null) {
                  return ErrorRefreshWidget(
                      onPressed: () {
                        context
                            .read<EmployeesBloc>()
                            .add(EmployeesEvent.getAll());
                      },
                      text:
                          '${state.errorResponse!.errorMessage} \n ${state.errorResponse!.details}');
                } else {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<EmployeesBloc>()
                            .add(EmployeesEvent.getAll());
                      },
                      child: ListView.builder(
                          itemCount: state.employees.length,
                          itemBuilder: (context, index) {
                            final employee = state.employees[index];
                            return EmployeeWidget(
                                key: ValueKey(employee.id), employee: employee);
                          }),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
