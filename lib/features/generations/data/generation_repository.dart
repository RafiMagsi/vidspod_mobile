import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/generations/domain/generation.dart';

/// Generation runs. All calls go through the typed envelope helpers (§3.1)
/// so error paths are uniform ([ApiException] via [mapDioException]).
class GenerationRepository {
  final ApiClient _apiClient;

  GenerationRepository(this._apiClient);

  Future<Generation> createGeneration({
    required String motionId,
    required String uploadId,
  }) async {
    try {
      return await _apiClient.postObject(
        Endpoints.generations,
        data: {'motion_id': motionId, 'upload_id': uploadId},
        decoder: Generation.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Generation> getGeneration(String id) async {
    try {
      return await _apiClient.getObject(
        Endpoints.generationWith(id),
        decoder: Generation.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<Generation>> getGenerations() async {
    try {
      return await _apiClient.getList(
        Endpoints.generations,
        decoder: Generation.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
