import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Future<dynamic> showConfirmationDialog(
        {required BuildContext context,
        required void Function() onYesPressed,
        required void Function() onNoPressed,
        required String content}) =>
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(
          content,
          style: context.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: context.textTheme.labelLarge,
            ),
            onPressed: onNoPressed,
            child: Text(
              AppStrings.no.tr(),
              style: context.textTheme.bodyMedium!
                  .copyWith(color: context.appColors.primary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appColors.primary,
              foregroundColor: context.appColors.primary,
            ),
            onPressed: onYesPressed,
            child: Text(
              AppStrings.yes.tr(),
              style: context.textTheme.bodyMedium!
                  .copyWith(color: context.appColors.surface),
            ),
          ),
        ],
      ),
    );
