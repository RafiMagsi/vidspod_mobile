import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/errors/api_error.dart';
import 'package:vidspod_mobile/features/research/domain/research_run.dart';
import 'package:vidspod_mobile/features/research/domain/research_result.dart';

class ResearchRepository {
  final ApiClient _apiClient;

  ResearchRepository(this._apiClient);

  Future<List<ResearchRun>> getResearchRuns() async {
    try {
      final response = await _apiClient.dio.get('/research/runs');
      final data = response.data as List;
      return data.map((item) => ResearchRun.fromJson(item)).toList();
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<ResearchRun> createResearchRun(String topic) async {
    try {
      final response = await _apiClient.dio.post(
        '/research/runs',
        data: {'topic': topic},
      );
      return ResearchRun.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<ResearchRun> getResearchRun(String id) async {
    try {
      final response = await _apiClient.dio.get('/research/runs/$id');
      return ResearchRun.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<List<ResearchResult>> getResearchRunResults(String id) async {
    try {
      final response = await _apiClient.dio.get('/research/runs/$id/results');
      final data = response.data as List;
      return data.map((item) => ResearchResult.fromJson(item)).toList();
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }
}
