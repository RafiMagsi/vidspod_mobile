import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class VidsPodApp extends ConsumerWidget {
  const VidsPodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'VidsPod',
      themeMode: ThemeMode.dark,
      darkTheme: CreatiTheme.darkTheme(),
      routerConfig: router,
    );
  }
}
