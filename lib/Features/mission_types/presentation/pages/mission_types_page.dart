import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/add_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/app_button.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/presentation/widgets/error_refresh_widget.dart';
import 'package:dmms/Core/presentation/widgets/grey_holder.dart';
import 'package:dmms/Core/presentation/widgets/show_snack_bar.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/mission_types/bloc/mission_types_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class MissionTypesPage extends StatelessWidget {
  static const String routeName = '/MissionTypesPage';
  MissionTypesPage({super.key});
  final formKey = GlobalKey<FormState>();
  final missionTypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTypesBloc>(
      create: (context) => MissionTypesBloc()..add(MissionTypesEvent.getAll()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButtonWidget(),
            title: Text(AppStrings.missionTypes.tr()),
            actions: [
              AddButtonWidget(onPressed: () {
                var currentBloc = context.read<MissionTypesBloc>();
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => BlocProvider.value(
                          value: currentBloc,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Form(
                              key: formKey,
                              child: SizedBox(
                                height: AppSize.s200,
                                child: Padding(
                                  padding: const EdgeInsets.all(AppPadding.p8),
                                  child: Column(
                                    children: [
                                      GreyHolder(),
                                      SizedBox(
                                        height: AppSize.s20,
                                      ),
                                      CustomTextField(
                                          hint: '',
                                          lable: AppStrings.type.tr(),
                                          controller: missionTypeController,
                                          hasSuffix: false,
                                          validator: (value) {
                                            if (value == null || value == '') {
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
                                              onTap: () {
                                                if (!formKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                currentBloc.add(
                                                    MissionTypesEvent.add(
                                                        data: {
                                                      "name":
                                                          missionTypeController
                                                              .text
                                                    }));
                                                context.pop();
                                              },
                                              text: AppStrings.add.tr(),
                                            ),
                                          ),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
              })
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
            child: BlocConsumer<MissionTypesBloc, MissionTypesState>(
                listener: (context, state) {
              if (state.isLoading) {
                EasyLoading.show();
              } else {
                EasyLoading.dismiss();
              }
              if (state.successMessage != null) {
                showSnackBar(context, state.successMessage!);
                context
                    .read<MissionTypesBloc>()
                    .add(MissionTypesEvent.resetFlags());
              }
            }, builder: (context, state) {
              if (state.errorResponse != null) {
                return ErrorRefreshWidget(
                    onPressed: () {
                      context
                          .read<MissionTypesBloc>()
                          .add(MissionTypesEvent.getAll());
                    },
                    text: AppStrings.errorWhileGettingMissionTypes.tr());
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<MissionTypesBloc>()
                        .add(MissionTypesEvent.getAll());
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: AppSize.s10,
                    ),
                    itemCount: state.types.length,
                    itemBuilder: (context, index) {
                      final type = state.types[index];
                      return Container(
                        padding: EdgeInsets.all(AppPadding.p12),
                        decoration: BoxDecoration(
                            color: context.appColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.r12)),
                        child: Text(type.name),
                      );
                    },
                  ),
                );
              }
            }),
          ),
        );
      }),
    );
  }
}
