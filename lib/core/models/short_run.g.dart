// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShortRun _$ShortRunFromJson(Map<String, dynamic> json) => _ShortRun(
  id: json['id'] as String,
  status: json['status'] as String,
  statusLabel: json['statusLabel'] as String,
  stageKey: json['stageKey'] as String,
  stageLabel: json['stageLabel'] as String,
  stageMessage: json['stageMessage'] as String,
  presetName: json['presetName'] as String,
  presetKey: json['presetKey'] as String,
  aspectRatio: json['aspectRatio'] as String,
  referenceImageUrl: json['referenceImageUrl'] as String?,
  playbackUrl: json['playbackUrl'] as String?,
  playbackReady: json['playbackReady'] as bool,
  canRetry: json['canRetry'] as bool,
  canCancel: json['canCancel'] as bool,
  canDeleteMedia: json['canDeleteMedia'] as bool,
  outputWidth: (json['outputWidth'] as num).toInt(),
  outputHeight: (json['outputHeight'] as num).toInt(),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  creditSettlement: CreditSettlement.fromJson(
    json['creditSettlement'] as Map<String, dynamic>,
  ),
  refundStatus: json['refundStatus'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ShortRunToJson(_ShortRun instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'statusLabel': instance.statusLabel,
  'stageKey': instance.stageKey,
  'stageLabel': instance.stageLabel,
  'stageMessage': instance.stageMessage,
  'presetName': instance.presetName,
  'presetKey': instance.presetKey,
  'aspectRatio': instance.aspectRatio,
  'referenceImageUrl': instance.referenceImageUrl,
  'playbackUrl': instance.playbackUrl,
  'playbackReady': instance.playbackReady,
  'canRetry': instance.canRetry,
  'canCancel': instance.canCancel,
  'canDeleteMedia': instance.canDeleteMedia,
  'outputWidth': instance.outputWidth,
  'outputHeight': instance.outputHeight,
  'durationSeconds': instance.durationSeconds,
  'creditSettlement': instance.creditSettlement,
  'refundStatus': instance.refundStatus,
  'createdAt': instance.createdAt.toIso8601String(),
};
