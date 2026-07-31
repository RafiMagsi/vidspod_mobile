import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/models/format_preset.dart';
import 'package:vidspod_mobile/core/preview/preview_data.dart';
import 'package:vidspod_mobile/features/shorts_studio/data/shorts_studio_repository.dart';
import 'package:vidspod_mobile/features/shorts_studio/domain/generate_hub.dart';

final shortsStudioRepositoryProvider = Provider<ShortsStudioRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ShortsStudioRepository(apiClient);
});

/// Hub payload for a flow category (defaults to the Shorts Studio flagship).
final generateHubProvider = FutureProvider.autoDispose
    .family<GenerateHub, String>((ref, flowCategory) {
      if (Config.previewMode) {
        return Future.value(PreviewData.generateHub);
      }
      final repository = ref.watch(shortsStudioRepositoryProvider);
      return repository.getHub(flowCategory: flowCategory);
    });

/// The `format_presets` the server actually gated for Shorts Studio
/// (render verbatim — never filter client-side, per §5.2).
final shortStudioPresetsProvider =
    FutureProvider.autoDispose<List<FormatPreset>>((ref) async {
      final hub = await ref.watch(generateHubProvider('short-studio').future);
      return hub.formatPresets;
    });
