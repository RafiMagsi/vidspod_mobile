import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';

/// Device / push registration per docs/MOBILE_APP_GUIDE.md §9.
class DevicesRepository {
  final ApiClient _apiClient;

  DevicesRepository(this._apiClient);

  Future<void> register({
    required String token,
    required String platform,
    required String appVersion,
  }) async {
    try {
      await _apiClient.postObject(
        Endpoints.registerDevice,
        data: {'token': token, 'platform': platform, 'app_version': appVersion},
        decoder: (_) => const {},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> unregister(String token) async {
    try {
      await _apiClient.delete(Endpoints.deviceWithToken(token));
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
