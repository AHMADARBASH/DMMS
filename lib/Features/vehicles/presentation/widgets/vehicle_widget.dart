import 'package:dmms/Features/vehicles/bloc/vehicles_bloc.dart';
import 'package:dmms/Features/vehicles/presentation/pages/vehicle_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../Core/extensions/context_extenstions.dart';
import '../../../../Core/presentation/widgets/confirmation_dialog.dart';
import '../../../../Core/resources/app_strings.dart';
import '../../../../Core/resources/app_values.dart';
import '../../data/models/vehicle.dart';
import '../pages/edit_vehicle_page.dart';

class VehicleWidget extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback? onTap;

  const VehicleWidget({super.key, required this.vehicle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: ValueKey(vehicle.id),
        padding: EdgeInsets.symmetric(vertical: AppPadding.p5),
        child: Row(
          spacing: AppSize.s10,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(VehicleDetailsPage.routeName,
                      extra: vehicle);
                },
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p12),
                  decoration: BoxDecoration(
                    color: context.appColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        vehicle.sarcNumber,
                        maxLines: 1,
                      )),
                      Icon(
                        Icons.circle,
                        color: vehicle.isActive
                            ? context.activeColor
                            : context.pendingColor,
                        size: AppSize.s15,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(EditVehiclePage.routeName, extra: vehicle);
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: context.appColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                child: Icon(
                  Icons.edit,
                  color: context.appColors.primary,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (vehicle.isActive) {
                  showConfirmationDialog(
                    context: context,
                    content:
                        '${AppStrings.areYouSureYouWantToDeactivate.tr()} ${vehicle.sarcNumber}?',
                    onYesPressed: () {
                      context.pop();

                      context.read<VehiclesBloc>().add(
                          VehiclesEvent.deActivateVehicle(
                              vehicleId: vehicle.id));
                    },
                    onNoPressed: context.pop,
                  );
                } else {
                  context.read<VehiclesBloc>().add(
                      VehiclesEvent.activateVehicle(vehicleId: vehicle.id));
                }
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: context.appColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                child: Icon(
                  vehicle.isActive ? Icons.block : Icons.check_circle,
                  color: context.appColors.primary,
                  size: AppSize.s22,
                ),
              ),
            ),
          ],
        ));
  }
}
