import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/features/profile/data/profile_repository.dart';
import 'package:vidspod_mobile/features/profile/domain/profile.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProfileRepository(apiClient);
});

final profileProvider = FutureProvider<Profile>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return profileRepository.getProfile();
});
