import 'package:freezed_annotation/freezed_annotation.dart';

part 'motion.freezed.dart';
part 'motion.g.dart';

@freezed
abstract class Motion with _$Motion {
  const factory Motion({
    required String publicGuid,
    required String title,
    required String description,
    required String thumbnailUrl,
    required String previewVideoUrl,
    required String referenceType,
    required int creditPrice,
    required List<String> supportedAspectRatios,
    required bool isAvailable,
  }) = _Motion;

  factory Motion.fromJson(Map<String, dynamic> json) => _$MotionFromJson(json);
}
