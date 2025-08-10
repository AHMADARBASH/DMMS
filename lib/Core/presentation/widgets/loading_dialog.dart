// ignore_for_file: sized_box_for_whitespace

import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/loading_widget.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

Future<dynamic> showLoadingDialog({required BuildContext context}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: context.appColors.surface,
      surfaceTintColor: context.appColors.surface,
      content: Container(
        width: AppSize.s100,
        height: AppSize.s100,
        child: LoadingWidget(
          color: context.appColors.primary,
        ),
      ),
    ),
  );
}
