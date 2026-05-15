import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeeqatColors {
  // Deep Spiritual Palette
  static const Color midnightBlue = Color(0xFF0A192F); // Background
  static const Color spiritualGold = Color(0xFFD4AF37); // Accents/Highlights
  static const Color softEmerald = Color(0xFF2D5A27); // Growth/Peace
  static const Color cloudWhite = Color(0xFFF5F5F5); // Text/Contrast
  static const Color mutedSlate = Color(0xFF4A5568); // Secondary text
  static const Color accentAmber = Color(0xFFFFBF00); // Important alerts
}

class MeeqatTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: MeeqatColors.spiritualGold,
      scaffoldBackgroundColor: MeeqatColors.midnightBlue,
      textTheme: GoogleFonts.amiriTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: MeeqatColors.cloudWhite,
        displayColor: MeeqatColors.spiritualGold,
      ),
      colorScheme: const ColorScheme.dark(
        primary: MeeqatColors.spiritualGold,
        secondary: MeeqatColors.softEmerald,
        surface: MeeqatColors.midnightBlue,
      ),
    );
  }
}
