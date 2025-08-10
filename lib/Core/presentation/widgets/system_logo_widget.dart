import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_assets.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SystemLogoWidget extends StatelessWidget {
  const SystemLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: AppSize.s200,
          height: AppSize.s200,
          child: Image(
            image: AssetImage(ImageAssets.sarcLogo),
          ),
        ),
        SizedBox(
          height: AppSize.s24,
        ),
        Text(
          AppStrings.dmuMissionManagementSystem.tr(),
          style: context.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: AppSize.s12,
        ),
      ],
    );
  }
}
