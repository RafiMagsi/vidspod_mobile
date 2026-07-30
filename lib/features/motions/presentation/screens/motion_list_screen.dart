import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';
import 'package:vidspod_mobile/core/widgets/staggered_fade_in.dart';
import 'package:vidspod_mobile/features/motions/motion_providers.dart';

class MotionListScreen extends ConsumerWidget {
  const MotionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motions = ref.watch(motionListProvider);
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      appBar: AppBar(title: Text('Motions', style: CreatiTheme.headingLarge())),
      body: motions.when(
        data: (motions) => Scrollbar(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: motions.length,
            itemBuilder: (_, index) {
              final motion = motions[index];
              return StaggeredFadeIn(
                index: index,
                child: AppMotionCard(
                  imageUrl: motion.thumbnailUrl,
                  label: motion.title,
                  route: '/motions/${motion.publicGuid}',
                  height: double.infinity,
                ),
              );
            },
          ),
        ),
        loading: () => Center(child: platformLoader(size: 28)),
        error: (error, _) => Center(
          child: Text(
            'Failed to load motions',
            style: CreatiTheme.bodyMedium(color: Colors.white.withAlpha(100)),
          ),
        ),
      ),
    );
  }
}
