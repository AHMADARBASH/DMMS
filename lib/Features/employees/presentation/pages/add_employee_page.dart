import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/extensions/string_extensions.dart';
import 'package:dmms/Core/presentation/widgets/app_button.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_drop_down_menu_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/presentation/widgets/loading_widget.dart';
import 'package:dmms/Core/presentation/widgets/show_snack_bar.dart';
import 'package:dmms/Core/resources/app_employee_types.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_validators.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/departments/bloc/departments_bloc.dart';
import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:dmms/Features/employees/bloc/employees_bloc.dart';
import 'package:dmms/Features/employees/data/models/employee_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class AddEmployeePage extends StatelessWidget {
  static const String routeName = '/AddEmployeePage';
  AddEmployeePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final nationalIDController = TextEditingController();
  final positionController = TextEditingController();
  final phoneNumber1Controller = TextEditingController();
  final phoneNumber2Controller = TextEditingController();
  final bloodTypeController = TextEditingController();
  Department? selectedDepartment;
  EmployeeType? selectedType;

  @override
  Widget build(BuildContext context) {
    context.read<DepartmentsBloc>().add(DepartmentsEvent.getAll());
    return Scaffold(
        appBar: AppBar(
          leading: BackButtonWidget(),
          title: Text(AppStrings.addEmployee.tr()),
        ),
        body: BlocConsumer<EmployeesBloc, EmployeesState>(
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
            if (state.successMessage != null) {
              EasyLoading.dismiss();
              showSnackBar(context, state.successMessage!);
              context.pop();
            }
            if (state.errorResponse != null && !state.isLoading) {
              EasyLoading.dismiss();
              showSnackBar(context, state.errorResponse!.details);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: AppSize.s10,
                    children: [
                      CustomTextField(
                        lable: AppStrings.firstName.tr(),
                        controller: firstNameController,
                        hasSuffix: false,
                        validator: AppValidators.requiredValidator,
                      ),
                      CustomTextField(
                        lable: AppStrings.lastName.tr(),
                        controller: lastNameController,
                        hasSuffix: false,
                        validator: AppValidators.requiredValidator,
                      ),
                      CustomTextField(
                        lable: AppStrings.nationalId.tr(),
                        controller: nationalIDController,
                        hasSuffix: false,
                        validator: AppValidators.nationalIdValidator,
                      ),
                      CustomTextField(
                        lable: AppStrings.position.tr(),
                        controller: positionController,
                        hasSuffix: false,
                        validator: AppValidators.requiredValidator,
                      ),
                      CustomTextField(
                        lable: AppStrings.phoneNumber1.tr(),
                        controller: phoneNumber1Controller,
                        hasSuffix: false,
                        validator: AppValidators.requiredPhoneNumberValidator,
                      ),
                      CustomTextField(
                        lable: AppStrings.phoneNumber2.tr(),
                        controller: phoneNumber2Controller,
                        hasSuffix: false,
                        validator: (value) {
                          if (value != null && value != "") {
                            if (!value.isPhoneNumber) {
                              return AppStrings.invalidPhoneNumber.tr();
                            }
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        lable: AppStrings.bloodType.tr(),
                        controller: bloodTypeController,
                        hasSuffix: false,
                        validator: AppValidators.bloodTypeValidator,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime.parse("1970-01-01"),
                            lastDate: DateTime.now().add(Duration(days: 3650)),
                          ).then(
                            (value) {
                              if (value != null) {
                                birthDateController.text =
                                    value.toString().substring(0, 10);
                              }
                            },
                          );
                        },
                        child: CustomTextField(
                          enabled: false,
                          hint: '',
                          lable: AppStrings.birthDate.tr(),
                          controller: birthDateController,
                          hasSuffix: true,
                          validator: (value) {
                            if (value == null || value == '') {
                              return AppStrings.required.tr();
                            }
                            return null;
                          },
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: context.appColors.primary,
                          ),
                        ),
                      ),
                      BlocConsumer<DepartmentsBloc, DepartmentsState>(
                        listener: (context, state) {
                          if (state.successMessage != null) {
                            EasyLoading.dismiss();
                            context.pop();
                          }
                          if (state.errorResponse != null && !state.isLoading) {
                            EasyLoading.dismiss();
                            showSnackBar(context, state.errorResponse!.details);
                          }
                        },
                        builder: (context, state) => state.isLoading
                            ? Center(
                                child: LoadingWidget(
                                  color: context.appColors.primary,
                                ),
                              )
                            : CustomDropDownMenuWidget<Department>(
                                value: state.departments
                                        .contains(selectedDepartment)
                                    ? selectedDepartment
                                    : null,
                                items: state.departments
                                    .map(
                                      (department) =>
                                          DropdownMenuItem<Department>(
                                        value: department,
                                        child: Text(department.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (d) {
                                  selectedDepartment = d;
                                },
                                lable: AppStrings.department.tr(),
                                validator: (d) {
                                  if (d == null) {
                                    return AppStrings.required.tr();
                                  }
                                  return null;
                                }),
                      ),
                      CustomDropDownMenuWidget<EmployeeType>(
                          value: AppEmployeeTypes.employeeTypes
                                  .contains(selectedType)
                              ? selectedType
                              : null,
                          items: AppEmployeeTypes.employeeTypes
                              .map(
                                (type) => DropdownMenuItem<EmployeeType>(
                                  value: type,
                                  child: Text(type.name),
                                ),
                              )
                              .toList(),
                          onChanged: (type) {
                            selectedType = type;
                          },
                          lable: AppStrings.type.tr(),
                          validator: (type) {
                            if (type == null) {
                              return AppStrings.required.tr();
                            }
                            return null;
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(
                              flex: 2,
                              child: AppButton(
                                text: AppStrings.add.tr(),
                                onTap: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context
                                      .read<EmployeesBloc>()
                                      .add(EmployeesEvent.add(data: {
                                        "firstName": firstNameController.text,
                                        "lastName": lastNameController.text,
                                        "birthDate": birthDateController.text,
                                        "nationalId": nationalIDController.text,
                                        "departmentId": selectedDepartment!.id,
                                        "typeId": selectedType!.id,
                                        "position": positionController.text,
                                        "phoneNumber1":
                                            phoneNumber1Controller.text,
                                        if (phoneNumber2Controller
                                            .text.isNotEmpty)
                                          "phoneNumber2":
                                              phoneNumber2Controller.text,
                                        "bloodType": bloodTypeController.text
                                      }));
                                },
                              )),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s24,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
