import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1976D2),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFBBDEFB),
    onSecondary: Color(0xFF000000),
    error: Color(0xFFD32F2F),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    tertiary: Color(0xFFFF9800),
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF1976D2),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFBBDEFB),
    onSecondary: Color(0xFF000000),
    error: Color(0xFFD32F2F),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFFFFFFF),
    tertiary: Color(0xFFFF9800),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: GoogleFonts.latoTextTheme(
        ThemeData(brightness: Brightness.light).textTheme,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      textTheme: GoogleFonts.latoTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
