import 'package:flutter/material.dart';

class CreatiTheme {
  static ThemeData darkTheme() {
    final darkTheme = ThemeData.dark();
    final colorScheme = darkTheme.colorScheme.copyWith(
      primary: const Color(0xFF8A2387),
      secondary: const Color(0xFFE94057),
      background: Colors.black,
      surface: Colors.grey[900],
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
    );

    return darkTheme.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: colorScheme.onBackground),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}
