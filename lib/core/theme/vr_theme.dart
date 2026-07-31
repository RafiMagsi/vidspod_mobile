import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens ported from `vidspod-js/frontend/apps/web/app/(app)/app.css`
/// per docs/MOBILE_APP_GUIDE.md §11.
///
/// Web and mobile share one vocabulary (`vrPrimary`, `vrSurface`, `vrText`,
/// `vrTextSoft`, `vrTextMuted`, `vrBorder`, ...). Radii are 8/10/14/18/22,
/// matching `--vr-radius-*`.
class VrTheme {
  // ── Brand accents & surface tones (mobile) ──────────────────────────────────
  static const Color purple = Color(0xFF8A2387);
  static const Color pink = Color(0xFFE94057);
  static const Color orange = Color(0xFFF27121);
  static const Color blue = Color(0xFF4A90E2);
  static const Color deepPurple = Color(0xFF8E44AD);

  static const Color black = Color(0xFF000000);
  static const Color nearBlack = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1B1B1B);
  static const Color mediumSurface = Color(0xFF262626);
  static const Color lightSurface = Color(0xFF2A2A2E);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color cardBorder = Color(0xFF2C2C2E);

  static const Color green = Color(0xFF34C759);
  static const Color amber = Color(0xFFFFD60A);

  // ── Letter spacing ──────────────────────────────────────────────────────────
  static const double letterSpacingTight = -0.3;
  static const double letterSpacingBody = 0.15;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingLabel = 0.8;

  // ── Gradients ───────────────────────────────────────────────────────────────
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

  // ── Shadows ─────────────────────────────────────────────────────────────────
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

  // ── Typography helpers ──────────────────────────────────────────────────────
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

  // ── Themes (§11) ────────────────────────────────────────────────────────────
  static const VrPalette light = VrPalette(
    name: 'light',
    primary: Color(0xFF6D5DF6),
    bg: Color(0xFFF5F7FD),
    surface: Color(0xFFFFFFFF),
    surfaceAlt: Color(0xFFEDF0F8),
    text: Color(0xFF12141C),
    textSoft: Color(0xFF3A3E4A),
    textMuted: Color(0xFF7A8090),
    border: Color(0xFFE2E6F0),
    positive: Color(0xFF1FBF75),
    negative: Color(0xFFE5484D),
    warning: Color(0xFFFFB224),
  );

  static const VrPalette venture = VrPalette(
    name: 'venture',
    primary: Color(0xFFE06036),
    bg: Color(0xFF090B11),
    surface: Color(0xFF13161E),
    surfaceAlt: Color(0xFF1C212C),
    text: Color(0xFFF5F6F8),
    textSoft: Color(0xFFC6CAD3),
    textMuted: Color(0xFF828A99),
    border: Color(0xFF262C38),
    positive: Color(0xFF2FBF77),
    negative: Color(0xFFE5484D),
    warning: Color(0xFFFFB224),
  );

  static const VrPalette ventura2 = VrPalette(
    name: 'ventura2',
    primary: Color(0xFFFF7A2F),
    bg: Color(0xFF05060B),
    surface: Color(0xFF0F1117),
    surfaceAlt: Color(0xFF181B24),
    text: Color(0xFFF5F6F8),
    textSoft: Color(0xFFC6CAD3),
    textMuted: Color(0xFF828A99),
    border: Color(0xFF22262F),
    positive: Color(0xFF2FBF77),
    negative: Color(0xFFE5484D),
    warning: Color(0xFFFFB224),
  );

  // ── Radii (§11): 8/10/14/18/22 ──────────────────────────────────────────────
  static const double radiusSm = 8;
  static const double radiusMd = 10;
  static const double radiusLg = 14;
  static const double radiusXl = 18;
  static const double radiusFull = 22;

  /// Resolves the palette for a stored theme mode (`GET /settings/theme`).
  static VrPalette forMode(String mode) {
    switch (mode) {
      case 'light':
        return light;
      case 'ventura2':
        return ventura2;
      case 'venture':
      case 'ventura1':
      case 'dark':
      default:
        return venture;
    }
  }

  /// ThemeData built from a palette. [brightness] is derived from [palette].
  static ThemeData themeFor(VrPalette palette, {bool? forceDark}) {
    final isDark = forceDark ?? palette.isDark;
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: palette.bg,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: palette.primary,
        onPrimary: Colors.white,
        secondary: palette.primary,
        onSecondary: Colors.white,
        surface: palette.surface,
        onSurface: palette.text,
        error: palette.negative,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: palette.text),
        titleTextStyle: TextStyle(
          color: palette.text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      dividerColor: palette.border,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: palette.text, fontSize: 16),
        bodyMedium: TextStyle(color: palette.textSoft, fontSize: 14),
        titleMedium: TextStyle(
          color: palette.text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          color: palette.primary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// A resolved design token set for one theme.
class VrPalette {
  final String name;
  final Color primary;
  final Color bg;
  final Color surface;
  final Color surfaceAlt;
  final Color text;
  final Color textSoft;
  final Color textMuted;
  final Color border;
  final Color positive;
  final Color negative;
  final Color warning;

  const VrPalette({
    required this.name,
    required this.primary,
    required this.bg,
    required this.surface,
    required this.surfaceAlt,
    required this.text,
    required this.textSoft,
    required this.textMuted,
    required this.border,
    required this.positive,
    required this.negative,
    required this.warning,
  });

  bool get isDark => bg.computeLuminance() < 0.3;
}
