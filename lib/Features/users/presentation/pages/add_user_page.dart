import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/app_button.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_dialog.dart';
import 'package:dmms/Core/presentation/widgets/custom_drop_down_menu_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/presentation/widgets/error_refresh_widget.dart';
import 'package:dmms/Core/presentation/widgets/loading_dialog.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_validators.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/auth/bloc/auth_bloc.dart' as auth;
import 'package:dmms/Features/branches/bloc/branches_bloc.dart' as branches;
import 'package:dmms/Features/branches/data/models/branch.dart';
import 'package:dmms/Features/departments/bloc/departments_bloc.dart'
    as departments;
import 'package:dmms/Features/departments/data/models/department.dart';
import 'package:dmms/Features/users/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class AddUserPage extends StatefulWidget {
  static const String routeName = '/AddUserPage';
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final nationalIDController = TextEditingController();
  final passwordController = TextEditingController();
  final birthDateController = TextEditingController();
  String? selectedDate;
  String? selectedRole;
  Branch? selectedBranch;
  Department? selectedDepartment;
  final List<String> roles = [
    RolesStrings.normalUser,
    RolesStrings.branchAdmin
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<auth.AuthBloc>(
          create: (context) => auth.AuthBloc()
            ..add(
              const auth.AuthEvent.checkLoginStatus(),
            ),
        ),
        BlocProvider<branches.BranchesBloc>(
          create: (context) => branches.BranchesBloc()
            ..add(const branches.BranchesEvent.getAll()),
        ),
        BlocProvider<departments.DepartmentsBloc>(
          create: (context) => departments.DepartmentsBloc(),
        ),
      ],
      child: BlocListener<auth.AuthBloc, auth.AuthState>(
        listener: (context, state) {
          if (state is auth.Loading) {
            showLoadingDialog(context: context);
          }
          if (state is auth.Error) {
            context.pop();
            showCustomDialog(
                context: context,
                title: state.errorResponse.errorMessage,
                content: state.errorResponse.details,
                onPressed: context.pop);
          }
          if (state is auth.UserCreated) {
            context.pop();
            showCustomDialog(
                context: context,
                title: AppStrings.done.tr(),
                content: AppStrings.userCreatedSuccessfully.tr(),
                onPressed: () {
                  context.pop();
                  context.pop();
                });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButtonWidget(),
          ),
          backgroundColor: context.appColors.surfaceContainer,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      child: Column(
                        spacing: AppSize.s10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextField(
                              action: TextInputAction.next,
                              backgroundColor: context.appColors.surface,
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
                              action: TextInputAction.next,
                              backgroundColor: context.appColors.surface,
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
                          SizedBox(
                            child: CustomTextField(
                              action: TextInputAction.next,
                              backgroundColor: context.appColors.surface,
                              keyBoardType: TextInputType.number,
                              hint: '',
                              lable: AppStrings.nationalId.tr(),
                              controller: nationalIDController,
                              hasSuffix: false,
                              validator: AppValidators.nationalIdValidator,
                            ),
                          ),
                          CustomTextField(
                              backgroundColor: context.appColors.surface,
                              action: TextInputAction.next,
                              hint: '',
                              lable: AppStrings.userName.tr(),
                              controller: userNameController,
                              hasSuffix: false,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return AppStrings.userNameRequired.tr();
                                }
                                return null;
                              }),
                          CustomTextField(
                              backgroundColor: context.appColors.surface,
                              hint: '',
                              lable: AppStrings.password.tr(),
                              action: TextInputAction.done,
                              isPassword: true,
                              controller: passwordController,
                              hasSuffix: true,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return AppStrings.passwordRequired.tr();
                                }
                                return null;
                              }),
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
                          BlocConsumer<branches.BranchesBloc,
                              branches.BranchesState>(
                            listener: (context, state) {
                              if (state.isLoading) {
                                EasyLoading.show();
                              } else {
                                EasyLoading.dismiss();
                              }
                            },
                            builder: (context, state) => state
                                    .branches.isNotEmpty
                                ? SizedBox(
                                    child: CustomDropDownMenuWidget<Branch>(
                                      lable: AppStrings.branch.tr(),
                                      value: state.branches
                                              .contains(selectedBranch)
                                          ? selectedBranch
                                          : null,
                                      items: state.branches.map((branch) {
                                        return DropdownMenuItem<Branch>(
                                          value: branch,
                                          child: Text(branch.name,
                                              style:
                                                  context.textTheme.bodyMedium),
                                        );
                                      }).toList(),
                                      onChanged: (branch) {
                                        if (branch != null) {
                                          selectedBranch = branch;
                                          context
                                              .read<
                                                  departments.DepartmentsBloc>()
                                              .add(departments.DepartmentsEvent
                                                  .getByBranchId(
                                                      branchId: branch.id));
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return AppStrings.branchRequired.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                : state.errorResponse != null
                                    ? ErrorRefreshWidget(
                                        onPressed: () {
                                          context
                                              .read<branches.BranchesBloc>()
                                              .add(branches.BranchesEvent
                                                  .getAll());
                                        },
                                        text:
                                            '${state.errorResponse!.errorMessage}\n ${state.errorResponse!.details}')
                                    : SizedBox(),
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
                                      items:
                                          state.departments.map((department) {
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
                                              .read<
                                                  departments.DepartmentsBloc>()
                                              .add(departments.DepartmentsEvent
                                                  .getByBranchId(
                                                      branchId:
                                                          selectedBranch!.id));
                                        },
                                        text:
                                            '${state.errorResponse!.errorMessage}\n ${state.errorResponse!.details}')
                                    : SizedBox(),
                          ),
                          CustomDropDownMenuWidget<String>(
                            lable: AppStrings.role.tr(),
                            value: roles.contains(selectedRole)
                                ? selectedRole
                                : null,
                            items: roles.map((role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(
                                  role,
                                  style: context.textTheme.bodyMedium,
                                ),
                              );
                            }).toList(),
                            onChanged: (role) {
                              if (role != null) {
                                selectedRole = role;
                              }
                            },
                            validator: (value) {
                              if (value == null) {
                                return AppStrings.roleRequired.tr();
                              }
                              return null;
                            },
                          ),
                          Center(
                              child:
                                  BlocConsumer<auth.AuthBloc, auth.AuthState>(
                            listener: (context, state) {},
                            builder: (context, state) => AppButton(
                                text: AppStrings.add.tr(),
                                onTap: () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  if (state is auth.Loading) {
                                    return;
                                  }
                                  if (selectedRole ==
                                      RolesStrings.branchAdmin) {
                                    context
                                        .read<auth.AuthBloc>()
                                        .add(auth.AuthEvent.createBranchAdmin({
                                          "firstName": firstNameController.text,
                                          "lastName": lastNameController.text,
                                          "userName": userNameController.text,
                                          "birthDate": selectedDate,
                                          "nationalId":
                                              nationalIDController.text,
                                          "departmentId":
                                              selectedDepartment!.id,
                                          "password": passwordController.text,
                                          "role": selectedRole
                                        }));
                                    context
                                        .read<UsersBloc>()
                                        .add(UsersEvent.getAllUsers());
                                  } else {
                                    context
                                        .read<auth.AuthBloc>()
                                        .add(auth.AuthEvent.createNormalUser({
                                          "firstName": firstNameController.text,
                                          "lastName": lastNameController.text,
                                          "userName": userNameController.text,
                                          "birthDate": selectedDate,
                                          "nationalId":
                                              nationalIDController.text,
                                          "departmentId":
                                              selectedDepartment!.id,
                                          "password": passwordController.text,
                                          "role": selectedRole
                                        }));
                                    context
                                        .read<UsersBloc>()
                                        .add(UsersEvent.getAllUsers());
                                  }
                                }),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
