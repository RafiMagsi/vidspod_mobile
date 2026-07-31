// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_generation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageGeneration _$ImageGenerationFromJson(Map<String, dynamic> json) =>
    _ImageGeneration(generationId: json['generationId'] as String);

Map<String, dynamic> _$ImageGenerationToJson(_ImageGeneration instance) =>
    <String, dynamic>{'generationId': instance.generationId};

_ImageGenerationStatus _$ImageGenerationStatusFromJson(
  Map<String, dynamic> json,
) => _ImageGenerationStatus(
  id: json['id'] as String,
  status: json['status'] as String,
  resultUrls: (json['resultUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  resultPaths: (json['resultPaths'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  projectId: json['projectId'] as String?,
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$ImageGenerationStatusToJson(
  _ImageGenerationStatus instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'resultUrls': instance.resultUrls,
  'resultPaths': instance.resultPaths,
  'projectId': instance.projectId,
  'errorMessage': instance.errorMessage,
};
