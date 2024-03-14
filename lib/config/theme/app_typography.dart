import 'package:flutter/material.dart';

/// App Typography class
abstract class AppTypography {

  /// Headlines
  static const headlineLarge = TextStyle(
    fontSize: 22,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 28 / 22,
    letterSpacing: 0,
  );

  static const headlineMedium = TextStyle(
    fontSize: 16,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    letterSpacing: 0.15,
  );

  static const headlineSmall = TextStyle(
    fontSize: 14,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.1,
  );

  /// Body
  static const bodyLarge = TextStyle(
    fontSize: 16,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0.5,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.25,
  );

  static const bodySmall = TextStyle(
    fontSize: 12,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0,
  );

  /// Labels
  static const labelLarge = TextStyle(
    fontSize: 14,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.1,
  );

  static const labelMedium = TextStyle(
    fontSize: 12,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0.5,
  );

  static const labelSmall = TextStyle(
    fontSize: 11,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 16 / 11,
    letterSpacing: 0.5,
  );

  static const labelXSmall = TextStyle(
    fontSize: 10,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 10 / 10,
    letterSpacing: -0.24,
  );
}