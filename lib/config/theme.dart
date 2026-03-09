import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 앱 아이콘 컨셉 색상
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color secondaryPink = Color(0xFFFF4B8E);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentYellow = Color(0xFFF59E0B);
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF1C1C1C);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryPurple,
      secondary: secondaryPink,
      tertiary: accentBlue,
      surface: const Color(0xFFF5F5F5),
      error: const Color(0xFFB00020),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: primaryPurple.withAlpha(30),
      selectedColor: primaryPurple,
      labelStyle: const TextStyle(fontSize: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryPurple,
      foregroundColor: Colors.white,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.grey.shade700,
      secondary: Colors.grey.shade600,
      tertiary: Colors.grey.shade500,
      surface: darkSurface,
      error: const Color(0xFFCF6679),
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: darkBackground,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: darkSurface,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade800,
      selectedColor: Colors.grey.shade700,
      labelStyle: const TextStyle(fontSize: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey.shade700,
      foregroundColor: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white70,
      ),
    ),
  );

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 150);
  static const Duration mediumAnimation = Duration(milliseconds: 200);
  static const Duration longAnimation = Duration(milliseconds: 300);

  // Border Radius
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;
  static const double chipBorderRadius = 16.0;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;

  // Channel Card
  static const double channelThumbnailSize = 80.0;
  static const double channelCardHeight = 100.0;
}
