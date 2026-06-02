import 'package:checkin_medicine/core/theme/app_input_theme.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,

    colorScheme: const ColorScheme.light(
      primary: WellnessColors.primary,
      secondary: WellnessColors.secondary,
      surface: WellnessColors.surfaceLight,
      error: WellnessColors.error,
    ),
    inputDecorationTheme: AppInputTheme.light,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: WellnessColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: WellnessColors.backgroundDark,

    colorScheme: const ColorScheme.dark(
      primary: WellnessColors.primary,
      secondary: WellnessColors.secondary,
      surface: WellnessColors.surfaceDark,
      error: WellnessColors.error,
    ),

    inputDecorationTheme: AppInputTheme.light,
  );
}
