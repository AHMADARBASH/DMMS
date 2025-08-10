import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: Container(
        width: AppSize.s38,
        height: AppSize.s38,
        decoration: BoxDecoration(
          color: context.appColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.r12),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: AppSize.s20,
        ),
      ),
    );
  }
}
