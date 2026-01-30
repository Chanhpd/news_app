import 'package:flutter/material.dart';

class AppColors {
  // ============ PRIMARY COLORS ============
  // Light Theme - Emerald Green
  static const Color primaryLight = Color(0xFF10B981); // Emerald 500
  static const Color primaryLightVariant = Color(0xFF059669); // Emerald 600
  static const Color onPrimaryLight = Color(0xFFFFFFFF);

  // Dark Theme - Lighter Emerald
  static const Color primaryDark = Color(0xFF34D399); // Emerald 400
  static const Color primaryDarkVariant = Color(0xFF10B981); // Emerald 500
  static const Color onPrimaryDark = Color(0xFF000000);

  // ============ SECONDARY COLORS ============
  // Accent - Teal
  static const Color secondaryLight = Color(0xFF14B8A6); // Teal 500
  static const Color secondaryLightVariant = Color(0xFF0D9488); // Teal 600
  static const Color onSecondaryLight = Color(0xFFFFFFFF);

  static const Color secondaryDark = Color(0xFF2DD4BF); // Teal 400
  static const Color secondaryDarkVariant = Color(0xFF14B8A6); // Teal 500
  static const Color onSecondaryDark = Color(0xFF000000);

  // ============ BACKGROUND COLORS ============
  // Light Theme
  static const Color backgroundLight = Color(
    0xFFF0FDF4,
  ); // Soft green-tinted white
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(
    0xFFECFDF5,
  ); // Very light green

  // Dark Theme
  static const Color backgroundDark = Color(0xFF0F1419); // Very dark blue-gray
  static const Color surfaceDark = Color(0xFF1A1F29); // Dark blue-gray
  static const Color surfaceVariantDark = Color(
    0xFF252B37,
  ); // Medium dark blue-gray

  // ============ TEXT COLORS ============
  // Light Theme
  static const Color textPrimaryLight = Color(
    0xFF1A202C,
  ); // Almost black with blue tint
  static const Color textSecondaryLight = Color(0xFF4A5568); // Medium gray
  static const Color textTertiaryLight = Color(0xFF718096); // Light gray

  // Dark Theme
  static const Color textPrimaryDark = Color(0xFFF7FAFC); // Almost white
  static const Color textSecondaryDark = Color(0xFFCBD5E0); // Light gray-blue
  static const Color textTertiaryDark = Color(0xFFA0AEC0); // Medium gray-blue

  // ============ SEMANTIC COLORS ============
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color errorDark = Color(0xFFF87171); // Red 400

  static const Color success = Color(0xFF84CC16); // Lime 500
  static const Color successDark = Color(0xFFA3E635); // Lime 400

  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningDark = Color(0xFFFBBF24); // Amber 400

  static const Color info = Color(0xFF3B82F6); // Blue 500
  static const Color infoDark = Color(0xFF60A5FA); // Blue 400

  // ============ CATEGORY COLORS ============
  // Vibrant colors for categories
  static const Color categoryGeneral = Color(0xFF8B5CF6); // Purple 500
  static const Color categoryBusiness = Color(0xFF10B981); // Green 500
  static const Color categoryTechnology = Color(0xFF3B82F6); // Blue 500
  static const Color categorySports = Color(0xFFEF4444); // Red 500
  static const Color categoryEntertainment = Color(0xFFEC4899); // Pink 500
  static const Color categoryHealth = Color(0xFF14B8A6); // Teal 500
  static const Color categoryScience = Color(0xFF06B6D4); // Cyan 500

  // ============ UI ELEMENTS ============
  // Dividers
  static const Color dividerLight = Color(0xFFE2E8F0); // Gray 200
  static const Color dividerDark = Color(0xFF2D3748); // Gray 700

  // Borders
  static const Color borderLight = Color(0xFFCBD5E0); // Gray 300
  static const Color borderDark = Color(0xFF4A5568); // Gray 600

  // Overlay
  static const Color overlayLight = Color(0x0D000000); // 5% black
  static const Color overlayDark = Color(0x1AFFFFFF); // 10% white

  // Shimmer effect colors
  static const Color shimmerBaseLight = Color(0xFFE2E8F0);
  static const Color shimmerHighlightLight = Color(0xFFF7FAFC);
  static const Color shimmerBaseDark = Color(0xFF2D3748);
  static const Color shimmerHighlightDark = Color(0xFF4A5568);

  // Card shadow colors
  static const Color shadowLight = Color(0x0A000000); // 4% black
  static const Color shadowDark = Color(0x14000000); // 8% black
  // ============ BACKWARD COMPATIBILITY ============
  // Getters for backward compatibility with old code
  static Color get primary => primaryLight;
  static Color get secondary => secondaryLight;
}
