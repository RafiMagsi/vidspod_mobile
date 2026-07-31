// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountCredits _$AccountCreditsFromJson(Map<String, dynamic> json) =>
    _AccountCredits(
      balance: (json['balance'] as num).toInt(),
      plan: json['plan'] as String,
      renewsAt: json['renewsAt'] == null
          ? null
          : DateTime.parse(json['renewsAt'] as String),
      costs: (json['costs'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$AccountCreditsToJson(_AccountCredits instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'plan': instance.plan,
      'renewsAt': instance.renewsAt?.toIso8601String(),
      'costs': instance.costs,
    };
