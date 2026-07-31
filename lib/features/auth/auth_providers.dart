import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/auth/token_store.dart';
import 'package:vidspod_mobile/features/auth/data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final tokenStore = ref.watch(tokenStoreProvider);
  return AuthRepository(apiClient, tokenStore);
});
