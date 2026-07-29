import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/storage/storage_providers.dart';
import 'package:vidspod_mobile/features/auth/data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final secureStorageRepository = ref.watch(secureStorageRepositoryProvider);
  return AuthRepository(apiClient, secureStorageRepository);
});
