import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/shorts_studio/domain/generate_hub.dart';

/// Shorts Studio / video studios per docs/MOBILE_APP_GUIDE.md §5.2/§5.5.
///
/// All studios share the same hub payload keyed by `flow_category`.
class ShortsStudioRepository {
  final ApiClient _apiClient;

  ShortsStudioRepository(this._apiClient);

  Future<GenerateHub> getHub({String flowCategory = 'short-studio'}) async {
    try {
      return await _apiClient.getObject(
        Endpoints.generateHub,
        decoder: GenerateHub.fromJson,
        queryParameters: {'flow_category': flowCategory},
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Submits a clone Motion to `POST /presets/generate` (§5.2).
  /// Returns the run id created server-side.
  Future<String> submitCloneMotion({
    required String presetKey,
    required File referenceImage,
    String? title,
  }) async {
    try {
      final formData = FormData.fromMap({
        'preset_key': presetKey,
        if (title != null && title.trim().isNotEmpty) 'title': title.trim(),
        'reference_image': await MultipartFile.fromFile(
          referenceImage.path,
          filename: referenceImage.path.split('/').last,
        ),
      });
      final result = await _apiClient.postObject(
        Endpoints.presetsGenerate,
        data: formData,
        decoder: (json) => json,
      );
      return (result['generation_run_id'] as String?) ?? '';
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Submits a standard Motion to `POST /projects` (§5.2/§5.5).
  /// Returns the run id created server-side.
  Future<String> submitStandardMotion({
    required String presetKey,
    required String presetLabel,
    required File referenceImage,
    String? prompt,
    String aspectRatio = '9:16',
  }) async {
    try {
      final formData = FormData.fromMap({
        'prompt': prompt ?? '',
        'format_preset': presetKey,
        'predefined_motion': presetLabel,
        'aspect_ratio': aspectRatio,
        'reference_image': await MultipartFile.fromFile(
          referenceImage.path,
          filename: referenceImage.path.split('/').last,
        ),
      });
      final result = await _apiClient.postObject(
        Endpoints.projects,
        data: formData,
        decoder: (json) => json,
      );
      final runId =
          (result['generation_run_id'] as String?) ??
          (result['id'] as String?) ??
          '';
      return runId;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
