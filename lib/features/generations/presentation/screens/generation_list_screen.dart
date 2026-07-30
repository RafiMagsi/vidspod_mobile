import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/staggered_fade_in.dart';
import 'package:vidspod_mobile/features/generations/generation_providers.dart';

class GenerationListScreen extends ConsumerWidget {
  const GenerationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generations = ref.watch(generationHistoryProvider);
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      appBar: AppBar(
        title: Text('Generations', style: CreatiTheme.headingLarge()),
      ),
      body: generations.when(
        data: (items) => items.isEmpty
            ? Center(
                child: Text(
                  'No generations yet',
                  style: CreatiTheme.bodyMedium(
                    color: Colors.white.withAlpha(80),
                  ),
                ),
              )
            : Scrollbar(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final gen = items[i];
                    return StaggeredFadeIn(
                      index: i,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () => context.push('/generations/${gen.id}'),
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
                                    color: gen.status == 'complete'
                                        ? CreatiTheme.green.withAlpha(40)
                                        : CreatiTheme.blue.withAlpha(40),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    gen.status == 'complete'
                                        ? Icons.check_circle
                                        : Icons.hourglass_empty,
                                    color: gen.status == 'complete'
                                        ? CreatiTheme.green
                                        : CreatiTheme.blue,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        gen.id,
                                        style: CreatiTheme.bodyMedium(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        gen.status,
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
