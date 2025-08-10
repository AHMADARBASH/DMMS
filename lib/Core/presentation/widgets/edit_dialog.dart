import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Future<dynamic> showEditDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  required void Function() onPressed,
}) async {
  showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
            surfaceTintColor: context.appColors.surface,
            backgroundColor: context.appColors.surface,
            title: Text(
              title,
              style: context.textTheme.bodyMedium!
                  .copyWith(color: context.appColors.primary),
            ),
            content: content,
            actions: [
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    surfaceTintColor: context.appColors.primary,
                    backgroundColor: context.appColors.primary),
                child: Text(
                  AppStrings.ok.tr(),
                  style: TextStyle(color: context.appColors.surface),
                ),
              )
            ],
          ));
}
