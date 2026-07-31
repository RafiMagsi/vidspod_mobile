import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/shorts_studio/domain/generate_hub.dart';

/// Shorts Studio / video studios per docs/MOBILE_APP_GUIDE.md §5.2/§5.5.
///
/// All studios share the same hub payload keyed by `flow_category`.
class ShortsStudioRepository {
  final ApiClient _apiClient;

  ShortsStudioRepository(this._apiClient);

  Future<GenerateHub> getHub({String flowCategory = 'short-studio'}) async {
    try {
      return await _apiClient.getObject(
        Endpoints.generateHub,
        decoder: GenerateHub.fromJson,
        queryParameters: {'flow_category': flowCategory},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
