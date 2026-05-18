import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryBlue = Color(0xFF1e3a8a); // Azul escuro
  static const Color accentOrange = Color(0xFFF59E0B); // Laranja
  static const Color lightBlue = Color(0xFF3b82f6); // Azul claro
  static const Color darkGrey = Color(0xFF1f2937);
  static const Color lightGrey = Color(0xFFF3F4F6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: white,
      
      // Text Theme
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkGrey,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkGrey,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkGrey,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: darkGrey,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: Color(0xFF6B7280),
        ),
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: white,
        ),
      ),
      
      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentOrange,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: GoogleFonts.inter(
          color: Color(0xFF9CA3AF),
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: white,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: lightGrey,
        selectedColor: accentOrange,
        labelStyle: GoogleFonts.inter(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: primaryBlue,
        secondary: accentOrange,
        surface: white,
        error: error,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: darkGrey,
      
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: white,
        elevation: 0,
      ),
      
      colorScheme: ColorScheme.dark(
        primary: primaryBlue,
        secondary: accentOrange,
        surface: darkGrey,
        error: error,
      ),
    );
  }
}
