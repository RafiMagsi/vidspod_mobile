// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'format_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormatPreset _$FormatPresetFromJson(Map<String, dynamic> json) =>
    _FormatPreset(
      key: json['key'] as String,
      publicId: json['publicId'] as String,
      label: json['label'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      previewVideoUrl: json['previewVideoUrl'] as String?,
      styleReferenceImageUrl: json['styleReferenceImageUrl'] as String?,
      templateVideoUrl: json['templateVideoUrl'] as String?,
      aspectRatio: json['aspectRatio'] as String?,
      stylePack: json['stylePack'] as String?,
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      sceneCount: (json['sceneCount'] as num).toInt(),
      batchSize: (json['batchSize'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      cameraMovements: (json['cameraMovements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      generationMode: json['generationMode'] as String,
      prompt: json['prompt'] as String,
      genre: json['genre'] as String,
      speed: json['speed'] as String,
      shotsMode: json['shotsMode'] as String,
      modelKey: json['modelKey'] as String,
      requiresReferenceImage: json['requiresReferenceImage'] as bool,
      audioEnabled: json['audioEnabled'] as bool,
      workflow: json['workflow'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FormatPresetToJson(_FormatPreset instance) =>
    <String, dynamic>{
      'key': instance.key,
      'publicId': instance.publicId,
      'label': instance.label,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'previewVideoUrl': instance.previewVideoUrl,
      'styleReferenceImageUrl': instance.styleReferenceImageUrl,
      'templateVideoUrl': instance.templateVideoUrl,
      'aspectRatio': instance.aspectRatio,
      'stylePack': instance.stylePack,
      'durationSeconds': instance.durationSeconds,
      'sceneCount': instance.sceneCount,
      'batchSize': instance.batchSize,
      'categories': instance.categories,
      'cameraMovements': instance.cameraMovements,
      'generationMode': instance.generationMode,
      'prompt': instance.prompt,
      'genre': instance.genre,
      'speed': instance.speed,
      'shotsMode': instance.shotsMode,
      'modelKey': instance.modelKey,
      'requiresReferenceImage': instance.requiresReferenceImage,
      'audioEnabled': instance.audioEnabled,
      'workflow': instance.workflow,
    };
