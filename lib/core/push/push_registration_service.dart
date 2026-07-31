import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/push/devices_repository.dart';

final devicesRepositoryProvider = Provider<DevicesRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DevicesRepository(apiClient);
});

/// Registers the Firebase push token with the backend per §9 ("register a
/// device token, get a notification when a run completes or fails").
class PushRegistrationService {
  final DevicesRepository _repository;
  PushRegistrationService(this._repository);

  Future<void> registerIfAvailable() async {
    try {
      final messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();
      if (token == null) return;

      final packageInfo = await PackageInfo.fromPlatform();
      final platform = defaultTargetPlatform == TargetPlatform.android
          ? 'android'
          : defaultTargetPlatform == TargetPlatform.iOS
          ? 'ios'
          : 'unknown';

      await _repository.register(
        token: token,
        platform: platform,
        appVersion: packageInfo.version,
      );
    } on Object catch (error) {
      // Push registration is best-effort; never block startup on it.
      debugPrint('Push registration skipped: $error');
    }
  }
}
