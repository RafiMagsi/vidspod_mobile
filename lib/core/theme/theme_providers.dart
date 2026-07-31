import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/features/settings/settings_providers.dart';

/// Resolves the active [VrPalette] from `GET /settings/theme` per
/// docs/MOBILE_APP_GUIDE.md §11. Defaults to `venture` while loading.
final vrPaletteProvider = Provider<VrPalette>((ref) {
  final settings = ref.watch(settingsProvider).valueOrNull;
  return VrTheme.forMode(settings?.theme ?? 'venture');
});

/// ThemeData derived from the active palette. The app honours the account's
/// stored theme choice (light / venture / ventura2).
final vrThemeProvider = Provider<ThemeData>((ref) {
  final palette = ref.watch(vrPaletteProvider);
  return VrTheme.themeFor(palette);
});
