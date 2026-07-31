import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/features/publishing/data/publishing_repository.dart';

final publishingRepositoryProvider = Provider<PublishingRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PublishingRepository(apiClient);
});
