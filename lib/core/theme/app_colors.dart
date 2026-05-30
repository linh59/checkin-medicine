import 'package:flutter/material.dart';

class WellnessColors {
  WellnessColors._();

  // =========================================================
  // BRAND
  // =========================================================

  static const Color primary = Color(0xFF2A9D8F);

  static const Color secondary = Color(0xFF4DA3FF);

  static const Color success = Color(0xFF22C55E);

  // =========================================================
  // LIGHT
  // =========================================================

  static const Color backgroundLight = Color(0xFFF6FAF9);

  static const Color surfaceLight = Colors.white;

  static const Color surfaceVariantLight = Color(0xFFF0F7F6);

  // =========================================================
  // DARK
  // =========================================================

  static const Color backgroundDark = Color(0xFF0F172A);

  static const Color surfaceDark = Color(0xFF162235);

  static const Color surfaceVariantDark = Color(0xFF1E293B);

  // =========================================================
  // TEXT
  // =========================================================

  static const Color textDark = Color(0xFF0F172A);

  static const Color textMutedDark = Color(0xFF64748B);

  static const Color textLight = Color(0xFFF8FAFC);

  static const Color textMutedLight = Color(0xFF94A3B8);

  // =========================================================
  // BORDER
  // =========================================================

  static const Color border = Color(0xFFE2E8F0);

  static const Color divider = Color(0xFFF1F5F9);

  // =========================================================
  // STATUS
  // =========================================================

  static const Color error = Color(0xFFEF4444);

  static const Color warning = Color(0xFFF59E0B);

  static const Color info = Color(0xFF3B82F6);

  // =========================================================
  // SHADOW
  // =========================================================

  static const Color shadow = Color(0x14000000);

  // =========================================================
  // DYNAMIC COLORS (FIX DARK MODE)
  // =========================================================

  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? backgroundDark
        : backgroundLight;
  }

  static Color surface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceDark
        : surfaceLight;
  }

  static Color surfaceVariant(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceVariantDark
        : surfaceVariantLight;
  }

  static Color textSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textMutedLight
        : textMutedDark;
  }

  static Color textPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textLight
        : textDark;
  }
}
