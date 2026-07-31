import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/core/auth/token_store.dart';
import 'package:vidspod_mobile/features/auth/domain/user_session.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final TokenStore _tokenStore;

  AuthRepository(this._apiClient, this._tokenStore);

  Future<void> register(String email, String password) async {
    try {
      await _apiClient.postObject(
        Endpoints.register,
        data: {'email': email, 'password': password},
        decoder: (_) => const {},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Mobile login per §4: `{email, password, device_name, platform}` →
  /// `{access_token, refresh_token, expires_in, user}`.
  Future<UserSession> login(
    String email,
    String password, {
    String deviceName = 'mobile',
    String platform = 'mobile',
  }) async {
    try {
      final tokens = await _apiClient.postObject(
        Endpoints.mobileLogin,
        data: {
          'email': email,
          'password': password,
          'device_name': deviceName,
          'platform': platform,
        },
        decoder: UserSession.fromJson,
      );
      await _tokenStore.writeTokens(
        access: tokens.accessToken,
        refresh: tokens.refreshToken,
      );
      await _tokenStore.writeDeviceName(deviceName);
      return tokens;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> logout() async {
    final refreshToken = await _tokenStore.readRefreshToken();
    try {
      if (refreshToken != null) {
        await _apiClient.postObject(
          Endpoints.mobileLogout,
          data: {'refresh_token': refreshToken},
          decoder: (_) => const {},
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode != 401) {
        throw mapDioException(e);
      }
    } finally {
      await _tokenStore.clear();
    }
  }

  Future<String?> getAccessToken() => _tokenStore.readAccessToken();
}
