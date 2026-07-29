import 'package:freezed_annotation/freezed_annotation.dart';

part 'research_result.freezed.dart';
part 'research_result.g.dart';

@freezed
abstract class ResearchResult with _$ResearchResult {
  const factory ResearchResult({
    required String id,
    required String content,
  }) = _ResearchResult;

  factory ResearchResult.fromJson(Map<String, dynamic> json) => _$ResearchResultFromJson(json);
}
