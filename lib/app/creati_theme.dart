import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatiTheme {
  // Brand colors
  static const Color purple = Color(0xFF8A2387);
  static const Color pink = Color(0xFFE94057);
  static const Color orange = Color(0xFFF27121);
  static const Color blue = Color(0xFF4A90E2);
  static const Color deepPurple = Color(0xFF8E44AD);

  // Neutrals
  static const Color black = Color(0xFF000000);
  static const Color nearBlack = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1B1B1B);
  static const Color mediumSurface = Color(0xFF262626);
  static const Color lightSurface = Color(0xFF2A2A2E);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color cardBorder = Color(0xFF2C2C2E);

  // Accent
  static const Color green = Color(0xFF34C759);
  static const Color amber = Color(0xFFFFD60A);

  // Radius
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 14;
  static const double radiusXl = 20;
  static const double radiusFull = 100;

  // Letter spacing
  static const double letterSpacingTight = -0.3;
  static const double letterSpacingBody = 0.15;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingLabel = 0.8;

  // Gradients
  static const LinearGradient brandGradient = LinearGradient(
    colors: [purple, pink, orange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient proGradient = LinearGradient(
    colors: [blue, deepPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static List<BoxShadow> cardShadow(Color color) => [
    BoxShadow(
      color: color.withAlpha(25),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: color.withAlpha(10),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> buttonShadow(Color color) => [
    BoxShadow(
      color: color.withAlpha(60),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
    BoxShadow(
      color: color.withAlpha(20),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];

  // Typography helpers
  static TextStyle displayLarge({
    Color color = Colors.white,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) => GoogleFonts.inter(
    fontSize: fontSize ?? 34,
    fontWeight: fontWeight ?? FontWeight.w800,
    color: color,
    letterSpacing: letterSpacing ?? letterSpacingTight,
    height: height ?? 1.1,
  );

  static TextStyle headingLarge({
    Color color = Colors.white,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) => GoogleFonts.inter(
    fontSize: fontSize ?? 24,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color,
    letterSpacing: letterSpacing ?? letterSpacingTight,
    height: height ?? 1.2,
  );

  static TextStyle headingMedium({
    Color color = Colors.white,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) => GoogleFonts.inter(
    fontSize: fontSize ?? 19,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color,
    letterSpacing: letterSpacing ?? letterSpacingTight,
    height: height ?? 1.3,
  );

  static TextStyle headingSmall({
    Color color = Colors.white,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) => GoogleFonts.inter(
    fontSize: fontSize ?? 17,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color,
    letterSpacing: letterSpacing ?? letterSpacingBody,
    height: height ?? 1.3,
  );

  static TextStyle bodyMedium({
    Color color = Colors.white,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) => GoogleFonts.inter(
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color,
    letterSpacing: letterSpacing ?? letterSpacingBody,
    height: height ?? 1.5,
  );

  static TextStyle bodySmall({
    Color color = Colors.white,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) => GoogleFonts.inter(
    fontSize: fontSize ?? 13,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color,
    letterSpacing: letterSpacing ?? letterSpacingBody,
    height: height ?? 1.4,
  );

  static TextStyle caption({
    Color color = Colors.white,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) => GoogleFonts.inter(
    fontSize: fontSize ?? 12,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color,
    letterSpacing: letterSpacing ?? letterSpacingBody,
    height: height ?? 1.3,
  );

  static TextStyle label({
    Color color = Colors.white,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) => GoogleFonts.inter(
    fontSize: fontSize ?? 11,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color,
    letterSpacing: letterSpacing ?? letterSpacingLabel,
    height: height ?? 1.2,
  );

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: black,
      colorScheme: const ColorScheme.dark(
        primary: purple,
        secondary: pink,
        surface: darkSurface,
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(bodyColor: Colors.white, displayColor: Colors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: black,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: headingSmall(),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: nearBlack,
        selectedItemColor: Colors.white,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacingLabel,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          letterSpacing: letterSpacingLabel / 2,
        ),
      ),
      dividerColor: mediumSurface,
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
      ),
    );
  }
}
