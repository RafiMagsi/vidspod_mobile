import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/core/api/page.dart';
import 'package:vidspod_mobile/core/models/project_list_item.dart';

/// Projects per docs/MOBILE_APP_GUIDE.md §5.6.
///
/// Mobile is read + monitor + play + share. "Edit in Studio" opens the web app.
class ProjectsRepository {
  final ApiClient _apiClient;

  ProjectsRepository(this._apiClient);

  /// Keyset pagination (§3.2): `data.items[]` + `data.next_cursor`.
  Future<Page<ProjectListItem>> getProjects({
    int? limit,
    String? cursor,
    String? status,
  }) async {
    try {
      return await _apiClient.getPage(
        Endpoints.projects,
        decoder: ProjectListItem.fromJson,
        queryParameters: {
          'limit': ?limit,
          'cursor': ?cursor,
          'status': ?status,
        },
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ProjectListItem> getProject(String id) async {
    try {
      return await _apiClient.getObject(
        Endpoints.projectWith(id),
        decoder: ProjectListItem.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> deleteProject(String id) async {
    try {
      await _apiClient.delete(Endpoints.deleteProjectWith(id));
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
