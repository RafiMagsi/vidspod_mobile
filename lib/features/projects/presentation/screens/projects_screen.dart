import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/models/project_list_item.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/core/widgets/staggered_fade_in.dart';
import 'package:vidspod_mobile/features/projects/projects_providers.dart';

/// Projects list per docs/MOBILE_APP_GUIDE.md §5.6.
class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: VrTheme.black,
        title: Text('Projects', style: VrTheme.headingLarge()),
      ),
      body: projects.when(
        data: (items) => items.isEmpty
            ? const AsyncStateView(
                loading: false,
                emptyMessage: 'No projects yet',
                emptyIcon: Icons.folder_open_outlined,
              )
            : Scrollbar(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (_, i) => StaggeredFadeIn(
                    index: i,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ProjectCard(project: items[i]),
                    ),
                  ),
                ),
              ),
        loading: () => const AsyncStateView(loading: true, emptyMessage: ''),
        error: (error, _) => AsyncStateView(
          loading: false,
          errorMessage: '$error',
          emptyMessage: '',
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectListItem project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final mediaUrl = project.previewUrl ?? project.finalUrl;
    final primary = _statusColor(project.status);

    return GestureDetector(
      onTap: () => context.push('/projects/${project.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              width: double.infinity,
              child: mediaUrl != null
                  ? AppNetworkImage(
                      url: mediaUrl,
                      placeholderIcon: Icons.movie_outlined,
                    )
                  : _placeholder(context),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          style: VrTheme.bodyMedium(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primary.withAlpha(25),
                          borderRadius: BorderRadius.circular(
                            VrTheme.radiusFull,
                          ),
                        ),
                        child: Text(
                          _statusLabel(project.status),
                          style: VrTheme.caption(color: primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.aspect_ratio,
                        size: 14,
                        color: Colors.white.withAlpha(70),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        project.aspectRatio,
                        style: VrTheme.caption(
                          color: Colors.white.withAlpha(70),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.timer_outlined,
                        size: 14,
                        color: Colors.white.withAlpha(70),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${project.targetDurationSeconds}s',
                        style: VrTheme.caption(
                          color: Colors.white.withAlpha(70),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Graceful placeholder per the guide's "known data gap" — a completed
  /// project may have a null `final_url`/`preview_url`.
  Widget _placeholder(BuildContext context) {
    return Container(
      color: VrTheme.mediumSurface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.movie_outlined,
              size: 36,
              color: Colors.white.withAlpha(60),
            ),
            const SizedBox(height: 8),
            Text(
              'Preview coming soon',
              style: VrTheme.caption(color: Colors.white.withAlpha(70)),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'completed':
        return VrTheme.green;
      case 'in_progress':
      case 'rendering':
        return VrTheme.blue;
      case 'failed':
        return VrTheme.orange;
      default:
        return Colors.white.withAlpha(80);
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'in_progress':
        return 'In progress';
      case 'failed':
        return 'Failed';
      default:
        return status.replaceAll('_', ' ');
    }
  }
}
