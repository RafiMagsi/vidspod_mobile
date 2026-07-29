import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/errors/api_error.dart';
import 'package:vidspod_mobile/features/generations/domain/generation.dart';

class GenerationRepository {
  final ApiClient _apiClient;

  GenerationRepository(this._apiClient);

  Future<Generation> createGeneration({
    required String motionId,
    required String uploadId,
  }) async {
    try {
      final response = await _apiClient.dio.post('/generations', data: {
        'motion_id': motionId,
        'upload_id': uploadId,
      });
      return Generation.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<Generation> getGeneration(String id) async {
    try {
      final response = await _apiClient.dio.get('/generations/$id');
      return Generation.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<List<Generation>> getGenerations() async {
    try {
      final response = await _apiClient.dio.get('/generations');
      final data = response.data as List;
      return data.map((item) => Generation.fromJson(item)).toList();
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }
}
