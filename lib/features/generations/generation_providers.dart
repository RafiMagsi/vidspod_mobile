import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/preview/preview_data.dart';
import 'package:vidspod_mobile/features/generations/data/generation_repository.dart';
import 'package:vidspod_mobile/features/generations/domain/generation.dart';

final generationRepositoryProvider = Provider<GenerationRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return GenerationRepository(apiClient);
});

final generationProvider = FutureProvider.family<Generation, String>((ref, id) {
  if (Config.previewMode) {
    return Future.value(PreviewData.generation(id));
  }
  final generationRepository = ref.watch(generationRepositoryProvider);
  return generationRepository.getGeneration(id);
});

final generationHistoryProvider = FutureProvider<List<Generation>>((ref) {
  if (Config.previewMode) {
    return Future.value(PreviewData.generations);
  }
  final generationRepository = ref.watch(generationRepositoryProvider);
  return generationRepository.getGenerations();
});
