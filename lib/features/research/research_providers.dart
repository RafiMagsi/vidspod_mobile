import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/features/research/data/research_repository.dart';
import 'package:vidspod_mobile/features/research/domain/research_run.dart';
import 'package:vidspod_mobile/features/research/domain/research_result.dart';

final researchRepositoryProvider = Provider<ResearchRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ResearchRepository(apiClient);
});

final researchRunsProvider = FutureProvider<List<ResearchRun>>((ref) {
  final researchRepository = ref.watch(researchRepositoryProvider);
  return researchRepository.getResearchRuns();
});

final researchRunProvider = FutureProvider.family<ResearchRun, String>((ref, id) {
  final researchRepository = ref.watch(researchRepositoryProvider);
  return researchRepository.getResearchRun(id);
});

final researchRunResultsProvider = FutureProvider.family<List<ResearchResult>, String>((ref, id) {
  final researchRepository = ref.watch(researchRepositoryProvider);
  return researchRepository.getResearchRunResults(id);
});
