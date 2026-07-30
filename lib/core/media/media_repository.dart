import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/errors/api_error.dart';

class MediaRepository {
  final ApiClient _apiClient;

  MediaRepository(this._apiClient);

  Future<String> getPresignedUrl(String fileName) async {
    try {
      final response = await _apiClient.dio.post(
        '/uploads/presign',
        data: {'file_name': fileName},
      );
      return response.data['url'];
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<void> confirmUpload(String uploadId) async {
    try {
      await _apiClient.dio.post(
        '/uploads/confirm',
        data: {'upload_id': uploadId},
      );
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }
}
