import 'package:dmms/Core/resources/app_colors.dart';
import 'package:dmms/Core/resources/app_font.dart';
import 'package:dmms/Core/resources/app_font_styles.dart';
import 'package:flutter/material.dart';

final _displayLarge = getMediumStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s57,
);

final _displayMedium = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s42,
);

final _displaySmall = getLightStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s32,
);

final _headlineLarge = getMediumStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s32,
);

final _headlineMedium = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s28,
);

final _headlineSmall = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s24,
);

final _titleLarge = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s20,
);

final _titleMedium = getMediumStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s18,
);

final _titleSmall = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s16,
);

final _bodyLarge = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s16,
);

final _bodyMedium = getMediumStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s14,
);

final _bodySmall = getMediumStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s12,
);

final _labelLarge = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s14,
);

final _labelMedium = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s12,
);

final _labelSmall = getRegularStyle(
  color: AppColors.lightColorScheme.onSurface,
  fontSize: FontSize.s11,
);

class AppTextTheme {
  static TextTheme buildTextTheme() {
    return TextTheme(
      displayLarge: _displayLarge,
      displayMedium: _displayMedium,
      displaySmall: _displaySmall,
      headlineLarge: _headlineLarge,
      headlineMedium: _headlineMedium,
      headlineSmall: _headlineSmall,
      titleLarge: _titleLarge,
      titleMedium: _titleMedium,
      titleSmall: _titleSmall,
      bodyLarge: _bodyLarge,
      bodyMedium: _bodyMedium,
      bodySmall: _bodySmall,
      labelLarge: _labelLarge,
      labelMedium: _labelMedium,
      labelSmall: _labelSmall,
    );
  }
}

extension TextThemeExtension on TextTheme {
  // Display styles
  TextStyle get defaultDisplayLarge => displayLarge ?? _displayLarge;
  TextStyle get defaultDisplayMedium => displayMedium ?? _displayMedium;
  TextStyle get defaultDisplaySmall => displaySmall ?? _displaySmall;

  // Headline styles
  TextStyle get defaultHeadlineLarge => headlineLarge ?? _headlineLarge;
  TextStyle get defaultHeadlineMedium => headlineMedium ?? _headlineMedium;
  TextStyle get defaultHeadlineSmall => headlineSmall ?? _headlineSmall;

  // Title styles
  TextStyle get defaultTitleLarge => titleLarge ?? _titleLarge;
  TextStyle get defaultTitleMedium => titleMedium ?? _titleMedium;
  TextStyle get defaultTitleSmall => titleSmall ?? _titleSmall;

  // Body styles
  TextStyle get defaultBodyLarge => bodyLarge ?? _bodyLarge;
  TextStyle get defaultBodyMedium => bodyMedium ?? _bodyMedium;
  TextStyle get defaultBodySmall => bodySmall ?? _bodySmall;

  // Label styles
  TextStyle get defaultLabelLarge => labelLarge ?? _labelLarge;
  TextStyle get defaultLabelMedium => labelMedium ?? _labelMedium;
  TextStyle get defaultLabelSmall => labelSmall ?? _labelSmall;
}
