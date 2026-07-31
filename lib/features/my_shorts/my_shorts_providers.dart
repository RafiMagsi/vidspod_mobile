import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/models/short_run.dart';
import 'package:vidspod_mobile/core/preview/preview_data.dart';
import 'package:vidspod_mobile/features/my_shorts/data/my_shorts_repository.dart';

final myShortsRepositoryProvider = Provider<MyShortsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MyShortsRepository(apiClient);
});

/// My Shorts runs. Pass `status` to filter server-side.
final shortRunsProvider = FutureProvider.autoDispose
    .family<List<ShortRun>, String?>((ref, status) {
      if (Config.previewMode) {
        final runs = PreviewData.shortRuns;
        if (status == null || status.isEmpty) return Future.value(runs);
        return Future.value(runs.where((r) => r.status == status).toList());
      }
      final myShortsRepository = ref.watch(myShortsRepositoryProvider);
      return myShortsRepository
          .getRuns(status: status)
          .then((page) => page.items);
    });

/// A single run, fetched for progress polling (§5.3/§9).
final shortRunProvider = FutureProvider.autoDispose.family<ShortRun, String>((
  ref,
  runId,
) {
  if (Config.previewMode) {
    return Future.value(PreviewData.shortRun(runId));
  }
  final myShortsRepository = ref.watch(myShortsRepositoryProvider);
  return myShortsRepository.getRun(runId);
});
