import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/tools/domain/image_generation.dart';

/// Image Generator per docs/MOBILE_APP_GUIDE.md §5.4.
///
/// Modes: `image_to_image` (Reference Edit) or `improve`. Multipart body:
/// `mode`, `prompt` (required unless improve), `model`, `size`, `source_image`
/// (≤10 MB), `variation_count` (1–4, forced to 1 for improve).
class ImageGeneratorRepository {
  final ApiClient _apiClient;

  ImageGeneratorRepository(this._apiClient);

  Future<ImageGeneration> generate({
    required String mode,
    required FormData formData,
  }) async {
    try {
      return await _apiClient.postObject(
        Endpoints.imageGenerator,
        data: formData,
        decoder: ImageGeneration.fromJson,
        options: Options(contentType: 'multipart/form-data'),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ImageGenerationStatus> getStatus(String id) async {
    try {
      return await _apiClient.getObject(
        Endpoints.imageGeneratorStatusWith(id),
        decoder: ImageGenerationStatus.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Attach generated outputs to a project's media library.
  Future<void> attachToProject(String id, String projectId) async {
    try {
      await _apiClient.postObject(
        Endpoints.imageGeneratorMediaAssetsWith(id),
        data: {'project_id': projectId},
        decoder: (_) => const {},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
