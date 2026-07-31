// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSession _$UserSessionFromJson(Map<String, dynamic> json) => _UserSession(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresIn: (json['expiresIn'] as num?)?.toInt(),
  user: json['user'] == null
      ? null
      : SessionUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserSessionToJson(_UserSession instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
    };

_SessionUser _$SessionUserFromJson(Map<String, dynamic> json) => _SessionUser(
  id: json['id'] as String,
  email: json['email'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$SessionUserToJson(_SessionUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
    };
