import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_credits.freezed.dart';
part 'account_credits.g.dart';

/// `GET /account/credits` per docs/MOBILE_APP_GUIDE.md §5.1/§5.13.
/// 🔴 endpoint — mobile needs this one; today credit costs are embedded per
/// payload.
@freezed
abstract class AccountCredits with _$AccountCredits {
  const factory AccountCredits({
    required int balance,
    required String plan,
    DateTime? renewsAt,
    Map<String, int>? costs,
  }) = _AccountCredits;

  factory AccountCredits.fromJson(Map<String, dynamic> json) =>
      _$AccountCreditsFromJson(json);
}
