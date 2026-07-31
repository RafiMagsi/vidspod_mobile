import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/core/api/page.dart';
import 'package:vidspod_mobile/core/models/short_run.dart';

/// My Shorts run monitoring per docs/MOBILE_APP_GUIDE.md §5.3.
class MyShortsRepository {
  final ApiClient _apiClient;

  MyShortsRepository(this._apiClient);

  /// List runs. `status` is a server filter value, not rendered text.
  /// Page-number pagination (§3.2): `data.items[]` + `data.pagination.page`.
  Future<Page<ShortRun>> getRuns({
    int page = 1,
    int perPage = 20,
    String? status,
  }) async {
    try {
      return await _apiClient.getPage(
        Endpoints.myShorts,
        decoder: ShortRun.fromJson,
        queryParameters: {'page': page, 'per_page': perPage, 'status': ?status},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Get a single run (used for progress polling, see §9).
  Future<ShortRun> getRun(String runId) async {
    try {
      return await _apiClient.getObject(
        Endpoints.myShortRunWith(runId),
        decoder: ShortRun.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> retry(String runId) async {
    try {
      await _apiClient.postObject(
        Endpoints.retryRunWith(runId),
        decoder: (_) => const {},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> cancel(String runId) async {
    try {
      await _apiClient.postObject(
        Endpoints.cancelRunWith(runId),
        decoder: (_) => const {},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> deleteMedia(String runId) async {
    try {
      await _apiClient.delete(Endpoints.deleteRunMediaWith(runId));
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
