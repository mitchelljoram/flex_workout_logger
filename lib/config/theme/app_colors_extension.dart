import 'package:flutter/material.dart';

/// App Colors Extension
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  /// Default constructor for the [AppColorsExtension]
  AppColorsExtension({
    /// Suface colors
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.foregroundPrimary,
    required this.foregroundSecondary,
    required this.foregroundTertiary,
    required this.foregroundQuaternary,
    required this.divider,
    required this.overlay,
    required this.pink,
    required this.purple,
    required this.blue,
    required this.green,
    required this.yellow,
    required this.orange,
  });

  // Background Color
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;

  /// Foreground Color
  final Color foregroundPrimary;
  final Color foregroundSecondary;
  final Color foregroundTertiary;
  final Color foregroundQuaternary;

  /// Divider Color
  final Color divider;

  /// Overlay
  final Color overlay;

  /// Detail Colors
  final Color pink;
  final Color purple;
  final Color blue;
  final Color green;
  final Color yellow;
  final Color orange;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? foregroundPrimary,
    Color? foregroundSecondary,
    Color? foregroundTertiary,
    Color? foregroundQuaternary,
    Color? divider,
    Color? overlay,
    Color? pink,
    Color? purple,
    Color? blue,
    Color? green,
    Color? yellow,
    Color? orange,
  }) {
    return AppColorsExtension(
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      foregroundPrimary: foregroundPrimary ?? this.foregroundPrimary,
      foregroundSecondary: foregroundSecondary ?? this.foregroundSecondary,
      foregroundTertiary: foregroundTertiary ?? this.foregroundTertiary,
      foregroundQuaternary: foregroundQuaternary ?? this.foregroundQuaternary,
      divider: divider ?? this.divider,
      overlay: overlay ?? this.overlay,
      pink: pink ?? this.pink,
      purple: purple ?? this.purple,
      blue: blue ?? this.blue,
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      orange: orange ?? this.orange,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      backgroundPrimary: Color.lerp(backgroundPrimary, other.foregroundPrimary, t)!,
      backgroundSecondary: Color.lerp(backgroundSecondary, other.foregroundSecondary, t)!,
      backgroundTertiary: Color.lerp(backgroundTertiary, other.foregroundTertiary, t)!,
      foregroundPrimary: Color.lerp(foregroundPrimary, other.foregroundPrimary, t)!,
      foregroundSecondary: Color.lerp(foregroundSecondary, other.foregroundSecondary, t)!,
      foregroundTertiary: Color.lerp(foregroundTertiary, other.foregroundTertiary, t)!,
      foregroundQuaternary: Color.lerp(foregroundQuaternary, other.foregroundQuaternary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      green: Color.lerp(green, other.green, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
    );
  }
}
