import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';
import 'package:vidspod_mobile/core/widgets/gradient_button.dart';
import 'package:vidspod_mobile/core/widgets/staggered_fade_in.dart';

class ShortsStudioScreen extends ConsumerWidget {
  const ShortsStudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _StudioAppBar(),
          const SliverToBoxAdapter(child: _StartButton()),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(child: _StudioChips()),
          const _StudioSection('Profile Photo', _ProfileGrid()),
          const _StudioSection('Trending', _MediaGrid()),
          const _StudioSection('Seedance 2.5 Video', _MediaGrid()),
          const _StudioSection('New Arrivals', _MediaGrid()),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: _StudioBottomNav(),
    );
  }
}

class _StudioAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 360,
      backgroundColor: CreatiTheme.black,
      pinned: true,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://picsum.photos/seed/studio/800/1200',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: CreatiTheme.darkSurface),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CreatiTheme.black.withAlpha(200),
                    Colors.transparent,
                    CreatiTheme.black.withAlpha(230),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              top: 52,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CreatiTheme.black.withAlpha(140),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.headset_mic_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            Positioned(
              top: 52,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: CreatiTheme.proGradient,
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                ),
                child: Text('PRO', style: CreatiTheme.label()),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text('SeeDance 2.5', style: CreatiTheme.displayLarge()),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
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

class _StudioChips extends StatelessWidget {
  const _StudioChips();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            const items = [
              'SeeDance',
              'Nano',
              'Banana',
              'Text to Video',
              'Image',
              'New',
              'Hot',
              'All',
            ];
            return GestureDetector(
              onTap: () => context.go('/motions'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: i >= 5
                      ? CreatiTheme.lightSurface
                      : CreatiTheme.darkSurface,
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                  border: Border.all(
                    color: i == 0
                        ? CreatiTheme.purple.withAlpha(100)
                        : CreatiTheme.cardBorder.withAlpha(60),
                  ),
                ),
                child: Text(
                  items[i],
                  style: TextStyle(
                    color: i == 0
                        ? CreatiTheme.purple.withAlpha(230)
                        : Colors.white,
                    fontSize: 13,
                    fontWeight: i == 0 ? FontWeight.w600 : FontWeight.w400,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StudioSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _StudioSection(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: CreatiTheme.headingMedium()),
                GestureDetector(
                  onTap: () => context.go('/motions'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(10),
                      borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'All',
                          style: CreatiTheme.bodySmall(
                            color: Colors.white.withAlpha(150),
                          ),
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white.withAlpha(100),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _ProfileGrid extends StatelessWidget {
  const _ProfileGrid();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, i) => StaggeredFadeIn(
          index: i,
          child: GestureDetector(
            onTap: () => context.push('/motions/studio-profile-$i'),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withAlpha(30), width: 2),
                color: CreatiTheme.mediumSurface,
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white.withAlpha(40),
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MediaGrid extends StatelessWidget {
  const _MediaGrid();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => StaggeredFadeIn(
          index: i,
          child: AppMotionCard(
            imageUrl: 'https://picsum.photos/seed/studio-card$i/300/400',
            label: 'AI Video ${i + 1}',
            route: '/motions/demo-media-${i + 1}',
          ),
        ),
      ),
    );
  }
}

class _StudioBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: CreatiTheme.surfaceDark, width: 0.5),
        ),
        color: Color(0xFF0C0C0C),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(Icons.person, 'Creator', true, () {}),
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
          color: selected
              ? CreatiTheme.purple.withAlpha(30)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? CreatiTheme.purple : CreatiTheme.textSecondary,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? CreatiTheme.purple
                    : CreatiTheme.textSecondary,
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
