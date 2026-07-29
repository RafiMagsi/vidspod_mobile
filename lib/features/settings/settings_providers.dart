import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/features/settings/data/settings_repository.dart';
import 'package:vidspod_mobile/features/settings/domain/settings.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SettingsRepository(apiClient);
});

final settingsProvider = FutureProvider<AppSettings>((ref) {
  final settingsRepository = ref.watch(settingsRepositoryProvider);
  return settingsRepository.getSettings();
});
