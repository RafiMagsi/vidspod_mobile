import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/storage/storage_providers.dart';
import 'package:vidspod_mobile/core/storage/secure_storage_repository.dart';

/// Thin, key-scoped wrapper over secure storage for auth tokens.
///
/// Per docs/MOBILE_APP_GUIDE.md §4, tokens live in `flutter_secure_storage`.
/// One `sessions` row per device is a backend concern; mobile only needs the
/// access/refresh pair plus the optional device name we send on login.
class TokenStore {
  static const String _accessKey = 'access_token';
  static const String _refreshKey = 'refresh_token';
  static const String _deviceNameKey = 'device_name';

  final SecureStorageRepository _storage;

  TokenStore(this._storage);

  Future<String?> readAccessToken() => _storage.read(key: _accessKey);

  Future<String?> readRefreshToken() => _storage.read(key: _refreshKey);

  Future<void> writeTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: _accessKey, value: access);
    await _storage.write(key: _refreshKey, value: refresh);
  }

  Future<void> writeAccessToken(String access) =>
      _storage.write(key: _accessKey, value: access);

  Future<String?> readDeviceName() => _storage.read(key: _deviceNameKey);

  Future<void> writeDeviceName(String name) =>
      _storage.write(key: _deviceNameKey, value: name);

  Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
    await _storage.delete(key: _deviceNameKey);
  }
}

final tokenStoreProvider = Provider<TokenStore>((ref) {
  return TokenStore(ref.watch(secureStorageRepositoryProvider));
});
