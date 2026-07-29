import 'package:freezed_annotation/freezed_annotation.dart';

part 'generation.freezed.dart';
part 'generation.g.dart';

@freezed
abstract class Generation with _$Generation {
  const factory Generation({
    required String id,
    required String status,
    required int reservedCredits,
    required String workflowType,
    required Map<String, dynamic> progress,
    String? videoUrl,
  }) = _Generation;

  factory Generation.fromJson(Map<String, dynamic> json) => _$GenerationFromJson(json);
}
