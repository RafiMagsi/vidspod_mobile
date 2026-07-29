// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResearchRun _$ResearchRunFromJson(Map<String, dynamic> json) => _ResearchRun(
  id: json['id'] as String,
  topic: json['topic'] as String,
  status: json['status'] as String,
  progress: json['progress'] as Map<String, dynamic>,
);

Map<String, dynamic> _$ResearchRunToJson(_ResearchRun instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'status': instance.status,
      'progress': instance.progress,
    };
