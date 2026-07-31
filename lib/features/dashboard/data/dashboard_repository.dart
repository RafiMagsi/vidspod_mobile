import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/dashboard/domain/dashboard_summary.dart';
import 'package:vidspod_mobile/features/dashboard/domain/recent_generation.dart';

/// Home dashboard per docs/MOBILE_APP_GUIDE.md §5.1. Envelope-typed calls.
class DashboardRepository {
  final ApiClient _apiClient;

  DashboardRepository(this._apiClient);

  Future<DashboardSummary> getDashboardSummary() async {
    try {
      return await _apiClient.getObject(
        Endpoints.dashboard,
        decoder: DashboardSummary.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<RecentGeneration>> getRecentGenerations() async {
    try {
      return await _apiClient.getList(
        Endpoints.dashboardRecent,
        decoder: RecentGeneration.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
