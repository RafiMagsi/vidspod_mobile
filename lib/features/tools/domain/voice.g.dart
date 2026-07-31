// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Voice _$VoiceFromJson(Map<String, dynamic> json) => _Voice(
  id: json['id'] as String,
  name: json['name'] as String,
  provider: json['provider'] as String,
  style: json['style'] as String?,
  language: json['language'] as String?,
  accent: json['accent'] as String?,
  gender: json['gender'] as String?,
  description: json['description'] as String?,
  bestFor: json['bestFor'] as String?,
);

Map<String, dynamic> _$VoiceToJson(_Voice instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'provider': instance.provider,
  'style': instance.style,
  'language': instance.language,
  'accent': instance.accent,
  'gender': instance.gender,
  'description': instance.description,
  'bestFor': instance.bestFor,
};
