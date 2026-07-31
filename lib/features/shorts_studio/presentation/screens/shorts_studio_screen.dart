import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/app_category_section.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';
import 'package:vidspod_mobile/core/widgets/gradient_button.dart';
import 'package:vidspod_mobile/core/widgets/hero_video_background.dart';
import 'package:vidspod_mobile/features/shorts_studio/presentation/widgets/motion_preset_card.dart';
import 'package:vidspod_mobile/features/shorts_studio/shorts_studio_providers.dart';

/// Shorts Studio ⭐ per docs/MOBILE_APP_GUIDE.md §5.2.
///
/// Renders `format_presets` exactly as returned by `/generate/hub` —
/// never filtered client-side. Selecting a Motion preselects it in
/// Get Started (the form hydration happens on that screen).
/// 9:16 card ratio for the 150px-wide motion preset cards.
const double _kMotionCardWidth = 150;
const double _kMotionCardHeight = _kMotionCardWidth * 16 / 9; // ≈ 267

class ShortsStudioScreen extends ConsumerWidget {
  const ShortsStudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presets = ref.watch(shortStudioPresetsProvider);
    return Scaffold(
      backgroundColor: VrTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _StudioAppBar(),
          const SliverToBoxAdapter(child: _StartButton()),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: presets.when(
              data: (items) => AppCategorySection(
                title: 'Motions',
                itemCount: items.length,
                itemHeight: _kMotionCardHeight,
                onAllTap: () => context.push('/studio/motions'),
                itemBuilder: (_, i) =>
                    MotionPresetCard(preset: items[i], autoPlay: false),
              ),
              loading: () => _HubLoading(),
              error: (_, _) => AppCategorySection(
                title: 'Motions',
                itemCount: 3,
                itemHeight: _kMotionCardHeight,
                onAllTap: () => context.push('/studio/motions'),
                itemBuilder: (_, i) => AppMotionCard(
                  imageUrl: '',
                  label: 'Motion ${i + 1}',
                  height: _kMotionCardHeight,
                  route: '/motions',
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: _MoreStudiosSection()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

/// Quick entry into the other hub-driven studios (§5.5). The list is the
/// well-known set of flow categories until `/dashboard → studios[]` drives it.
class _MoreStudiosSection extends StatelessWidget {
  const _MoreStudiosSection();

  static const _studios = [
    (Icons.auto_awesome, 'ai-video-studio', 'AI Video'),
    (Icons.movie_creation_outlined, 'full-auto-studio', 'Full Auto'),
    (Icons.theaters_outlined, 'cinema-studio', 'Cinema'),
    (Icons.shopping_bag_outlined, 'marketing-studio', 'Marketing'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Text('More ways to create', style: VrTheme.headingMedium()),
        ),
        SizedBox(
          height: 104,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _studios.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (_, i) {
              final (icon, category, label) = _studios[i];
              return GestureDetector(
                onTap: () => context.push(
                  '/studio/$category/${Uri.encodeComponent(label)}',
                ),
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: VrTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                    border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: VrTheme.purple, size: 28),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HubLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(child: platformLoader(size: 28)),
    );
  }
}

class _StudioAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hub = ref.watch(generateHubProvider('short-studio'));
    final heroVideo = hub.valueOrNull?.heroBackgroundVideo;
    return SliverAppBar(
      expandedHeight: 240,
      backgroundColor: VrTheme.black,
      pinned: true,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            HeroVideoBackground(
              videoUrl: heroVideo,
              fallbackImageUrl: 'https://picsum.photos/seed/studio/800/1200',
              placeholderIcon: Icons.movie_creation_outlined,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    VrTheme.black.withAlpha(200),
                    Colors.transparent,
                    VrTheme.black.withAlpha(230),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text('Shorts Studio', style: VrTheme.displayLarge()),
                  const SizedBox(height: 8),
                  Text(
                    'Pick a Motion, attach a photo, get a 9:16 video',
                    style: VrTheme.bodySmall(
                      color: Colors.white.withAlpha(160),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: GradientButton(
        text: 'Start From Photo',
        onPressed: () => context.push('/get-started'),
        icon: Icons.photo_camera_outlined,
        height: 58,
      ),
    );
  }
}
