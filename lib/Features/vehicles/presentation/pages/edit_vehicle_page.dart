import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/models/city.dart';
import 'package:dmms/Core/presentation/widgets/app_button.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_drop_down_menu_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/presentation/widgets/show_snack_bar.dart';
import 'package:dmms/Core/resources/app_cities.dart';
import 'package:dmms/Core/resources/app_fuel_types.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_validators.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/vehicles/bloc/vehicles_bloc.dart';
import 'package:dmms/Features/vehicles/data/models/fuel_type.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class EditVehiclePage extends StatefulWidget {
  static const String routeName = '/EditVehiclePage';
  final Vehicle vehicle;
  const EditVehiclePage({super.key, required this.vehicle});

  @override
  State<EditVehiclePage> createState() => _EditVehiclePageState();
}

class _EditVehiclePageState extends State<EditVehiclePage> {
  final maxPassengersController = TextEditingController();
  final plateNumberController = TextEditingController();
  final chaseNumberController = TextEditingController();
  final engineNumberController = TextEditingController();
  final insuranceExpireDateController = TextEditingController();
  bool? hasWirelessStation;
  bool? isActive;
  FuelType? selectedFuelType;
  City? selectedCity;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    maxPassengersController.text = widget.vehicle.maxPassengers.toString();
    plateNumberController.text = widget.vehicle.plateNumber;
    chaseNumberController.text = widget.vehicle.chaseNumber;
    engineNumberController.text = widget.vehicle.engineNumber;
    hasWirelessStation = widget.vehicle.hasWirelessStation;
    insuranceExpireDateController.text = widget.vehicle.insuranceExpirationDate;
    selectedFuelType = widget.vehicle.fuelType;
    selectedCity = widget.vehicle.city;
    isActive = widget.vehicle.isActive;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(),
        title: Text(AppStrings.edit.tr()),
        actions: [],
      ),
      body: BlocConsumer<VehiclesBloc, VehiclesState>(
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.show();
          }
          if (state.successMessage != null) {
            EasyLoading.dismiss();
            context.pop();
          }
          if (state.errorResponse != null && !state.isLoading) {
            EasyLoading.dismiss();
            showSnackBar(context, state.errorResponse!.details);
            context.read<VehiclesBloc>().add(VehiclesEvent.resetFlags());
          }
        },
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: AppSize.s10,
                children: [
                  CustomTextField(
                    keyBoardType: TextInputType.number,
                    lable: AppStrings.maxPassengers.tr(),
                    controller: maxPassengersController,
                    hasSuffix: false,
                    validator: AppValidators.numbersOnlyValidator,
                  ),
                  CustomTextField(
                    lable: AppStrings.plateNumber.tr(),
                    keyBoardType: TextInputType.number,
                    controller: plateNumberController,
                    hasSuffix: false,
                    validator: AppValidators.numbersOnlyValidator,
                  ),
                  CustomTextField(
                    lable: AppStrings.chaseNumber.tr(),
                    controller: chaseNumberController,
                    hasSuffix: false,
                    validator: AppValidators.requiredValidator,
                  ),
                  CustomTextField(
                    lable: AppStrings.engineNumber.tr(),
                    controller: engineNumberController,
                    hasSuffix: false,
                    validator: AppValidators.requiredValidator,
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
                            insuranceExpireDateController.text =
                                value.toString().substring(0, 10);
                          }
                        },
                      );
                    },
                    child: CustomTextField(
                      enabled: false,
                      hint: '',
                      lable: AppStrings.insuranceExpiry.tr(),
                      controller: insuranceExpireDateController,
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
                  CustomDropDownMenuWidget<City>(
                      value: AppCities.citiesList.contains(selectedCity)
                          ? selectedCity
                          : null,
                      items: AppCities.citiesList
                          .map(
                            (city) => DropdownMenuItem<City>(
                              value: city,
                              child: Text(city.name),
                            ),
                          )
                          .toList(),
                      onChanged: (c) {
                        selectedCity = c;
                      },
                      lable: AppStrings.city.tr(),
                      validator: (c) {
                        if (c == null) {
                          return AppStrings.required.tr();
                        }
                        return null;
                      }),
                  CustomDropDownMenuWidget<bool>(
                      value: hasWirelessStation,
                      items: [true, false]
                          .map(
                            (b) => DropdownMenuItem<bool>(
                              value: b,
                              child: Text(
                                  b ? AppStrings.yes.tr() : AppStrings.no.tr()),
                            ),
                          )
                          .toList(),
                      onChanged: (b) {
                        hasWirelessStation = b;
                      },
                      lable: AppStrings.wirelessStation.tr(),
                      validator: (b) {
                        if (b == null) {
                          return AppStrings.required.tr();
                        }
                        return null;
                      }),
                  CustomDropDownMenuWidget<FuelType>(
                      value: AppFuelTypes.fuelTypes.contains(selectedFuelType)
                          ? selectedFuelType
                          : null,
                      items: AppFuelTypes.fuelTypes
                          .map(
                            (fuelType) => DropdownMenuItem<FuelType>(
                              value: fuelType,
                              child: Text(fuelType.name),
                            ),
                          )
                          .toList(),
                      onChanged: (fuelType) {
                        selectedFuelType = fuelType;
                      },
                      lable: AppStrings.fuelType.tr(),
                      validator: (fuelType) {
                        if (fuelType == null) {
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
                            text: AppStrings.edit.tr(),
                            onTap: () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              context
                                  .read<VehiclesBloc>()
                                  .add(VehiclesEvent.updateVehicle(
                                    data: {
                                      "id": widget.vehicle.id,
                                      "maxPassengers": int.parse(
                                          maxPassengersController.text),
                                      "cityId": selectedCity!.id,
                                      "plateNumber": plateNumberController.text,
                                      "hasWirelessStation": hasWirelessStation,
                                      "fuelTypeId": selectedFuelType!.id,
                                      "chaseNumber": chaseNumberController.text,
                                      "engineNumber":
                                          engineNumberController.text,
                                      "insuranceExpirationDate":
                                          insuranceExpireDateController.text
                                    },
                                  ));
                            },
                            icon: Icons.edit,
                          )),
                      Expanded(child: SizedBox()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
