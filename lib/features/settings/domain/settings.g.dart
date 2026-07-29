// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => _AppSettings(
  autoplay: json['autoplay'] as bool,
  useMobileData: json['useMobileData'] as bool,
  theme: json['theme'] as String,
  language: json['language'] as String,
);

Map<String, dynamic> _$AppSettingsToJson(_AppSettings instance) =>
    <String, dynamic>{
      'autoplay': instance.autoplay,
      'useMobileData': instance.useMobileData,
      'theme': instance.theme,
      'language': instance.language,
    };
