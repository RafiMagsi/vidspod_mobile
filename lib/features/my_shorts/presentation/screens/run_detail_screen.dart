import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/models/short_run.dart';
import 'package:vidspod_mobile/core/media/media_actions.dart';
import 'package:vidspod_mobile/core/polling/poll_policy.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/features/generations/presentation/widgets/video_player_widget.dart';
import 'package:vidspod_mobile/features/my_shorts/my_shorts_providers.dart';

/// Run monitoring per docs/MOBILE_APP_GUIDE.md §5.2 screens 4–5 and §5.3.
///
/// Polls `GET /my-shorts/{run_id}` on the §9 clock while the run is in flight,
/// renders `stage_label` / `stage_message` verbatim, and drives actions off the
/// `can_*` booleans. Completed runs play `playback_url` with save/share.
class RunDetailScreen extends ConsumerStatefulWidget {
  final String runId;
  const RunDetailScreen({super.key, required this.runId});

  @override
  ConsumerState<RunDetailScreen> createState() => _RunDetailScreenState();
}

class _RunDetailScreenState extends ConsumerState<RunDetailScreen>
    with WidgetsBindingObserver {
  PollPolicy? _policy;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startPolling();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _policy?.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final policy = _policy;
    if (policy == null) return;
    if (state == AppLifecycleState.resumed) {
      policy.resume();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      policy.pause();
    }
  }

  void _startPolling() {
    _policy = PollPolicy((_) async {
      ref.invalidate(shortRunProvider(widget.runId));
      await ref.read(shortRunProvider(widget.runId).future);
      if (!mounted) return;
      final run = ref.read(shortRunProvider(widget.runId)).valueOrNull;
      if (run == null) return;
      if (_isTerminal(run)) _policy?.stop();
    })..start();
  }

  bool _isTerminal(ShortRun run) {
    return run.playbackReady ||
        run.status == 'completed' ||
        run.status == 'failed' ||
        run.status == 'cancelled';
  }

  Future<void> _cancel() async {
    await ref.read(myShortsRepositoryProvider).cancel(widget.runId);
    ref.invalidate(shortRunProvider(widget.runId));
  }

  Future<void> _retry() async {
    await ref.read(myShortsRepositoryProvider).retry(widget.runId);
    ref.invalidate(shortRunProvider(widget.runId));
  }

  Future<void> _deleteMedia() async {
    await ref.read(myShortsRepositoryProvider).deleteMedia(widget.runId);
    ref.invalidate(shortRunProvider(widget.runId));
  }

  @override
  Widget build(BuildContext context) {
    final run = ref.watch(shortRunProvider(widget.runId));
    return Scaffold(
      backgroundColor: VrTheme.black,
      body: run.when(
        data: (r) => _RunDetailBody(
          run: r,
          onCancel: r.canCancel ? _cancel : null,
          onRetry: r.canRetry ? _retry : null,
          onDeleteMedia: r.canDeleteMedia ? _deleteMedia : null,
        ),
        loading: () => Center(child: platformLoader(size: 28)),
        error: (error, _) => AsyncStateView(
          loading: false,
          errorMessage: '$error',
          emptyMessage: '',
        ),
      ),
    );
  }
}

class _RunDetailBody extends StatelessWidget {
  final ShortRun run;
  final Future<void> Function()? onCancel;
  final Future<void> Function()? onRetry;
  final Future<void> Function()? onDeleteMedia;

  const _RunDetailBody({
    required this.run,
    this.onCancel,
    this.onRetry,
    this.onDeleteMedia,
  });

  bool get _playable =>
      run.playbackReady && (run.playbackUrl?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    final primary = _statusColor(run.status);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          backgroundColor: VrTheme.black,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                run.presetName,
                style: VrTheme.caption(fontWeight: FontWeight.w600),
              ),
            ),
            background: _playable
                ? VideoPlayerWidget(videoUrl: run.playbackUrl!)
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      AppNetworkImage(
                        url: run.referenceImageUrl,
                        placeholderIcon: Icons.video_library_outlined,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              VrTheme.black.withAlpha(200),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(140),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _statusIcon(run.status),
                            color: primary,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 18,
              ),
            ),
            onPressed: () => context.pop(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _statusCard(context),
                const SizedBox(height: 16),
                if (run.playbackReady) _resultActions(context),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (onRetry != null)
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.refresh,
                          label: 'Retry',
                          color: VrTheme.green,
                          onTap: onRetry,
                        ),
                      ),
                    if (onCancel != null) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.close,
                          label: 'Cancel',
                          color: VrTheme.orange,
                          onTap: onCancel,
                        ),
                      ),
                    ],
                    if (onDeleteMedia != null) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.delete_outline,
                          label: 'Delete media',
                          color: Colors.red,
                          onTap: onDeleteMedia,
                        ),
                      ),
                    ],
                  ],
                ),
                if (run.playbackReady) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => context.push('/get-started'),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: VrTheme.brandGradient,
                        boxShadow: VrTheme.buttonShadow(VrTheme.purple),
                      ),
                      child: const Center(
                        child: Text(
                          'Make another',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  Widget _statusCard(BuildContext context) {
    final primary = _statusColor(run.status);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VrTheme.surfaceDark,
        borderRadius: BorderRadius.circular(VrTheme.radiusLg),
        border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        boxShadow: VrTheme.cardShadow(VrTheme.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primary.withAlpha(40),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(_statusIcon(run.status), color: primary, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  run.statusLabel,
                  style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
                ),
              ),
              if (!run.playbackReady && run.status != 'failed')
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: VrTheme.purple,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            run.stageMessage,
            style: VrTheme.bodySmall(color: Colors.white.withAlpha(90)),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: run.playbackReady ? 1 : null,
            backgroundColor: VrTheme.cardBorder.withAlpha(50),
            color: primary,
            minHeight: 3,
            borderRadius: BorderRadius.circular(2),
          ),
          const SizedBox(height: 14),
          _InfoRow('Stage', run.stageLabel),
          _InfoRow('Aspect ratio', run.aspectRatio),
          _InfoRow('Duration', '${run.durationSeconds}s'),
          _InfoRow('Format', '${run.outputWidth}×${run.outputHeight}'),
          _InfoRow('Credits', _creditSummary(run)),
          if (run.refundStatus == 'refunded') ...[
            const SizedBox(height: 6),
            Text(
              'Credits refunded',
              style: VrTheme.caption(color: VrTheme.green),
            ),
          ],
        ],
      ),
    );
  }

  Widget _resultActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Share & save', style: VrTheme.headingSmall()),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: Icons.download_outlined,
                label: 'Save to gallery',
                color: Colors.white,
                filled: true,
                onTap: () => _saveToGallery(context),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
                color: Colors.white,
                onTap: () => _share(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _saveToGallery(BuildContext context) async {
    final url = run.playbackUrl;
    if (url == null) return;
    _snack(context, 'Saving to gallery…');
    final error = await MediaActions.downloadAndSave(url, isVideo: true);
    if (!context.mounted) return;
    _snack(context, error ?? 'Saved to gallery');
  }

  Future<void> _share(BuildContext context) async {
    final url = run.playbackUrl;
    if (url == null) return;
    await MediaActions.shareUrl(url, title: run.presetName);
  }

  String _creditSummary(ShortRun run) {
    final s = run.creditSettlement;
    final net = s.creditsCharged - s.creditsRefunded;
    if (net > 0) return '$net net';
    return '${s.creditsCharged} charged';
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
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: VrTheme.bodySmall(color: Colors.white.withAlpha(120)),
          ),
          const Spacer(),
          Text(value, style: VrTheme.bodySmall(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Future<void> Function()? onTap;
  final bool filled;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null
          ? null
          : () async {
              await onTap!();
            },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
          color: filled ? color.withAlpha(25) : Colors.transparent,
          border: filled ? null : Border.all(color: color.withAlpha(50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color.withAlpha(200), size: 16),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color.withAlpha(200),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
}
