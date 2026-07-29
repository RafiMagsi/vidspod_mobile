import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/media/media_repository.dart';
import 'package:vidspod_mobile/core/storage/secure_storage_repository.dart';
import 'package:vidspod_mobile/features/auth/data/auth_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final secureStorageRepositoryProvider = Provider<SecureStorageRepository>((ref) {
  return SecureStorageRepository();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final secureStorageRepository = ref.watch(secureStorageRepositoryProvider);
  return AuthRepository(apiClient, secureStorageRepository);
});

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MediaRepository(apiClient);
});
