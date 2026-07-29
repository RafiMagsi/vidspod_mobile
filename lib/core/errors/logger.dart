import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(dynamic message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
