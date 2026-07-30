import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/errors/api_error.dart';
import 'package:vidspod_mobile/features/dashboard/domain/dashboard_summary.dart';
import 'package:vidspod_mobile/features/dashboard/domain/recent_generation.dart';

class DashboardRepository {
  final ApiClient _apiClient;

  DashboardRepository(this._apiClient);

  Future<DashboardSummary> getDashboardSummary() async {
    try {
      final response = await _apiClient.dio.get('/dashboard/summary');
      return DashboardSummary.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<List<RecentGeneration>> getRecentGenerations() async {
    try {
      final response = await _apiClient.dio.get(
        '/dashboard/recent-generations',
      );
      final data = response.data as List;
      return data.map((item) => RecentGeneration.fromJson(item)).toList();
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }
}
