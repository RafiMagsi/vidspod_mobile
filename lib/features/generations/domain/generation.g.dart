// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Generation _$GenerationFromJson(Map<String, dynamic> json) => _Generation(
  id: json['id'] as String,
  status: json['status'] as String,
  reservedCredits: (json['reservedCredits'] as num).toInt(),
  workflowType: json['workflowType'] as String,
  progress: json['progress'] as Map<String, dynamic>,
  videoUrl: json['videoUrl'] as String?,
);

Map<String, dynamic> _$GenerationToJson(_Generation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'reservedCredits': instance.reservedCredits,
      'workflowType': instance.workflowType,
      'progress': instance.progress,
      'videoUrl': instance.videoUrl,
    };
