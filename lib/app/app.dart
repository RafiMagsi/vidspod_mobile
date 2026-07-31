import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/router.dart';
import 'package:vidspod_mobile/core/theme/theme_providers.dart';

class VidsPodApp extends ConsumerWidget {
  const VidsPodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(vrThemeProvider);

    return MaterialApp.router(
      title: 'VidsPod',
      themeMode: theme.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: theme,
      theme: theme,
      routerConfig: router,
    );
  }
}
