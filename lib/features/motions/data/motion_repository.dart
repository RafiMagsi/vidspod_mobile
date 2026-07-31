import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/motions/domain/motion.dart';

/// Motions catalog per docs/MOBILE_APP_GUIDE.md §5.12. Envelope-typed calls.
class MotionRepository {
  final ApiClient _apiClient;

  MotionRepository(this._apiClient);

  Future<List<Motion>> getMotions() async {
    try {
      return await _apiClient.getList(
        Endpoints.motions,
        decoder: Motion.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Motion> getMotionDetails(String publicGuid) async {
    try {
      return await _apiClient.getObject(
        Endpoints.motionWith(publicGuid),
        decoder: Motion.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
