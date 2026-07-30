import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/features/generations/generation_providers.dart';
import 'package:vidspod_mobile/features/generations/presentation/widgets/video_player_widget.dart';

class GenerationDetailScreen extends ConsumerWidget {
  final String id;
  const GenerationDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generation = ref.watch(generationProvider(id));
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: generation.when(
        data: (gen) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: CreatiTheme.black,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('Generation ${gen.id.substring(0, 8)}...', style: CreatiTheme.caption(fontWeight: FontWeight.w600)),
                ),
                background: gen.videoUrl != null
                    ? VideoPlayerWidget(videoUrl: gen.videoUrl!)
                    : Container(
                        color: CreatiTheme.darkSurface,
                        child: const Center(child: Icon(Icons.videocam_off_outlined, color: Colors.white24, size: 48)),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CreatiTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                    border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
                    boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Details', style: CreatiTheme.headingSmall()),
                    const SizedBox(height: 14),
                    _DetailRow(Icons.tag, 'ID', gen.id),
                    _DetailRow(Icons.sync, 'Status', gen.status),
                    _DetailRow(Icons.lan, 'Workflow', gen.workflowType),
                    _DetailRow(Icons.percent, 'Progress', '${gen.progress}%', trailing: gen.status != 'complete'
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: CreatiTheme.purple))
                        : null),
                  ]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                child: Row(children: [
                  Expanded(child: _ActionChip(Icons.download_outlined, 'Download', () {}, outlined: false)),
                  const SizedBox(width: 10),
                  Expanded(child: _ActionChip(Icons.share_outlined, 'Share', () {}, outlined: true)),
                  if (gen.status == 'failed') ...[
                    const SizedBox(width: 10),
                    Expanded(child: _ActionChip(Icons.refresh_outlined, 'Retry', () {}, outlined: false, danger: true)),
                  ],
                ]),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: CreatiTheme.purple)),
        error: (error, _) => Center(child: Text('Error: $error', style: const TextStyle(color: Colors.white38))),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;
  const _DetailRow(this.icon, this.label, this.value, {this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(icon, color: Colors.white.withAlpha(100), size: 18),
        const SizedBox(width: 12),
        Text(label, style: CreatiTheme.bodySmall(color: Colors.white.withAlpha(150))),
        const Spacer(),
        Text(value, style: CreatiTheme.bodySmall(fontWeight: FontWeight.w500)),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ]),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  final bool danger;
  const _ActionChip(this.icon, this.label, this.onTap, {this.outlined = false, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
          color: outlined ? Colors.transparent : (danger ? Colors.red.withAlpha(30) : CreatiTheme.purple.withAlpha(30)),
          border: outlined ? Border.all(color: Colors.white.withAlpha(30)) : null,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: danger ? Colors.red.withAlpha(200) : Colors.white.withAlpha(200), size: 16),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: danger ? Colors.red.withAlpha(200) : Colors.white.withAlpha(200), fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.15)),
        ]),
      ),
    );
  }
}
