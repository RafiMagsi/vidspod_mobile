import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:vidspod_mobile/app/app.dart';
import 'package:vidspod_mobile/app/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFF121212),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const ProviderScope(child: VidsPodApp()));

  // Optional third-party init (Firebase/push) + global error reporting. Runs
  // unawaited so a slow native init never blocks first paint.
  unawaited(VidsPodBootstrap.init());
}
