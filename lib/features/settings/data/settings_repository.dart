import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/settings/domain/settings.dart';

class SettingsRepository {
  final ApiClient _apiClient;

  SettingsRepository(this._apiClient);

  Future<AppSettings> getSettings() async {
    try {
      return await _apiClient.getObject(
        Endpoints.meSettings,
        decoder: AppSettings.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<AppSettings> updateSettings(AppSettings settings) async {
    try {
      return await _apiClient.patchObject(
        Endpoints.meSettings,
        data: settings.toJson(),
        decoder: AppSettings.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
