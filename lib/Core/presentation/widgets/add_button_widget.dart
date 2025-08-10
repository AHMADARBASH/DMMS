import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        width: AppSize.s38,
        height: AppSize.s38,
        decoration: BoxDecoration(
          color: context.appColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.r12),
        ),
        child: Icon(
          Icons.playlist_add,
          color: context.appColors.primary,
        ),
      ),
    );
  }
}
