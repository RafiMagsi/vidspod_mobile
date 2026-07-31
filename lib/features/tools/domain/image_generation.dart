import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_generation.freezed.dart';
part 'image_generation.g.dart';

/// `POST /tools/image-generator` response per docs/MOBILE_APP_GUIDE.md §5.4.
@freezed
abstract class ImageGeneration with _$ImageGeneration {
  const factory ImageGeneration({required String generationId}) =
      _ImageGeneration;

  factory ImageGeneration.fromJson(Map<String, dynamic> json) =>
      ImageGeneration(generationId: json['generation_id'] as String? ?? '');
}

/// `GET /tools/image-generator/{id}/status` response.
@freezed
abstract class ImageGenerationStatus with _$ImageGenerationStatus {
  const factory ImageGenerationStatus({
    required String id,
    required String status,
    required List<String> resultUrls,
    required List<String> resultPaths,
    String? projectId,
    String? errorMessage,
  }) = _ImageGenerationStatus;

  factory ImageGenerationStatus.fromJson(Map<String, dynamic> json) =>
      _$ImageGenerationStatusFromJson(json);
}
