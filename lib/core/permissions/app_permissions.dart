import 'package:permission_handler/permission_handler.dart';

/// Point-of-use permission helpers per docs/MOBILE_APP_GUIDE.md §10.
///
/// Each permission is asked at the point of use, never on launch.
abstract final class AppPermissions {
  static Future<bool> camera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> photos() async {
    // On iOS this maps to the photo library; on Android the relevant media
    // permission. gal handles saving; we gate reading the library here.
    final status = await Permission.photos.request();
    if (status.isGranted || status.isLimited) return true;
    return Permission.storage.isGranted;
  }

  static Future<bool> microphone() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  static Future<bool> notifications() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }
}
