import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemePremium {
  // Colors
  static const Color primaryNavy = Color(0xFF001F5C);
  static const Color primaryNavyLight = Color(0xFF0A3A7F);
  static const Color primaryNavyDark = Color(0xFF001A47);
  
  static const Color accentOrange = Color(0xFFFFA500);
  static const Color accentOrangeLight = Color(0xFFFFB84D);
  static const Color accentOrangeDark = Color(0xFFE69500);
  
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color dividerColor = Color(0xFFF3F4F6);
  
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);
  
  // Gradients
  static const LinearGradient gradientPrimaryOrange = LinearGradient(
    colors: [primaryNavy, accentOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient gradientOrangePrimary = LinearGradient(
    colors: [accentOrange, primaryNavy],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient gradientNavyLight = LinearGradient(
    colors: [primaryNavy, primaryNavyLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient gradientSurface = LinearGradient(
    colors: [Color(0xFFF9FAFB), Color(0xFFF3F4F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadows
  static const List<BoxShadow> shadowElevation1 = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
  
  static const List<BoxShadow> shadowElevation2 = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
  
  static const List<BoxShadow> shadowElevation3 = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  static const List<BoxShadow> shadowElevation4 = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];
  
  static const List<BoxShadow> shadowGlowOrange = [
    BoxShadow(
      color: Color(0x40FFA500),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
  
  static const List<BoxShadow> shadowGlowNavy = [
    BoxShadow(
      color: Color(0x40001F5C),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
  
  // Text Styles
  static TextStyle headingXL = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: primaryNavy,
    height: 1.2,
  );
  
  static TextStyle headingLarge = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: primaryNavy,
    height: 1.2,
  );
  
  static TextStyle headingMedium = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryNavy,
    height: 1.3,
  );
  
  static TextStyle headingSmall = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: primaryNavy,
    height: 1.3,
  );
  
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    height: 1.5,
  );
  
  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    height: 1.5,
  );
  
  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.5,
  );
  
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );
  
  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: textSecondary,
    height: 1.4,
  );
  
  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryNavy,
      scaffoldBackgroundColor: surfaceLight,
      
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: primaryNavy,
        secondary: accentOrange,
        surface: surfaceCard,
        error: errorColor,
        outline: borderColor,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: surfaceCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Color(0x0F000000),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentOrange,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: Color(0x40FFA500),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryNavy,
          side: BorderSide(color: primaryNavy, width: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentOrange,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentOrange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: errorColor, width: 2),
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: textTertiary,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
      ),
      
      // Bottom Navigation Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceCard,
        selectedItemColor: accentOrange,
        unselectedItemColor: textTertiary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        shadowColor: Color(0x1A000000),
      ),
      
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 16,
      ),
    );
  }
}
