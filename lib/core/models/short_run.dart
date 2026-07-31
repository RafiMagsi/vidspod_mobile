import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vidspod_mobile/core/models/credit_settlement.dart';

part 'short_run.freezed.dart';
part 'short_run.g.dart';

/// A shorts-studio generation run being monitored.
/// Generated from `backend/apps/api/app/schemas/my_shorts.py`.
@freezed
abstract class ShortRun with _$ShortRun {
  const factory ShortRun({
    required String id,
    required String status,
    required String statusLabel,
    required String stageKey,
    required String stageLabel,
    required String stageMessage,
    required String presetName,
    required String presetKey,
    required String aspectRatio,
    String? referenceImageUrl,
    String? playbackUrl,
    required bool playbackReady,
    required bool canRetry,
    required bool canCancel,
    required bool canDeleteMedia,
    required int outputWidth,
    required int outputHeight,
    required int durationSeconds,
    required CreditSettlement creditSettlement,
    required String refundStatus,
    required DateTime createdAt,
  }) = _ShortRun;

  factory ShortRun.fromJson(Map<String, dynamic> json) =>
      _$ShortRunFromJson(json);
}
