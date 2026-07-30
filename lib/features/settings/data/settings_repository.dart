import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/errors/api_error.dart';
import 'package:vidspod_mobile/features/settings/domain/settings.dart';

class SettingsRepository {
  final ApiClient _apiClient;

  SettingsRepository(this._apiClient);

  Future<AppSettings> getSettings() async {
    try {
      final response = await _apiClient.dio.get('/me/settings');
      return AppSettings.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<AppSettings> updateSettings(AppSettings settings) async {
    try {
      final response = await _apiClient.dio.patch(
        '/me/settings',
        data: settings.toJson(),
      );
      return AppSettings.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }
}
