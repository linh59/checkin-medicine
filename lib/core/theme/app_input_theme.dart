import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppInputTheme {
  static InputDecorationTheme get light => InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: WellnessColors.border),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: WellnessColors.border.withOpacity(0.6)),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: WellnessColors.primary, width: 1.5),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.redAccent),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),

    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  );

  static InputDecorationTheme get dark => InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: WellnessColors.border.withOpacity(0.4)),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: WellnessColors.border.withOpacity(0.3)),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: WellnessColors.primary, width: 1.5),
    ),

    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
    ),

    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),

    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  );
}
