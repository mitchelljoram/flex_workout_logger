import 'package:flutter/material.dart';

/// Abstract class for [AppColors]
abstract class AppColors {
  /// Light Mode Surface Data
  static const lightMode = _LightModeColors();

  /// Dark Mode Surface Data
  static const darkMode = _DarkModeColors();
}

/// Surface Colors Light Mode
class _LightModeColors {
  const _LightModeColors();

  Color get backgroundPrimary => const Color(0xFFF9F9FB);
  Color get backgroundSecondary => const Color(0xFFFFFFFF);
  Color get backgroundTertiary => const Color(0xFFF9F9FB);

  Color get foregroundPrimary => const Color(0xFF000000);
  Color get foregroundSecondary => const Color(0xFF3C3C43).withOpacity(.6);
  Color get foregroundTertiary => const Color(0xFF3C3C43).withOpacity(.3);
  Color get foregroundQuaternary => const Color(0xFF3C3C43).withOpacity(.18);

  Color get divider => const Color(0xFF3C3C43).withOpacity(.36);

  Color get overlay => const Color(0xFF1C1C1E).withOpacity(.30);

  Color get pink => const Color(0xFFFEB2BF);
  Color get purple => const Color(0xFFD3BBFF);
  Color get blue => const Color(0xFFABC7FF);
  Color get green => const Color(0xFF9DD9B9);
  Color get yellow => const Color(0xFFFFDF97);
  Color get orange => const Color(0xFFFFB59F);
}

/// Surface Colors Dark Mode
class _DarkModeColors {
  const _DarkModeColors();

  Color get backgroundPrimary => const Color(0xFF1C1C1E);
  Color get backgroundSecondary => const Color(0xFF2C2C2E);
  Color get backgroundTertiary => const Color(0xFF3A3A3C);

  Color get foregroundPrimary => const Color(0xFFFFFFFF);
  Color get foregroundSecondary => const Color(0xFFEBEBF5).withOpacity(.6);
  Color get foregroundTertiary => const Color(0xFFEBEBF5).withOpacity(.3);
  Color get foregroundQuaternary => const Color(0xFFEBEBF5).withOpacity(.18);

  Color get divider => const Color(0xFF545458).withOpacity(.65);

  Color get overlay => const Color(0xFF1C1C1E).withOpacity(.75);

  Color get pink => const Color(0xFFFE7FA2);
  Color get purple => const Color(0xFFB28DF7);
  Color get blue => const Color(0xFF679FFB);
  Color get green => const Color(0xFF5DBA87);
  Color get yellow => const Color(0xFFFFD15E);
  Color get orange => const Color(0xFFFF8660);
}
