import 'package:dmms/Core/resources/app_validators.dart';
import 'package:dmms/Features/departments/bloc/departments_bloc.dart'
    as departments;
import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:dmms/Features/users/bloc/users_bloc.dart' as users;
import 'package:dmms/Features/users/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../Core/extensions/context_extenstions.dart';
import '../../../../Core/presentation/widgets/app_button.dart';
import '../../../../Core/presentation/widgets/back_button_widget.dart';
import '../../../../Core/presentation/widgets/custom_dialog.dart';
import '../../../../Core/presentation/widgets/custom_drop_down_menu_widget.dart';
import '../../../../Core/presentation/widgets/custom_text_field.dart';
import '../../../../Core/presentation/widgets/error_refresh_widget.dart';
import '../../../../Core/presentation/widgets/show_snack_bar.dart';
import '../../../../Core/resources/app_strings.dart';
import '../../../../Core/resources/app_values.dart';

class EditUserPage extends StatefulWidget {
  final User user;
  static const String routeName = '/EditUserPage';
  const EditUserPage({required this.user, super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final nationalIDController = TextEditingController();
  final birthDateController = TextEditingController();
  String selectedDate = '';
  late Department selectedDepartment;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    nationalIDController.text = widget.user.nationalId;
    selectedDate = widget.user.birthDate;
    selectedDepartment = widget.user.department;
    birthDateController.text = widget.user.birthDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<departments.DepartmentsBloc>(
      create: (context) => departments.DepartmentsBloc()
        ..add(
          departments.DepartmentsEvent.getByBranchId(
              branchId: widget.user.department.branchId),
        ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: BackButtonWidget(),
          title: Text(
            '${AppStrings.edit.tr()} ${widget.user.firstName} ${widget.user.lastName}',
          ),
        ),
        backgroundColor: context.appColors.surfaceContainer,
        body: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: formKey,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: AppSize.s10, horizontal: AppSize.s5),
            width: context.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      spacing: AppSize.s10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextField(
                            hint: '',
                            lable: AppStrings.firstName.tr(),
                            controller: firstNameController,
                            hasSuffix: false,
                            validator: (value) {
                              if (value == null || value == '') {
                                return AppStrings.firstNameRequired.tr();
                              }
                              return null;
                            }),
                        CustomTextField(
                            hint: '',
                            lable: AppStrings.lastName.tr(),
                            controller: lastNameController,
                            hasSuffix: false,
                            validator: (value) {
                              if (value == null || value == '') {
                                return AppStrings.lastNameRequired.tr();
                              }
                              return null;
                            }),
                        CustomTextField(
                          hint: '',
                          lable: AppStrings.nationalId.tr(),
                          controller: nationalIDController,
                          hasSuffix: false,
                          validator: AppValidators.nationalIdValidator,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime.parse("1970-01-01"),
                              lastDate: DateTime.now(),
                            ).then(
                              (value) {
                                if (value != null) {
                                  selectedDate =
                                      value.toString().substring(0, 10);

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
                                return AppStrings.birthDateRequired.tr();
                              }
                              return null;
                            },
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: context.appColors.primary,
                            ),
                          ),
                        ),
                        BlocConsumer<departments.DepartmentsBloc,
                            departments.DepartmentsState>(
                          listener: (context, state) {
                            if (state.isLoading) {
                              EasyLoading.show();
                            } else {
                              EasyLoading.dismiss();
                            }
                          },
                          builder: (context, state) => state
                                  .departments.isNotEmpty
                              ? SizedBox(
                                  child: CustomDropDownMenuWidget<Department>(
                                    lable: AppStrings.department.tr(),
                                    value: state.departments
                                            .contains(selectedDepartment)
                                        ? selectedDepartment
                                        : null,
                                    items: state.departments.map((department) {
                                      return DropdownMenuItem<Department>(
                                        value: department,
                                        child: Text(department.name,
                                            style:
                                                context.textTheme.bodyMedium),
                                      );
                                    }).toList(),
                                    onChanged: (department) {
                                      if (department != null) {
                                        selectedDepartment = department;
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return AppStrings.departmentRequired
                                            .tr();
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              : state.errorResponse != null
                                  ? ErrorRefreshWidget(
                                      onPressed: () {
                                        context
                                            .read<departments.DepartmentsBloc>()
                                            .add(
                                              departments.DepartmentsEvent
                                                  .getByBranchId(
                                                      branchId: widget.user
                                                          .department.branchId),
                                            );
                                      },
                                      text:
                                          '${state.errorResponse!.errorMessage}\n ${state.errorResponse!.details}')
                                  : SizedBox(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: BlocConsumer<users.UsersBloc, users.UsersState>(
                      listener: (context, state) {
                        if (state.errorResponse != null) {
                          context.pop();
                          showCustomDialog(
                              context: context,
                              title: state.errorResponse!.errorMessage,
                              content: state.errorResponse!.details,
                              onPressed: () {
                                context.pop();
                              });
                        }
                        if (state.userUpdated) {
                          showSnackBar(
                              context, AppStrings.userUpdatedSuccessfully.tr());
                          context.pop();
                        }
                      },
                      builder: (context, state) => Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: AppButton(
                                text: AppStrings.edit.tr(),
                                icon: Icons.edit,
                                onTap: () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context.read<users.UsersBloc>().add(
                                        users.UsersEvent.updateUserInfo(
                                          data: {
                                            "id": widget.user.id,
                                            "firstName":
                                                firstNameController.text,
                                            "lastName": lastNameController.text,
                                            "birthDate": selectedDate,
                                            "nationalId":
                                                nationalIDController.text,
                                            "departmentId":
                                                selectedDepartment.id
                                          },
                                        ),
                                      );
                                }),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
