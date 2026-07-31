// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectListItem _$ProjectListItemFromJson(Map<String, dynamic> json) =>
    _ProjectListItem(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      creationMode: json['creationMode'] as String,
      aspectRatio: json['aspectRatio'] as String,
      targetDurationSeconds: (json['targetDurationSeconds'] as num).toInt(),
      previewUrl: json['previewUrl'] as String?,
      finalUrl: json['finalUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProjectListItemToJson(_ProjectListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'creationMode': instance.creationMode,
      'aspectRatio': instance.aspectRatio,
      'targetDurationSeconds': instance.targetDurationSeconds,
      'previewUrl': instance.previewUrl,
      'finalUrl': instance.finalUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
