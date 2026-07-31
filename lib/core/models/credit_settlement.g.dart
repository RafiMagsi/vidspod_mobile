// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_settlement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreditSettlement _$CreditSettlementFromJson(Map<String, dynamic> json) =>
    _CreditSettlement(
      creditsCharged: (json['creditsCharged'] as num).toInt(),
      creditsRefunded: (json['creditsRefunded'] as num).toInt(),
      status: json['status'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CreditSettlementToJson(_CreditSettlement instance) =>
    <String, dynamic>{
      'creditsCharged': instance.creditsCharged,
      'creditsRefunded': instance.creditsRefunded,
      'status': instance.status,
      'message': instance.message,
    };
