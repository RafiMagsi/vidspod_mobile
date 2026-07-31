import 'package:flutter/material.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/widgets/app_category_section.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';

class SpeakScreen extends StatelessWidget {
  const SpeakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: VrTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Speak', style: VrTheme.headingLarge()),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.headphones,
                      color: Colors.white.withAlpha(150),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Listen',
                      style: VrTheme.bodySmall(
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withAlpha(150),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          VrTheme.purple,
                          VrTheme.pink,
                          VrTheme.orange,
                          VrTheme.purple,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: VrTheme.brandGradient,
                        ),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ANYONE SPEAK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap to start speaking',
                    style: VrTheme.bodyMedium(
                      color: Colors.white.withAlpha(80),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: _SpeakCategory('Vlog', 'vlog')),
          const SliverToBoxAdapter(child: _SpeakCategory('KOL', 'kol')),
          const SliverToBoxAdapter(child: _SpeakCategory('Voiceover', 'voice')),
          const SliverToBoxAdapter(child: _SpeakCategory('Podcast', 'podcast')),
          const SliverToBoxAdapter(
            child: _SpeakCategory('Narration', 'narrate'),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _SpeakCategory extends StatelessWidget {
  final String title;
  final String seed;
  const _SpeakCategory(this.title, this.seed);

  @override
  Widget build(BuildContext context) {
    return AppCategorySection(
      title: title,
      itemCount: 4,
      itemBuilder: (_, i) => AppMotionCard(
        imageUrl: 'https://picsum.photos/seed/speak-$seed$i/300/400',
        label: title,
        route: '/motions/speak-$seed$i',
        icon: Icons.record_voice_over_outlined,
      ),
    );
  }
}
