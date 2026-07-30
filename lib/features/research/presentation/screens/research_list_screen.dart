import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/staggered_fade_in.dart';
import 'package:vidspod_mobile/features/research/research_providers.dart';

class ResearchListScreen extends ConsumerWidget {
  const ResearchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final researchRuns = ref.watch(researchRunsProvider);
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      appBar: AppBar(
        title: Text('Research', style: CreatiTheme.headingLarge()),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: CreatiTheme.darkSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: researchRuns.when(
        data: (runs) => runs.isEmpty
            ? Center(
                child: Text(
                  'No research runs yet',
                  style: CreatiTheme.bodyMedium(
                    color: Colors.white.withAlpha(80),
                  ),
                ),
              )
            : Scrollbar(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: runs.length,
                  itemBuilder: (_, i) {
                    final run = runs[i];
                    return StaggeredFadeIn(
                      index: i,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () => context.push('/research/${run.id}'),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: CreatiTheme.surfaceDark,
                              borderRadius: BorderRadius.circular(
                                CreatiTheme.radiusLg,
                              ),
                              border: Border.all(
                                color: CreatiTheme.cardBorder.withAlpha(60),
                              ),
                              boxShadow: CreatiTheme.cardShadow(
                                CreatiTheme.black,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: CreatiTheme.blue.withAlpha(30),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: run.status == 'running'
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: CreatiTheme.blue,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.science_outlined,
                                          color: CreatiTheme.blue,
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
                                        style: CreatiTheme.bodyMedium(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        run.status,
                                        style: CreatiTheme.caption(
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
                  },
                ),
              ),
        loading: () => Center(child: platformLoader(size: 28)),
        error: (error, _) => Center(
          child: Text(
            'Failed to load',
            style: CreatiTheme.bodyMedium(color: Colors.white.withAlpha(100)),
          ),
        ),
      ),
    );
  }
}
