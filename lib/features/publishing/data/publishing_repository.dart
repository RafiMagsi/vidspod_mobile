import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';

/// Publishing per docs/MOBILE_APP_GUIDE.md §5.11.
///
/// Mobile: review a scheduled post, approve or cancel, reschedule. Actual OAuth
/// connection flows stay on web in v1.
class PublishingRepository {
  final ApiClient _apiClient;

  PublishingRepository(this._apiClient);

  /// `{queue[], connected_accounts[]}`.
  Future<Map<String, dynamic>> getPublishing() async {
    try {
      return await _apiClient.getObject(
        Endpoints.publishing,
        decoder: (json) => json,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Approve or cancel a scheduled post: `/publishing/{id}/{action}`.
  Future<void> action(String id, String action) async {
    try {
      await _apiClient.postObject(
        Endpoints.publishingActionWith(id, action),
        decoder: (_) => const {},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> schedule(Map<String, dynamic> payload) async {
    try {
      await _apiClient.postObject(
        Endpoints.publishingSchedule,
        data: payload,
        decoder: (_) => const {},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
