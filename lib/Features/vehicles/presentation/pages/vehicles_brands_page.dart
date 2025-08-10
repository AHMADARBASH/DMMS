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
import 'package:dmms/Features/vehicles/bloc/vehicles_bloc.dart';
import 'package:dmms/Features/vehicles/presentation/widgets/vehicle_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class VehiclesBrandsPage extends StatelessWidget {
  static const String routeName = '/VehiclesBrandsPage';
  VehiclesBrandsPage({super.key});
  final brandNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VehiclesBloc>(
        lazy: false,
        create: (context) =>
            VehiclesBloc()..add(VehiclesEvent.getBrandsAndTypes()),
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: context.appColors.surfaceContainer,
            appBar: AppBar(
              title: Text(AppStrings.vehcilesBrands.tr()),
              leading: BackButtonWidget(),
              actions: [
                AddButtonWidget(
                  onPressed: () {
                    var currentBloc = context.read<VehiclesBloc>();
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
                                          GreyHolder(),
                                          SizedBox(
                                            height: AppSize.s20,
                                          ),
                                          CustomTextField(
                                              hint: '',
                                              lable: AppStrings.type.tr(),
                                              controller: brandNameController,
                                              hasSuffix: false,
                                              validator: (value) {
                                                if (value == null ||
                                                    value == '') {
                                                  return AppStrings.required
                                                      .tr();
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
                                                    context.pop();
                                                    currentBloc.add(
                                                        VehiclesEvent
                                                            .addVehicleBrand(
                                                                data: {
                                                          "name":
                                                              brandNameController
                                                                  .text
                                                        }));
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
                            )).then((_) {
                      brandNameController.clear();
                    });
                  },
                )
              ],
            ),
            body: BlocConsumer<VehiclesBloc, VehiclesState>(
              listener: (context, state) {
                if (state.successMessage != null) {
                  showSnackBar(context, state.successMessage!);
                  context
                      .read<VehiclesBloc>()
                      .add(VehiclesEvent.clearMessage());
                }
                if (state.isLoading) {
                  EasyLoading.show();
                } else {
                  EasyLoading.dismiss();
                }
              },
              builder: (context, state) {
                if (state.errorResponse != null) {
                  return ErrorRefreshWidget(
                    text:
                        '${state.errorResponse!.errorMessage} \n ${state.errorResponse!.details}',
                    onPressed: () {
                      context
                          .read<VehiclesBloc>()
                          .add(VehiclesEvent.getBrandsAndTypes());
                    },
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<VehiclesBloc>()
                            .add(VehiclesEvent.getBrandsAndTypes());
                      },
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: AppSize.s10,
                        ),
                        itemCount: state.brands.length,
                        itemBuilder: (context, index) {
                          var brand = state.brands[index];
                          return VehicleBrandWidget(name: brand.name);
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}
