import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/research/domain/research_run.dart';
import 'package:vidspod_mobile/features/research/domain/research_result.dart';

/// Research suite per docs/MOBILE_APP_GUIDE.md §5.9.
///
/// One backend today: `GET /content-research` (saved research, exports,
/// recent searches) and `POST /content-research/search` (run a query).
/// Per-tool endpoints are 🔴 — the eight tools share this search backend.
class ResearchRepository {
  final ApiClient _apiClient;

  ResearchRepository(this._apiClient);

  /// `GET /content-research` — saved research, exports, recent searches.
  Future<List<ResearchRun>> getResearchRuns() async {
    try {
      return await _apiClient.getList(
        Endpoints.contentResearch,
        decoder: ResearchRun.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// `POST /content-research/search` — run a research query for a tool.
  Future<ResearchRun> search({
    required String query,
    required String toolKey,
  }) async {
    try {
      return await _apiClient.postObject(
        Endpoints.contentResearchSearch,
        data: {'query': query, 'tool': toolKey},
        decoder: ResearchRun.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Single saved research run.
  Future<ResearchRun> getResearchRun(String id) async {
    try {
      return await _apiClient.getObject(
        Endpoints.contentResearchWith(id),
        decoder: ResearchRun.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Results for a saved run.
  Future<List<ResearchResult>> getResearchRunResults(String id) async {
    try {
      return await _apiClient.getList(
        Endpoints.contentResearchResultsWith(id),
        decoder: ResearchResult.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
