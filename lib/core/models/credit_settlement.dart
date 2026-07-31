import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_settlement.freezed.dart';
part 'credit_settlement.g.dart';

/// How a generation run billed/refunded credits.
/// Generated from `backend/apps/api/app/schemas/my_shorts.py`.
@freezed
abstract class CreditSettlement with _$CreditSettlement {
  const factory CreditSettlement({
    required int creditsCharged,
    required int creditsRefunded,
    required String status,
    String? message,
  }) = _CreditSettlement;

  factory CreditSettlement.fromJson(Map<String, dynamic> json) =>
      _$CreditSettlementFromJson(json);
}
