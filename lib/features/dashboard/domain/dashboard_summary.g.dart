// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardSummary _$DashboardSummaryFromJson(Map<String, dynamic> json) =>
    _DashboardSummary(
      creditBalance: (json['creditBalance'] as num).toInt(),
      recentGenerationsCount: (json['recentGenerationsCount'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardSummaryToJson(_DashboardSummary instance) =>
    <String, dynamic>{
      'creditBalance': instance.creditBalance,
      'recentGenerationsCount': instance.recentGenerationsCount,
    };
