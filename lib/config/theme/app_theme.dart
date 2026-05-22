import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors - Turistar Premium
  static const Color primaryNavy = Color(0xFF001F5C); // Navy Turistar
  static const Color accentOrange = Color(0xFFFFA500); // Orange Turistar
  static const Color navyLight = Color(0xFF0A3A7A);
  static const Color orangeLight = Color(0xFFFFB84D);
  static const Color darkGrey = Color(0xFF1f2937);
  static const Color lightGrey = Color(0xFFF3F4F6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryNavy, navyLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentOrange, orangeLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryNavy,
      scaffoldBackgroundColor: white,
      
      // Text Theme
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryNavy,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryNavy,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryNavy,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryNavy,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: darkGrey,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: Color(0xFF6B7280),
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          color: Color(0xFF9CA3AF),
        ),
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: primaryNavy,
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
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryNavy,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryNavy,
          side: const BorderSide(color: primaryNavy, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentOrange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: GoogleFonts.inter(
          color: Color(0xFF9CA3AF),
          fontSize: 14,
        ),
        labelStyle: GoogleFonts.poppins(
          color: primaryNavy,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: white,
        shadowColor: primaryNavy.withOpacity(0.1),
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: lightGrey,
        selectedColor: accentOrange,
        labelStyle: GoogleFonts.inter(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Bottom Navigation Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: accentOrange,
        unselectedItemColor: Color(0xFF9CA3AF),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accentOrange,
        foregroundColor: white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: primaryNavy,
        secondary: accentOrange,
        surface: white,
        error: error,
        onPrimary: white,
        onSecondary: white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryNavy,
      scaffoldBackgroundColor: darkGrey,
      
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: white,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: white,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: primaryNavy,
        foregroundColor: white,
        elevation: 0,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentOrange,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF374151),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4B5563)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4B5563)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentOrange, width: 2),
        ),
      ),
      
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Color(0xFF2D3748),
      ),
      
      colorScheme: ColorScheme.dark(
        primary: primaryNavy,
        secondary: accentOrange,
        surface: Color(0xFF2D3748),
        error: error,
      ),
    );
  }
}
