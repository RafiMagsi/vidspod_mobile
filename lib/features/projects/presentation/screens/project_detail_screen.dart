import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/models/project_list_item.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/features/projects/projects_providers.dart';

/// Project detail per docs/MOBILE_APP_GUIDE.md §5.6.
///
/// Read + monitor + play + share. "Edit in Studio" opens the web app.
class ProjectDetailScreen extends ConsumerWidget {
  final String id;
  const ProjectDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectDetailProvider(id));
    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(
        backgroundColor: VrTheme.black,
        title: Text('Project', style: VrTheme.headingLarge()),
      ),
      body: project.when(
        data: (p) => _ProjectDetail(project: p),
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

class _ProjectDetail extends StatelessWidget {
  final ProjectListItem project;
  const _ProjectDetail({required this.project});

  @override
  Widget build(BuildContext context) {
    final mediaUrl = project.finalUrl ?? project.previewUrl;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 320,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(VrTheme.radiusXl),
              child: mediaUrl != null
                  ? AppNetworkImage(
                      url: mediaUrl,
                      placeholderIcon: Icons.movie_outlined,
                    )
                  : _placeholder(context),
            ),
          ),
          const SizedBox(height: 16),
          Text(project.title, style: VrTheme.headingLarge()),
          const SizedBox(height: 6),
          Row(
            children: [
              _infoChip(Icons.aspect_ratio, project.aspectRatio),
              const SizedBox(width: 8),
              _infoChip(
                Icons.timer_outlined,
                '${project.targetDurationSeconds}s',
              ),
              const SizedBox(width: 8),
              _infoChip(Icons.tune, project.creationMode.replaceAll('_', ' ')),
            ],
          ),
          const SizedBox(height: 20),
          if (mediaUrl != null)
            Row(
              children: [
                Expanded(
                  child: _PrimaryAction(
                    icon: Icons.play_circle_outline,
                    label: 'Play',
                    onTap: () => _snack(context, 'Playback coming soon'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _PrimaryAction(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () => _snack(context, 'Share coming soon'),
                  ),
                ),
              ],
            ),
          if (mediaUrl == null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: VrTheme.darkSurface,
                borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
              ),
              child: Row(
                children: [
                  Icon(Icons.hourglass_top, color: VrTheme.blue, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'This project is still rendering. Check back soon.',
                      style: VrTheme.bodySmall(
                        color: Colors.white.withAlpha(90),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: VrTheme.darkSurface,
        borderRadius: BorderRadius.circular(VrTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white.withAlpha(80)),
          const SizedBox(width: 4),
          Text(
            label,
            style: VrTheme.caption(color: Colors.white.withAlpha(90)),
          ),
        ],
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      color: VrTheme.mediumSurface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.movie_outlined,
              size: 44,
              color: Colors.white.withAlpha(60),
            ),
            const SizedBox(height: 10),
            Text(
              'Preview coming soon',
              style: VrTheme.bodyMedium(color: Colors.white.withAlpha(70)),
            ),
          ],
        ),
      ),
    );
  }

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _PrimaryAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _PrimaryAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: VrTheme.purple.withAlpha(30),
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.purple.withAlpha(90)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: VrTheme.purple, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: VrTheme.purple,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
