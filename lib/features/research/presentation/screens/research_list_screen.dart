import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/core/widgets/staggered_fade_in.dart';
import 'package:vidspod_mobile/features/research/domain/research_tool.dart';
import 'package:vidspod_mobile/features/research/research_providers.dart';

/// Research suite per docs/MOBILE_APP_GUIDE.md §5.9.
///
/// Mobile pattern: a single "Research" tab → tool grid → each tool is a
/// search-input → result cards → save/export → "turn into a script/video".
class ResearchListScreen extends ConsumerWidget {
  const ResearchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final researchRuns = ref.watch(researchRunsProvider);
    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(title: Text('Research', style: VrTheme.headingLarge())),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Text('Tools', style: VrTheme.headingMedium()),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) => _ToolCard(tool: ResearchTool.all[i], index: i),
                childCount: ResearchTool.all.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text('Saved research', style: VrTheme.headingMedium()),
            ),
          ),
          researchRuns.when(
            data: (runs) => runs.isEmpty
                ? const SliverToBoxAdapter(
                    child: AsyncStateView(
                      loading: false,
                      emptyMessage: 'No research runs yet',
                      emptyIcon: Icons.science_outlined,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate((_, i) {
                      final run = runs[i];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                        child: StaggeredFadeIn(
                          index: i,
                          child: GestureDetector(
                            onTap: () => context.push('/research/${run.id}'),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: VrTheme.surfaceDark,
                                borderRadius: BorderRadius.circular(
                                  VrTheme.radiusLg,
                                ),
                                border: Border.all(
                                  color: VrTheme.cardBorder.withAlpha(60),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: VrTheme.blue.withAlpha(30),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: run.status == 'running'
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: VrTheme.blue,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.science_outlined,
                                            color: VrTheme.blue,
                                            size: 20,
                                          ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          run.topic,
                                          style: VrTheme.bodyMedium(
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          run.status,
                                          style: VrTheme.caption(
                                            color: Colors.white.withAlpha(80),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.white.withAlpha(60),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }, childCount: runs.length),
                  ),
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: AsyncStateView(loading: true, emptyMessage: ''),
              ),
            ),
            error: (error, _) => SliverToBoxAdapter(
              child: AsyncStateView(
                loading: false,
                errorMessage: '$error',
                emptyMessage: '',
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final ResearchTool tool;
  final int index;
  const _ToolCard({required this.tool, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/research/tools/${tool.key}',
        extra: {'tool': tool.key},
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: tool.color.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: tool.color.withAlpha(25),
                borderRadius: BorderRadius.circular(VrTheme.radiusSm),
              ),
              child: Icon(tool.icon, color: tool.color, size: 20),
            ),
            const Spacer(),
            Text(
              tool.title,
              style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              tool.subtitle,
              style: VrTheme.caption(color: Colors.white.withAlpha(80)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
