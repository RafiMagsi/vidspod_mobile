import 'package:freezed_annotation/freezed_annotation.dart';

part 'format_preset.freezed.dart';
part 'format_preset.g.dart';

/// A "Motion" — a generation format preset.
/// Generated from `backend/apps/api/app/schemas/generate_hub.py`.
@freezed
abstract class FormatPreset with _$FormatPreset {
  const FormatPreset._();

  const factory FormatPreset({
    required String key,
    required String publicId,
    required String label,
    required String description,
    String? imageUrl,
    String? previewVideoUrl,
    String? styleReferenceImageUrl,
    String? templateVideoUrl,
    String? aspectRatio,
    String? stylePack,
    required int durationSeconds,
    required int sceneCount,
    required int batchSize,
    required List<String> categories,
    required List<String> cameraMovements,
    required String generationMode,
    required String prompt,
    required String genre,
    required String speed,
    required String shotsMode,
    required String modelKey,
    required bool requiresReferenceImage,
    required bool audioEnabled,
    Map<String, dynamic>? workflow,
  }) = _FormatPreset;

  factory FormatPreset.fromJson(Map<String, dynamic> json) =>
      _$FormatPresetFromJson(json);

  /// Non-null workflow ⇒ one-click clone Motion.
  bool get isCloneMotion => (workflow?['shots'] as List?)?.isNotEmpty ?? false;
}
