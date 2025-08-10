import 'package:dmms/Core/resources/app_colors.dart';
import 'package:dmms/Core/resources/app_text_theme.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  dividerColor: Colors.transparent,
  splashColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    titleTextStyle: AppTextTheme.buildTextTheme()
        .bodyMedium!
        .copyWith(fontSize: AppSize.s16),
    backgroundColor: AppColors.lightColorScheme.surfaceContainer,
    iconTheme: IconThemeData(
      color: AppColors.lightColorScheme.onSurface,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.lightColorScheme.onSurface,
    ),
    surfaceTintColor: Colors.transparent,
  ),
  scaffoldBackgroundColor: AppColors.lightColorScheme.surfaceContainer,
  textTheme: AppTextTheme.buildTextTheme(),
  colorScheme: AppColors.lightColorScheme,
  useMaterial3: true,
);
