import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/core_providers.dart';
import 'package:vidspod_mobile/features/motions/data/motion_repository.dart';
import 'package:vidspod_mobile/features/motions/domain/motion.dart';

final motionRepositoryProvider = Provider<MotionRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MotionRepository(apiClient);
});

final motionListProvider = FutureProvider<List<Motion>>((ref) {
  final motionRepository = ref.watch(motionRepositoryProvider);
  return motionRepository.getMotions();
});

final motionDetailProvider = FutureProvider.family<Motion, String>((ref, publicGuid) {
  final motionRepository = ref.watch(motionRepositoryProvider);
  return motionRepository.getMotionDetails(publicGuid);
});
