import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/models/format_preset.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/app_category_section.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';
import 'package:vidspod_mobile/core/widgets/gradient_button.dart';
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
                itemBuilder: (_, i) => _MotionPresetCard(preset: items[i]),
              ),
              loading: () => _HubLoading(),
              error: (_, _) => AppCategorySection(
                title: 'Motions',
                itemCount: 3,
                itemHeight: _kMotionCardHeight,
                itemBuilder: (_, i) => AppMotionCard(
                  imageUrl: '',
                  label: 'Motion ${i + 1}',
                  height: _kMotionCardHeight,
                  route: '/motions/placeholder-$i',
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
      bottomNavigationBar: _StudioBottomNav(),
    );
  }
}

class _MotionPresetCard extends StatelessWidget {
  final FormatPreset preset;
  const _MotionPresetCard({required this.preset});

  @override
  Widget build(BuildContext context) {
    final isClone = preset.isCloneMotion;
    return GestureDetector(
      onTap: () => context.push(
        '/get-started',
        extra: {'motionId': preset.key, 'motionTitle': preset.label},
      ),
      child: Container(
        width: _kMotionCardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    url: preset.imageUrl,
                    placeholderIcon: Icons.movie_creation_outlined,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(140),
                        borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                      ),
                      child: Text(
                        isClone ? 'One-click clone' : 'Style reference',
                        style: VrTheme.caption(fontSize: 10),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(140),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white.withAlpha(220),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    preset.label,
                    style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    preset.aspectRatio ?? '9:16',
                    style: VrTheme.caption(color: Colors.white.withAlpha(80)),
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

class _HubLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(child: platformLoader(size: 28)),
    );
  }
}

class _StudioAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            AppNetworkImage(
              url: 'https://picsum.photos/seed/studio/800/1200',
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

class _StudioBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: VrTheme.surfaceDark, width: 0.5)),
        color: Color(0xFF0C0C0C),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                Icons.person,
                'Creator',
                true,
                () => context.go('/dashboard'),
              ),
              _NavItem(
                Icons.business_center_outlined,
                'Business',
                false,
                () => context.go('/business'),
              ),
              _NavItem(
                Icons.record_voice_over_outlined,
                'Speak',
                false,
                () => context.go('/speak'),
              ),
              _NavItem(
                Icons.build_outlined,
                'Tools',
                false,
                () => context.go('/tools'),
              ),
              _NavItem(
                Icons.history_outlined,
                'History',
                false,
                () => context.go('/history'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem(this.icon, this.label, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? VrTheme.purple.withAlpha(30) : Colors.transparent,
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? VrTheme.purple : VrTheme.textSecondary,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: selected ? VrTheme.purple : VrTheme.textSecondary,
                fontSize: 10,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
