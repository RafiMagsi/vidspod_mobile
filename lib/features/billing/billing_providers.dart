import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/preview/preview_data.dart';
import 'package:vidspod_mobile/features/billing/data/billing_repository.dart';
import 'package:vidspod_mobile/features/billing/domain/account_credits.dart';

final billingRepositoryProvider = Provider<BillingRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return BillingRepository(apiClient);
});

/// Credit balance for the dashboard chip. Falls back to the dashboard summary
/// balance in preview mode.
final creditsProvider = FutureProvider<AccountCredits>((ref) {
  if (Config.previewMode) {
    return Future.value(PreviewData.accountCredits);
  }
  final billingRepository = ref.watch(billingRepositoryProvider);
  return billingRepository.getCredits();
});
