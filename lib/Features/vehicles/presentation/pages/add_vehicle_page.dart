import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/extensions/string_extensions.dart';
import 'package:dmms/Core/models/city.dart';
import 'package:dmms/Core/presentation/widgets/app_button.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_drop_down_menu_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/presentation/widgets/error_refresh_widget.dart';
import 'package:dmms/Core/resources/app_cities.dart';
import 'package:dmms/Core/resources/app_fuel_types.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/vehicles/bloc/vehicles_bloc.dart';
import 'package:dmms/Features/vehicles/data/models/fuel_type.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle_brand.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class AddVehiclePage extends StatefulWidget {
  static const String routeName = '/AddVehiclePage';
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final formKey = GlobalKey<FormState>();

  VehicleBrand? selectedBrand;
  VehicleType? selectedType;
  City? selectedCity;
  bool? hasWirelessStation;
  FuelType? selectedFuelType;
  final modelController = TextEditingController();
  final sarcNumberController = TextEditingController();
  final maxPassengersController = TextEditingController();
  final plateNumberController = TextEditingController();
  final currentKMController = TextEditingController();
  final currentFuelController = TextEditingController();
  final distancePer20Controller = TextEditingController();
  final chaseNumberController = TextEditingController();
  final engineNumberController = TextEditingController();
  final insuranceExpireDateController = TextEditingController();

  String? Function(String?) requiredValidator = (value) {
    if (value == null || value == '') {
      return AppStrings.required.tr();
    }
    return null;
  };

  String? Function(String?) numbersOnlyValidator = (value) {
    if (value == null || value == '') {
      return AppStrings.required.tr();
    } else if (!value.isNumbersOnly) {
      return AppStrings.valueMustBeNumbersOnly.tr();
    } else {
      return null;
    }
  };

  @override
  void initState() {
    context.read<VehiclesBloc>().add(VehiclesEvent.getBrandsAndTypes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(),
        title: Text(AppStrings.addVehicle.tr()),
      ),
      body: BlocConsumer<VehiclesBloc, VehiclesState>(
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.show();
          } else if (state.successMessage != null && !state.isLoading) {
            EasyLoading.dismiss();
            context.read<VehiclesBloc>().add(VehiclesEvent.resetFlags());
            context.pop();
          } else {
            EasyLoading.dismiss();
          }
        },
        builder: (context, state) => state.errorResponse != null
            ? ErrorRefreshWidget(
                onPressed: () {
                  context
                      .read<VehiclesBloc>()
                      .add(VehiclesEvent.getBrandsAndTypes());
                },
                text: state.errorResponse!.errorMessage)
            : Form(
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
                                lable: AppStrings.model.tr(),
                                action: TextInputAction.next,
                                controller: modelController,
                                hasSuffix: false,
                                validator: requiredValidator,
                              ),
                              CustomTextField(
                                lable: AppStrings.sarcNumber.tr(),
                                action: TextInputAction.next,
                                controller: sarcNumberController,
                                hasSuffix: false,
                                validator: requiredValidator,
                              ),
                              CustomTextField(
                                keyBoardType: TextInputType.number,
                                action: TextInputAction.next,
                                lable: AppStrings.maxPassengers.tr(),
                                controller: maxPassengersController,
                                hasSuffix: false,
                                validator: numbersOnlyValidator,
                              ),
                              CustomTextField(
                                keyBoardType: TextInputType.number,
                                action: TextInputAction.next,
                                lable: AppStrings.plateNumber.tr(),
                                controller: plateNumberController,
                                hasSuffix: false,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return AppStrings.required.tr();
                                  } else if (!value.isNumbersOnly) {
                                    return AppStrings.valueMustBeNumbersOnly
                                        .tr();
                                  } else if (value.length < 6 ||
                                      value.length > 7) {
                                    return AppStrings
                                        .valueMustBeBetween6and7numbers;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              CustomTextField(
                                keyBoardType: TextInputType.number,
                                action: TextInputAction.next,
                                lable: AppStrings.currentKM.tr(),
                                controller: currentKMController,
                                hasSuffix: false,
                                validator: numbersOnlyValidator,
                              ),
                              CustomTextField(
                                keyBoardType: TextInputType.number,
                                action: TextInputAction.next,
                                lable: AppStrings.currentFuel.tr(),
                                controller: currentFuelController,
                                hasSuffix: false,
                                validator: numbersOnlyValidator,
                              ),
                              CustomTextField(
                                keyBoardType: TextInputType.number,
                                action: TextInputAction.next,
                                lable: AppStrings.distancePer20Litter.tr(),
                                controller: distancePer20Controller,
                                hasSuffix: false,
                                validator: numbersOnlyValidator,
                              ),
                              CustomTextField(
                                lable: AppStrings.chaseNumber.tr(),
                                action: TextInputAction.next,
                                controller: chaseNumberController,
                                hasSuffix: false,
                                validator: requiredValidator,
                              ),
                              CustomTextField(
                                lable: AppStrings.engineNumber.tr(),
                                action: TextInputAction.done,
                                controller: engineNumberController,
                                hasSuffix: false,
                                validator: requiredValidator,
                              ),
                              CustomDropDownMenuWidget<VehicleBrand>(
                                  value: state.brands.contains(selectedBrand)
                                      ? selectedBrand
                                      : null,
                                  items: state.brands
                                      .map(
                                        (brand) =>
                                            DropdownMenuItem<VehicleBrand>(
                                          value: brand,
                                          child: Text(brand.name),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (brand) {
                                    selectedBrand = brand;
                                  },
                                  lable: AppStrings.brand.tr(),
                                  validator: (brand) {
                                    if (brand == null) {
                                      return AppStrings.required.tr();
                                    }
                                    return null;
                                  }),
                              CustomDropDownMenuWidget<VehicleType>(
                                  value: state.types.contains(selectedType)
                                      ? selectedType
                                      : null,
                                  items: state.types
                                      .map(
                                        (type) => DropdownMenuItem<VehicleType>(
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
                              CustomDropDownMenuWidget<City>(
                                  value: AppCities.citiesList
                                          .contains(selectedCity)
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
                                          child: Text(b
                                              ? AppStrings.yes.tr()
                                              : AppStrings.no.tr()),
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
                                  value: AppFuelTypes.fuelTypes
                                          .contains(selectedFuelType)
                                      ? selectedFuelType
                                      : null,
                                  items: AppFuelTypes.fuelTypes
                                      .map(
                                        (fuelType) =>
                                            DropdownMenuItem<FuelType>(
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
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    firstDate: DateTime.parse("1970-01-01"),
                                    lastDate: DateTime.now()
                                        .add(Duration(days: 3650)),
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
                              AppButton(
                                  text: AppStrings.add.tr(),
                                  onTap: () {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }
                                    context
                                        .read<VehiclesBloc>()
                                        .add(VehiclesEvent.addVehicle(data: {
                                          "brandId": selectedBrand!.id,
                                          "typeId": selectedType!.id,
                                          "model": modelController.text,
                                          "sarcNumber":
                                              sarcNumberController.text,
                                          "maxPassengers":
                                              maxPassengersController.text,
                                          "cityId": selectedCity!.id,
                                          "plateNumber":
                                              plateNumberController.text,
                                          "currentKM": currentKMController.text,
                                          "currentFuel":
                                              currentFuelController.text,
                                          "distancePer20Litter":
                                              distancePer20Controller.text,
                                          "hasWirelessStation":
                                              hasWirelessStation,
                                          "fuelTypeId": selectedFuelType!.id,
                                          "chaseNumber":
                                              chaseNumberController.text,
                                          "engineNumber":
                                              engineNumberController.text,
                                          "insuranceExpirationDate":
                                              insuranceExpireDateController.text
                                        }));
                                  }),
                              SizedBox(
                                height: AppSize.s20,
                              ),
                            ],
                          ),
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
