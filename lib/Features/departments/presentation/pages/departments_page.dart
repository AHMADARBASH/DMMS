import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/add_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/app_button.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/presentation/widgets/grey_holder.dart';
import 'package:dmms/Core/presentation/widgets/show_snack_bar.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/departments/bloc/departments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class DepartmentsPage extends StatelessWidget {
  static const String routeName = '/DepartmentsPage';
  DepartmentsPage({super.key});
  final formKey = GlobalKey<FormState>();

  final departmentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DepartmentsBloc>(
      lazy: false,
      create: (context) {
        return DepartmentsBloc()..add(DepartmentsEvent.getAll());
      },
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: BackButtonWidget(),
            title: Text(AppStrings.departments.tr()),
            actions: [
              AddButtonWidget(
                onPressed: () {
                  var currentBloc = context.read<DepartmentsBloc>();
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => BlocProvider.value(
                            value: currentBloc,
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Form(
                                key: formKey,
                                child: SizedBox(
                                  height: AppSize.s200,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p8),
                                    child: Column(
                                      children: [
                                        Row(),
                                        GreyHolder(),
                                        SizedBox(
                                          height: AppSize.s20,
                                        ),
                                        CustomTextField(
                                            lable: AppStrings.department.tr(),
                                            controller: departmentController,
                                            hasSuffix: false,
                                            validator: (value) {
                                              if (value == null ||
                                                  value == '') {
                                                return AppStrings.required.tr();
                                              }
                                              return null;
                                            }),
                                        SizedBox(
                                          height: AppSize.s12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child: SizedBox()),
                                            Expanded(
                                              flex: 2,
                                              child: AppButton(
                                                  text: AppStrings.add.tr(),
                                                  onTap: () {
                                                    if (!formKey.currentState!
                                                        .validate()) {
                                                      return;
                                                    }
                                                    currentBloc.add(
                                                        DepartmentsEvent
                                                            .addDepartment(
                                                                data: {
                                                          "name":
                                                              departmentController
                                                                  .text
                                                        }));
                                                    context.pop();
                                                  }),
                                            ),
                                            Expanded(child: SizedBox()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ));
                },
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
            child: Column(
              children: [
                BlocConsumer<DepartmentsBloc, DepartmentsState>(
                  listener: (context, state) {
                    if (state.isLoading) {
                      EasyLoading.show();
                    } else {
                      EasyLoading.dismiss();
                    }
                    if (!state.isLoading && state.successMessage != null) {
                      showSnackBar(context, state.successMessage!);
                    }
                  },
                  builder: (context, state) => state.departments.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<DepartmentsBloc>()
                                  .add(DepartmentsEvent.getAll());
                            },
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: AppSize.s10,
                              ),
                              itemCount: state.departments.length,
                              itemBuilder: (context, index) {
                                var dep = state.departments[index];
                                return Container(
                                  padding: EdgeInsets.all(AppPadding.p12),
                                  decoration: BoxDecoration(
                                    color: context.appColors.surface,
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.r12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        dep.name,
                                        maxLines: 1,
                                      )),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : state.errorResponse != null
                          ? Text(
                              '${state.errorResponse!.errorMessage}\n ${state.errorResponse!.details}')
                          : SizedBox(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
