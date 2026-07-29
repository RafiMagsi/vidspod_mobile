import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/features/generations/data/generation_repository.dart';
import 'package:vidspod_mobile/features/generations/domain/generation.dart';

final generationRepositoryProvider = Provider<GenerationRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return GenerationRepository(apiClient);
});

final generationProvider = FutureProvider.family<Generation, String>((ref, id) {
  final generationRepository = ref.watch(generationRepositoryProvider);
  return generationRepository.getGeneration(id);
});

final generationHistoryProvider = FutureProvider<List<Generation>>((ref) {
  final generationRepository = ref.watch(generationRepositoryProvider);
  return generationRepository.getGenerations();
});
