import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/core/models/project_list_item.dart';
import 'package:vidspod_mobile/core/preview/preview_data.dart';
import 'package:vidspod_mobile/features/projects/data/projects_repository.dart';

final projectsRepositoryProvider = Provider<ProjectsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProjectsRepository(apiClient);
});

final projectsProvider = FutureProvider.autoDispose<List<ProjectListItem>>((
  ref,
) {
  if (Config.previewMode) {
    return Future.value(PreviewData.projects);
  }
  final projectsRepository = ref.watch(projectsRepositoryProvider);
  return projectsRepository.getProjects().then((page) => page.items);
});

final projectDetailProvider = FutureProvider.autoDispose
    .family<ProjectListItem, String>((ref, id) {
      if (Config.previewMode) {
        return Future.value(PreviewData.project(id));
      }
      final projectsRepository = ref.watch(projectsRepositoryProvider);
      return projectsRepository.getProject(id);
    });
