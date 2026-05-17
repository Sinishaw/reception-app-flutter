import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // The Architectural Concierge Design Tokens
  static const primary = Color(0xFFF47B20); // Warm Burnt Orange / Terracotta
  static const primaryContainer = Color(0xFFC45100); // Energetic dark burnt orange
  static const secondary = Color(0xFF0D1B3D); // Professional Deep Slate Blue
  static const tertiary = Color(0xFF005AB4); // Vibrant Architectural Blue
  
  // Surface Philosophy & Levels (Nesting Fine-Paper Sheets)
  static const background = Color(0xFFFFF8F6); // Base canvas
  static const surface = Color(0xFFFFF8F6);
  static const surfaceContainerLow = Color(0xFFFFF1EB); // Low priority cards/sections
  static const surfaceContainer = Color(0xFFFFEAE1); // Interactive cards/content blocks
  static const surfaceContainerHighest = Color(0xFFF5DED4); // Active/floating elements
  
  // Content / Typography Colors (No Pure Black!)
  static const onSurface = Color(0xFF251913); // Warm editorial text
  static const onPrimary = Color(0xFFFFFFFF);
  static const outlineVariant = Color(0xFFE0C0B2); // Soft shadow/hint border
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        tertiary: AppColors.tertiary,
        onTertiary: Colors.white,
        error: Color(0xFFBA1A1A),
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
      ),
      textTheme: GoogleFonts.manropeTextTheme().copyWith(
        displayLarge: GoogleFonts.manrope(
          letterSpacing: -0.02,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
        displayMedium: GoogleFonts.manrope(
          letterSpacing: -0.02,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
        headlineMedium: GoogleFonts.manrope(
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
        titleLarge: GoogleFonts.manrope(
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
        bodyLarge: GoogleFonts.manrope(
          color: AppColors.onSurface,
        ),
        bodyMedium: GoogleFonts.manrope(
          color: AppColors.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 'lg' roundedness
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // 'xl' roundedness
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
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          fontSize: 20,
          color: AppColors.onSurface,
        ),
      ),
    );
  }
}

const kUseMockFirestore = false; // Toggle for mock mode
