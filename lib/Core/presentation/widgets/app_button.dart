import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final IconData? icon;
  const AppButton(
      {required this.text, required this.onTap, super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.primary,
          borderRadius: BorderRadius.circular(AppRadius.r12),
        ),
        alignment: Alignment.center,
        height: AppSize.s40,
        padding:
            EdgeInsets.symmetric(vertical: AppSize.s5, horizontal: AppSize.s20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: context.textTheme.bodyLarge!.copyWith(
                color: context.appColors.onPrimary,
              ),
            ),
            SizedBox(
              width: AppSize.s6,
            ),
            if (icon != null) ...[
              Icon(
                icon,
                color: context.appColors.onPrimary,
              )
            ]
          ],
        ),
      ),
    );
  }
}
