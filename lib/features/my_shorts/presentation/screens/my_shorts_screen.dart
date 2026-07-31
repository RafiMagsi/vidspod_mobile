import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/models/short_run.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/features/my_shorts/my_shorts_providers.dart';

/// My Shorts run monitoring per docs/MOBILE_APP_GUIDE.md §5.3.
///
/// Buttons are driven by the server `can_*` booleans; `status_label` /
/// `stage_message` are rendered verbatim.
class MyShortsScreen extends ConsumerStatefulWidget {
  const MyShortsScreen({super.key});

  @override
  ConsumerState<MyShortsScreen> createState() => _MyShortsScreenState();
}

class _MyShortsScreenState extends ConsumerState<MyShortsScreen> {
  String? _statusFilter;
  final _statuses = ['running', 'completed', 'failed'];

  @override
  Widget build(BuildContext context) {
    final runs = ref.watch(shortRunsProvider(_statusFilter));
    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: VrTheme.black,
        title: Text('My Shorts', style: VrTheme.headingLarge()),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.filter_list,
              color: _statusFilter == null
                  ? Colors.white.withAlpha(90)
                  : VrTheme.purple,
            ),
            onSelected: (value) {
              setState(() => _statusFilter = value == 'all' ? null : value);
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'all', child: Text('All')),
              for (final s in _statuses)
                PopupMenuItem(value: s, child: Text(_cap(s))),
            ],
          ),
        ],
      ),
      body: runs.when(
        data: (items) => items.isEmpty
            ? const _EmptyState()
            : Scrollbar(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _RunCard(run: items[i]),
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

  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _RunCard extends ConsumerWidget {
  final ShortRun run;
  const _RunCard({required this.run});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primary = _statusColor(run.status);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: VrTheme.surfaceDark,
        borderRadius: BorderRadius.circular(VrTheme.radiusLg),
        border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primary.withAlpha(40),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(_statusIcon(run.status), color: primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      run.presetName,
                      style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      run.statusLabel,
                      style: VrTheme.caption(color: primary),
                    ),
                  ],
                ),
              ),
              Text(
                run.aspectRatio,
                style: VrTheme.caption(color: Colors.white.withAlpha(70)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            run.stageMessage,
            style: VrTheme.bodySmall(color: Colors.white.withAlpha(90)),
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: run.playbackReady ? 1 : null,
            backgroundColor: VrTheme.cardBorder.withAlpha(50),
            color: primary,
            minHeight: 3,
            borderRadius: BorderRadius.circular(2),
          ),
          if (run.canRetry || run.canCancel)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  if (run.canCancel)
                    _ActionButton(
                      label: 'Cancel',
                      icon: Icons.close,
                      color: VrTheme.orange,
                      onTap: () => _cancel(context, ref),
                    ),
                  if (run.canRetry)
                    _ActionButton(
                      label: 'Retry',
                      icon: Icons.refresh,
                      color: VrTheme.green,
                      onTap: () => _retry(context, ref),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'completed':
        return VrTheme.green;
      case 'failed':
        return VrTheme.orange;
      case 'running':
      case 'generating':
        return VrTheme.blue;
      default:
        return Colors.white.withAlpha(80);
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'failed':
        return Icons.error_outline;
      case 'running':
      case 'generating':
        return Icons.hourglass_top;
      default:
        return Icons.circle_outlined;
    }
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    await ref.read(myShortsRepositoryProvider).cancel(run.id);
    ref.invalidate(shortRunsProvider(_statusOf(run)));
  }

  Future<void> _retry(BuildContext context, WidgetRef ref) async {
    await ref.read(myShortsRepositoryProvider).retry(run.id);
    ref.invalidate(shortRunsProvider(_statusOf(run)));
  }

  String? _statusOf(ShortRun run) =>
      run.status == 'completed' || run.status == 'failed' ? run.status : null;
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
          border: Border.all(color: color.withAlpha(80)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.video_library_outlined,
            size: 48,
            color: Colors.white.withAlpha(50),
          ),
          const SizedBox(height: 12),
          Text(
            'No runs here yet',
            style: VrTheme.bodyMedium(color: Colors.white.withAlpha(80)),
          ),
        ],
      ),
    );
  }
}
