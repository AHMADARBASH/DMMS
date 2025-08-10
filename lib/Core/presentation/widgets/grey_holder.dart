import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

class GreyHolder extends StatelessWidget {
  const GreyHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s50,
      height: AppSize.s6,
      decoration: BoxDecoration(
        color: context.appColors.outlineVariant,
        borderRadius: BorderRadius.circular(AppRadius.r8),
      ),
    );
  }
}
