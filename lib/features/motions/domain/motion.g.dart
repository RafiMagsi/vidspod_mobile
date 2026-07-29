// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Motion _$MotionFromJson(Map<String, dynamic> json) => _Motion(
  publicGuid: json['publicGuid'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String,
  previewVideoUrl: json['previewVideoUrl'] as String,
  referenceType: json['referenceType'] as String,
  creditPrice: (json['creditPrice'] as num).toInt(),
  supportedAspectRatios: (json['supportedAspectRatios'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  isAvailable: json['isAvailable'] as bool,
);

Map<String, dynamic> _$MotionToJson(_Motion instance) => <String, dynamic>{
  'publicGuid': instance.publicGuid,
  'title': instance.title,
  'description': instance.description,
  'thumbnailUrl': instance.thumbnailUrl,
  'previewVideoUrl': instance.previewVideoUrl,
  'referenceType': instance.referenceType,
  'creditPrice': instance.creditPrice,
  'supportedAspectRatios': instance.supportedAspectRatios,
  'isAvailable': instance.isAvailable,
};
