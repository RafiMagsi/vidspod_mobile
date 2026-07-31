import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';

/// Script Writer per docs/MOBILE_APP_GUIDE.md §5.7.
///
/// `POST /generate/script` is a 🟡 placeholder today — it returns canned text,
/// not a real LLM call. Mobile still sends the full payload so the wiring is
/// correct when the backend grows.
class ScriptWriterRepository {
  final ApiClient _apiClient;

  ScriptWriterRepository(this._apiClient);

  /// `POST /generate/script` — `{prompt, template, tone, audience, length}`
  /// → `{script}` (canned text today).
  Future<String> generateScript({
    required String prompt,
    String template = 'youtube_script',
    String tone = 'professional',
    String audience = 'general',
    String length = '3min',
  }) async {
    try {
      final result = await _apiClient.postObject(
        Endpoints.generateScript,
        data: {
          'prompt': prompt,
          'template': template,
          'tone': tone,
          'audience': audience,
          'length': length,
        },
        decoder: (json) => json,
      );
      return (result['script'] as String?) ??
          (result['content'] as String?) ??
          '';
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
