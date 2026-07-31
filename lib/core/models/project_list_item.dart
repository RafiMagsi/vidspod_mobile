import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_list_item.freezed.dart';
part 'project_list_item.g.dart';

/// A row in the Projects list.
/// Generated from `backend/apps/api/app/schemas/projects.py`.
@freezed
abstract class ProjectListItem with _$ProjectListItem {
  const factory ProjectListItem({
    required String id,
    required String title,
    required String status,
    required String creationMode,
    required String aspectRatio,
    required int targetDurationSeconds,
    String? previewUrl,
    String? finalUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProjectListItem;

  factory ProjectListItem.fromJson(Map<String, dynamic> json) =>
      _$ProjectListItemFromJson(json);
}
