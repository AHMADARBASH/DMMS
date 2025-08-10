import 'package:flutter/material.dart';

class AppColors {
  static ColorScheme lightColorScheme = _buildLightColorScheme();
  static ColorScheme darkColorScheme = _buildDarkColorScheme();

//  ColorScheme.fromSeed(
//     seedColor: Color(0xffed1c24),
//     primary: Color(0xffed1c24),
//     tertiary: Colors.white,
//   ),
  static ColorScheme _buildLightColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFED1C24),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFD8DA),
      onPrimaryContainer: Color(0xFF7F1016),
      primaryFixed: Color(0xFFFFD8DA),
      onPrimaryFixed: Color(0xFF7F1016),
      primaryFixedDim: Color(0xFFFFB3B7),
      onPrimaryFixedVariant: Color(0xFFD32F2F),

      secondary: Color(0xFFFAFBFB),
      onSecondary: Color(0xFF3B2A00),
      secondaryContainer: Color(0xFFFFF2DB),
      onSecondaryContainer: Color(0xFF5A3A00),
      secondaryFixed: Color(0xFFFFF2DB),
      onSecondaryFixed: Color(0xFF5A3A00),
      secondaryFixedDim: Color(0xFFFFD79C),
      onSecondaryFixedVariant: Color(0xFFB35D00),

      error: Color(0xFFE62B2B),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFCE7E7),
      onErrorContainer: Color(0xFF7F1717),

      // 👇 Card / container backgrounds
      surface: Color(0xFFFFFFFF), // pure white
      onSurface: Color(0xFF2B343B),

      surfaceBright: Color(0xFFFFFFFF),
      surfaceDim: Color(0xFFF4F4F4),
      onSurfaceVariant: Color(0xFF424A50),
      shadow: Color(0xFFE9ECEE),

      // 👇 Optional: subtle neutral gray containers
      surfaceContainer: Color(0xFFF5F5F5),
      surfaceContainerLow: Color(0xFFF7F7F7),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerHigh: Color(0xFFF2F2F2),
      surfaceContainerHighest: Color(0xFFEFEFEF),

      outline: Color(0xFF878C90),
      outlineVariant: Color(0xFFCCCFD0),
    );
  }

  static ColorScheme _buildDarkColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFC5EBD9),
      onPrimary: Color(0xFF30865E),
      primaryContainer: Color(0xFF1C4F38),
      onPrimaryContainer: Color(0xFFECF8F3),
      primaryFixed: Color(0xFFECF8F3),
      onPrimaryFixed: Color(0xFF256849),
      primaryFixedDim: Color(0xFFC5EBD9),
      onPrimaryFixedVariant: Color(0xFF3DAC79),
      secondary: Color(0xFFE3F0CC),
      onSecondary: Color(0xFF769341),
      secondaryContainer: Color(0xFF465727),
      onSecondaryContainer: Color(0xFFF6FAEF),
      secondaryFixed: Color(0xFFF6FAEF),
      onSecondaryFixed: Color(0xFF5B7233),
      secondaryFixedDim: Color(0xFFE3F0CC),
      onSecondaryFixedVariant: Color(0xFF769341),
      error: Color(0xFFF8BDBD),
      onError: Color(0xFFA41F1F),
      errorContainer: Color(0xFF3B2424),
      onErrorContainer: Color(0xFFFFDBDB),
      surface: Color(0xFF2B343B),
      onSurface: Color(0xFFECEEEF),
      surfaceBright: Color(0xFFFAFBFB), //does not exist in UI style
      surfaceDim: Color(0xFF424A50),
      onSurfaceVariant: Color(0xFFE3E5E6),
      surfaceContainer: Color(0xFF303A3B),
      surfaceContainerLow: Color(0xFF2B3436),
      surfaceContainerLowest: Color(0xFF262E31),
      surfaceContainerHigh: Color(0xFF323C3D),
      surfaceContainerHighest: Color(0xFF354041),
      outline: Color(0xFF9EA3A6),
      outlineVariant: Color(0xFF596066),
    );
  }
}

@immutable
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;

  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color infoContainer;
  final Color info;

  const AppColorExtension({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.infoContainer,
    required this.info,
  });

  static AppColorExtension light = AppColorExtension(
    success: Color(0xFF47CB2D),
    onSuccess: Color(0xFFF8FEF6),
    successContainer: Color(0xFFECF9E9),
    onSuccessContainer: Color(0xFF307223),
    warning: Color(0xFFEBB609),
    onWarning: Color(0xFFFFFFFB),
    warningContainer: Color(0xFFFFF6DB),
    onWarningContainer: Color(0xFF584813),
    infoContainer: Color(0xffE7F3FC),
    info: Color(0xff1B6DE9),
  );

  @override
  ThemeExtension<AppColorExtension> copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? infoContainer,
    Color? info,
  }) {
    return AppColorExtension(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      infoContainer: infoContainer ?? this.infoContainer,
      info: info ?? this.info,
    );
  }

  @override
  ThemeExtension<AppColorExtension> lerp(
      ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) {
      return this;
    }
    return AppColorExtension(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t)!,
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t)!,
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}

extension ColorAccess on BuildContext {
  /// Access to custom extension colors (safe fallback to light)
  AppColorExtension get extendedAppColors =>
      Theme.of(this).extension<AppColorExtension>() ?? AppColorExtension.light;

  /// Access to the full Material ColorScheme w/o the extension colors
}
