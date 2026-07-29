import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_generation.freezed.dart';
part 'recent_generation.g.dart';

@freezed
abstract class RecentGeneration with _$RecentGeneration {
  const factory RecentGeneration({
    required String id,
    required String thumbnailUrl,
    required String status,
  }) = _RecentGeneration;

  factory RecentGeneration.fromJson(Map<String, dynamic> json) => _$RecentGenerationFromJson(json);
}
