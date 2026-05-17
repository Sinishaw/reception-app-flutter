import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF0D7C66); // deep teal
  static const surface = Color(0xFFE1F5EE);
  static const accent = Color(0xFFEF9F27); // amber
  static const background = Color(0xFFFAFAFA);
  static const card = Color(0xFFFFFFFF);
  static const text = Color(0xFF251913);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Tablet-specific theme overrides (kiosk feel)
  static ThemeData get tablet {
    final base = light;
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          fontSize: 18,
          color: AppColors.text,
        ),
      ),
    );
  }
}

const kUseMockFirestore = false; // Toggle for mock mode
