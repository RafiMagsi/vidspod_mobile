import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/preview/preview_data.dart';
import 'package:vidspod_mobile/features/research/data/research_repository.dart';
import 'package:vidspod_mobile/features/research/domain/research_run.dart';
import 'package:vidspod_mobile/features/research/domain/research_result.dart';

final researchRepositoryProvider = Provider<ResearchRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ResearchRepository(apiClient);
});

final researchRunsProvider = FutureProvider<List<ResearchRun>>((ref) {
  if (Config.previewMode) {
    return Future.value(PreviewData.researchRuns);
  }
  final researchRepository = ref.watch(researchRepositoryProvider);
  return researchRepository.getResearchRuns();
});

/// Runs a research query for one of the eight tools (§5.9).
final researchSearchProvider =
    FutureProvider.family<ResearchRun, ({String query, String toolKey})>((
      ref,
      params,
    ) async {
      if (Config.previewMode) {
        await Future<void>.delayed(const Duration(milliseconds: 400));
        return PreviewData.researchRun('research-1');
      }
      final researchRepository = ref.watch(researchRepositoryProvider);
      return researchRepository.search(
        query: params.query,
        toolKey: params.toolKey,
      );
    });

final researchRunProvider = FutureProvider.family<ResearchRun, String>((
  ref,
  id,
) {
  if (Config.previewMode) {
    return Future.value(PreviewData.researchRun(id));
  }
  final researchRepository = ref.watch(researchRepositoryProvider);
  return researchRepository.getResearchRun(id);
});

final researchRunResultsProvider =
    FutureProvider.family<List<ResearchResult>, String>((ref, id) {
      if (Config.previewMode) {
        return Future.value(PreviewData.researchResults(id));
      }
      final researchRepository = ref.watch(researchRepositoryProvider);
      return researchRepository.getResearchRunResults(id);
    });
