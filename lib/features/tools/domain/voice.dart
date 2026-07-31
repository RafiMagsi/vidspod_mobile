import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice.freezed.dart';
part 'voice.g.dart';

/// A TTS voice from the `GET /voices` catalog (§5.8).
///
/// Unknown/optional fields are tolerant so a partial backend response still
/// renders a usable card.
@freezed
abstract class Voice with _$Voice {
  const Voice._();

  const factory Voice({
    required String id,
    required String name,
    required String provider,
    String? style,
    String? language,
    String? accent,
    String? gender,
    String? description,
    String? bestFor,
  }) = _Voice;

  factory Voice.fromJson(Map<String, dynamic> json) => _$VoiceFromJson(json);

  bool get isMale => gender?.toLowerCase() == 'male';
}
