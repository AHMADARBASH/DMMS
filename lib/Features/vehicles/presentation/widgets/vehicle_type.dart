import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

class VehicleTypeWidget extends StatelessWidget {
  final String name;
  const VehicleTypeWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.r12)),
      child: Text(name),
    );
  }
}
