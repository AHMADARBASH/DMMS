import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/vehicles/data/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class VehicleDetailsPage extends StatelessWidget {
  static const String routeName = '/VehicleDetailsPage';
  final Vehicle vehicle;
  const VehicleDetailsPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButtonWidget(),
          title: Text(vehicle.sarcNumber),
        ),
        body: Card(
          elevation: AppSize.s0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppPadding.p12)),
          color: context.appColors.surfaceContainerLowest,
          margin: const EdgeInsets.symmetric(
              horizontal: AppPadding.p8, vertical: AppPadding.p8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                VehicleInfoTile(
                    title: AppStrings.brand.tr(),
                    value: '${vehicle.brand.name} - ${vehicle.model}',
                    icon: FontAwesome5.car),
                VehicleInfoTile(
                    title: AppStrings.type.tr(),
                    value: vehicle.type.name,
                    icon: Icons.category),
                VehicleInfoTile(
                    title: AppStrings.maxPassengers.tr(),
                    value: vehicle.maxPassengers.toString(),
                    icon: Icons.airline_seat_recline_normal),
                VehicleInfoTile(
                    title: AppStrings.city.tr(),
                    value: vehicle.city.name,
                    icon: Icons.location_city),
                VehicleInfoTile(
                    title: AppStrings.plateNumber.tr(),
                    value: vehicle.plateNumber,
                    icon: Icons.subtitles),
                VehicleInfoTile(
                    title: AppStrings.currentKM.tr(),
                    value: vehicle.currentKM.toString(),
                    icon: Icons.speed),
                VehicleInfoTile(
                    title: AppStrings.currentFuel.tr(),
                    value: vehicle.currentFuel.toString(),
                    icon: FontAwesome5.gas_pump),
                VehicleInfoTile(
                    title: AppStrings.distancePer20Litter.tr(),
                    value: vehicle.distancePer20Litter.toString(),
                    icon: Icons.route),
                VehicleInfoTile(
                    title: AppStrings.plateNumber.tr(),
                    value: vehicle.plateNumber,
                    icon: Icons.subtitles),
                VehicleInfoTile(
                    title: AppStrings.chaseNumber.tr(),
                    value: vehicle.chaseNumber,
                    icon: FontAwesome5.wrench),
                VehicleInfoTile(
                    title: AppStrings.engineNumber.tr(),
                    value: vehicle.engineNumber,
                    icon: FontAwesome5.cogs),
                VehicleInfoTile(
                    title: AppStrings.fuelType.tr(),
                    value: vehicle.fuelType.name,
                    icon: FontAwesome5.fire_alt),
                VehicleInfoTile(
                    title: AppStrings.branch.tr(),
                    value: vehicle.branch.name,
                    icon: Icons.business),
                VehicleInfoTile(
                  title: AppStrings.wirelessStation.tr(),
                  value: vehicle.hasWirelessStation
                      ? AppStrings.yes.tr()
                      : AppStrings.no.tr(),
                  icon: Icons.wifi,
                ),
                VehicleInfoTile(
                  title: AppStrings.status.tr(),
                  value: vehicle.isActive
                      ? AppStrings.active.tr()
                      : AppStrings.inactive.tr(),
                  icon: Icons.check_circle,
                ),
                VehicleInfoTile(
                    title: AppStrings.insuranceExpiry.tr(),
                    value: vehicle.insuranceExpirationDate,
                    icon: Icons.calendar_month),
              ],
            ),
          ),
        ));
  }
}

class VehicleInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Widget? trailing;

  const VehicleInfoTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.appColors.primary),
      title: Text(title, style: context.textTheme.bodyMedium),
      subtitle: Text(value),
      dense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppPadding.p6,
      ),
      trailing: trailing,
    );
  }
}
