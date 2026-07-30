import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/features/research/research_providers.dart';

class ResearchDetailScreen extends ConsumerWidget {
  final String id;
  const ResearchDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final researchRun = ref.watch(researchRunProvider(id));
    final researchResults = ref.watch(researchRunResultsProvider(id));
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: researchRun.when(
        data: (run) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text(run.topic, style: CreatiTheme.headingSmall()),
              pinned: true,
              backgroundColor: CreatiTheme.black,
              surfaceTintColor: Colors.transparent,
              actions: [
                if (run.status == 'running')
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: CreatiTheme.darkSurface, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.cancel_outlined, color: Colors.white, size: 20),
                    ),
                    onPressed: () {},
                  ),
              ],
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
                    _DetailRow(Icons.tag, 'ID', run.id),
                    _DetailRow(Icons.sync, 'Status', run.status,
                        trailing: run.status == 'running'
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: CreatiTheme.purple))
                            : null),
                  ]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text('Results', style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600, color: Colors.white.withAlpha(150))),
              ),
            ),
            researchResults.when(
              data: (results) => results.isEmpty
                  ? SliverToBoxAdapter(child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('No results yet', style: CreatiTheme.bodySmall(color: Colors.white.withAlpha(60))),
                    ))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: CreatiTheme.surfaceDark,
                              borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                              border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
                            ),
                            child: Text(results[i].content, style: CreatiTheme.bodySmall()),
                          ),
                        ),
                        childCount: results.length,
                      ),
                    ),
              loading: () => const SliverToBoxAdapter(child: Center(child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(color: CreatiTheme.purple),
              ))),
              error: (error, _) => SliverToBoxAdapter(child: Center(child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('Error: $error', style: CreatiTheme.bodySmall(color: Colors.white.withAlpha(100))),
              ))),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                child: Row(children: [
                  Expanded(child: _ActionChip(Icons.save_alt_outlined, 'Save', () {}, outlined: false)),
                  const SizedBox(width: 10),
                  Expanded(child: _ActionChip(Icons.share_outlined, 'Share', () {}, outlined: true)),
                  const SizedBox(width: 10),
                  Expanded(child: _ActionChip(Icons.upload_file_outlined, 'Export', () {}, outlined: true)),
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
  const _ActionChip(this.icon, this.label, this.onTap, {this.outlined = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
          color: outlined ? Colors.transparent : CreatiTheme.purple.withAlpha(30),
          border: outlined ? Border.all(color: Colors.white.withAlpha(30)) : null,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: Colors.white.withAlpha(200), size: 16),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.15)),
        ]),
      ),
    );
  }
}
