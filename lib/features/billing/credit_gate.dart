import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/api/api_response.dart';
import 'package:vidspod_mobile/features/billing/billing_providers.dart';

/// Shared credit enforcement per docs/MOBILE_APP_GUIDE.md §3.4 / §5.4.
///
/// A 402 / `code: insufficient_credits` must open the paywall, and screens that
/// know their cost should block submit up-front when the balance is short —
/// never submit a credit-costing job the user can't afford.
abstract final class CreditGate {
  /// Routes the paywall route. Returns true when it was a credit error and the
  /// paywall was opened.
  static bool onApiError(BuildContext context, Object error) {
    if (error is ApiException && error.isInsufficientCredits) {
      _openPaywall(context, message: error.message);
      return true;
    }
    return false;
  }

  /// Returns true when the [cost] fits the balance. When short, opens the
  /// paywall and returns false so the caller aborts the submit.
  static Future<bool> ensureBalance(
    BuildContext context,
    WidgetRef ref,
    int cost,
  ) async {
    if (cost <= 0) return true;
    final balance = (await ref.read(creditsProvider.future)).balance;
    if (balance >= cost) return true;
    if (!context.mounted) return false;
    _openPaywall(
      context,
      message: 'You need $cost credits for this — you have $balance.',
    );
    return false;
  }

  static void _openPaywall(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
    context.push('/plan-billing');
  }
}
