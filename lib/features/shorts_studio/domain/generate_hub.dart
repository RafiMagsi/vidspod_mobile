import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vidspod_mobile/core/models/format_preset.dart';

part 'generate_hub.freezed.dart';

/// Everything the Shorts Studio / video studios need from
/// `GET /generate/hub?flow_category=...` per docs/MOBILE_APP_GUIDE.md §5.2/§5.5.
@freezed
abstract class GenerateHub with _$GenerateHub {
  const factory GenerateHub({
    required Map<String, dynamic> flowMeta,
    required List<FormatPreset> formatPresets,
    required List<Map<String, dynamic>> stylePacks,
    required List<Map<String, dynamic>> aiVideoProducts,
    required List<String> cameraMovements,
    required List<String> aspectRatios,
    required List<Map<String, dynamic>> userElements,
    String? heroBackgroundVideo,
    required int generationCost,
  }) = _GenerateHub;

  factory GenerateHub.fromJson(Map<String, dynamic> json) {
    return GenerateHub(
      flowMeta:
          (json['flow_meta'] as Map?)?.cast<String, dynamic>() ?? const {},
      formatPresets: (json['format_presets'] as List? ?? const [])
          .map((e) => FormatPreset.fromJson(e as Map<String, dynamic>))
          .toList(),
      stylePacks: (json['style_packs'] as List? ?? const [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      aiVideoProducts: (json['ai_video_products'] as List? ?? const [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      cameraMovements: (json['camera_movements'] as List? ?? const [])
          .cast<String>(),
      aspectRatios: (json['aspect_ratios'] as List? ?? const []).cast<String>(),
      userElements: (json['user_elements'] as List? ?? const [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      heroBackgroundVideo: json['hero_background_video'] as String?,
      generationCost: json['generation_cost'] as int? ?? 0,
    );
  }
}
