import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/core_providers.dart';
import 'package:vidspod_mobile/features/dashboard/data/dashboard_repository.dart';
import 'package:vidspod_mobile/features/dashboard/domain/dashboard_summary.dart';
import 'package:vidspod_mobile/features/dashboard/domain/recent_generation.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardRepository(apiClient);
});

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) {
  final dashboardRepository = ref.watch(dashboardRepositoryProvider);
  return dashboardRepository.getDashboardSummary();
});

final recentGenerationsProvider = FutureProvider<List<RecentGeneration>>((ref) {
  final dashboardRepository = ref.watch(dashboardRepositoryProvider);
  return dashboardRepository.getRecentGenerations();
});
