import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:vidspod_mobile/firebase_options.dart';

/// App bootstrap per docs/MOBILE_APP_GUIDE.md §6 — env, error reporting, and
/// optional third-party init (Firebase/push).
///
/// Kept out of the widget tree: providers are wired by riverpod providers
/// (DI), environment lives in [Config], and native init here so `main` stays
/// a thin entry point.
abstract final class VidsPodBootstrap {
  /// Runs before `runApp`. Currently initializes Firebase (optional) and
  /// installs global error reporting. Fails silently: a missing native config
  /// must never prevent rendering the app shell.
  static Future<void> init() async {
    _installErrorReporting();
    await _initializeFirebase();
  }

  static void _installErrorReporting() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      _report(
        'flutter',
        details.exceptionAsString(),
        details.stack?.toString(),
      );
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      _report('platform', error.toString(), stack.toString());
      return true;
    };
  }

  static void _report(String origin, String message, String? stack) {
    debugPrint('[VidsPod:$origin] $message');
    if (stack != null) debugPrint(stack);
  }

  static Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // Forward completion notifications for long-running generation runs (§9).
      FirebaseMessaging.onMessage.listen((message) {
        debugPrint('Received foreground message: ${message.data}');
      });
    } on Object catch (error) {
      debugPrint('Firebase initialization skipped: $error');
    }
  }
}
