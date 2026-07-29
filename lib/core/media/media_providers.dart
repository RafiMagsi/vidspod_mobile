import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/media/media_repository.dart';

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MediaRepository(apiClient);
});
