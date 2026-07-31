import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/tools/domain/voice.dart';

/// Voice Studio per docs/MOBILE_APP_GUIDE.md §5.8.
///
/// `GET /voices` (✅) returns the TTS catalog; `GET/POST /voices/settings`
/// (✅) read/write per-user TTS defaults. Clones/preview are 🔴 and not
/// wired yet.
class VoiceStudioRepository {
  final ApiClient _apiClient;

  VoiceStudioRepository(this._apiClient);

  /// `GET /voices` — the TTS catalog.
  Future<List<Voice>> getVoices() async {
    try {
      return await _apiClient.getList(
        Endpoints.voices,
        decoder: Voice.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// `GET /voices/settings` — per-user TTS defaults.
  Future<Map<String, dynamic>> getSettings() async {
    try {
      return await _apiClient.getObject(
        Endpoints.voiceSettings,
        decoder: (json) => json,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// `POST /voices/settings` — persist per-user TTS defaults.
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    try {
      await _apiClient.postObject(
        Endpoints.voiceSettings,
        data: settings,
        decoder: (_) => const {},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
