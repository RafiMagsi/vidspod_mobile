import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/errors/api_error.dart';
import 'package:vidspod_mobile/features/motions/domain/motion.dart';

class MotionRepository {
  final ApiClient _apiClient;

  MotionRepository(this._apiClient);

  Future<List<Motion>> getMotions() async {
    try {
      final response = await _apiClient.dio.get('/motions');
      final data = response.data as List;
      return data.map((item) => Motion.fromJson(item)).toList();
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<Motion> getMotionDetails(String publicGuid) async {
    try {
      final response = await _apiClient.dio.get('/motions/$publicGuid');
      return Motion.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }
}
