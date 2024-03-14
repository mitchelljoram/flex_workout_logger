import 'package:flex_workout_logger/config/theme/app_colors.dart';
import 'package:flex_workout_logger/config/theme/app_colors_extension.dart';
import 'package:flex_workout_logger/config/theme/app_typography.dart';
import 'package:flex_workout_logger/config/theme/app_typography_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App Theme
class AppTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  /// Theme Mode Getter
  ThemeMode get themeMode => _themeMode;

  /// Theme Mode Setter
  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  static const _textTheme = AppTextThemeExtension(
    headlineLarge: AppTypography.headlineLarge,
    headlineMedium: AppTypography.headlineMedium,
    headlineSmall: AppTypography.headlineSmall,
    bodySmall: AppTypography.bodySmall,
    bodyMedium: AppTypography.bodyMedium,
    bodyLarge: AppTypography.bodyLarge,
    labelLarge: AppTypography.labelLarge,
    labelMedium: AppTypography.labelMedium,
    labelSmall: AppTypography.labelSmall,
    labelXSmall: AppTypography.labelXSmall,
  );

  /// Light Mode Theme Data
  static final light = ThemeData.light(useMaterial3: true).copyWith(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightMode.foregroundPrimary,
      selectionColor: AppColors.lightMode.foregroundTertiary,
      selectionHandleColor: AppColors.lightMode.foregroundPrimary,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: AppColors.lightMode.foregroundPrimary,
    ),
    extensions: [
      _lightAppColors,
      _textTheme,
    ],
  );

  static final _lightAppColors = AppColorsExtension(
    backgroundPrimary: AppColors.lightMode.backgroundPrimary,
    backgroundSecondary: AppColors.lightMode.backgroundSecondary,
    backgroundTertiary: AppColors.lightMode.backgroundTertiary,
    foregroundPrimary: AppColors.lightMode.foregroundPrimary,
    foregroundSecondary: AppColors.lightMode.foregroundSecondary,
    foregroundTertiary: AppColors.lightMode.foregroundTertiary,
    foregroundQuaternary: AppColors.lightMode.foregroundQuaternary,
    divider: AppColors.lightMode.divider,
    overlay: AppColors.lightMode.overlay,
    pink: AppColors.lightMode.pink,
    purple: AppColors.lightMode.purple,
    blue: AppColors.lightMode.blue,
    green: AppColors.lightMode.green,
    yellow: AppColors.lightMode.yellow,
    orange: AppColors.lightMode.orange,
  );

  /// Dark Mode Theme Data
  static final dark = ThemeData.dark(useMaterial3: true).copyWith(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.darkMode.foregroundPrimary,
      selectionColor: AppColors.darkMode.foregroundTertiary,
      selectionHandleColor: AppColors.darkMode.foregroundPrimary,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: AppColors.darkMode.foregroundPrimary,
    ),
    extensions: [
      _darkAppColors,
      _textTheme,
    ],
  );

  static final _darkAppColors = AppColorsExtension(
    backgroundPrimary: AppColors.darkMode.backgroundPrimary,
    backgroundSecondary: AppColors.darkMode.backgroundSecondary,
    backgroundTertiary: AppColors.darkMode.backgroundTertiary,
    foregroundPrimary: AppColors.darkMode.foregroundPrimary,
    foregroundSecondary: AppColors.darkMode.foregroundSecondary,
    foregroundTertiary: AppColors.darkMode.foregroundTertiary,
    foregroundQuaternary: AppColors.darkMode.foregroundQuaternary,
    divider: AppColors.darkMode.divider,
    overlay: AppColors.darkMode.overlay,
    pink: AppColors.darkMode.pink,
    purple: AppColors.darkMode.purple,
    blue: AppColors.darkMode.blue,
    green: AppColors.darkMode.green,
    yellow: AppColors.darkMode.yellow,
    orange: AppColors.darkMode.orange,
  );
}

///
extension AppThemeExtension on ThemeData {
  ///
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppTheme._darkAppColors;

  ///
  AppTextThemeExtension get appTextTheme =>
      extension<AppTextThemeExtension>() ?? AppTheme._textTheme;
}
