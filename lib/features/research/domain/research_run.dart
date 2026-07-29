import 'package:freezed_annotation/freezed_annotation.dart';

part 'research_run.freezed.dart';
part 'research_run.g.dart';

@freezed
class ResearchRun with _$ResearchRun {
  const factory ResearchRun({
    required String id,
    required String topic,
    required String status,
    required Map<String, dynamic> progress,
  }) = _ResearchRun;

  factory ResearchRun.fromJson(Map<String, dynamic> json) => _$ResearchRunFromJson(json);
}
