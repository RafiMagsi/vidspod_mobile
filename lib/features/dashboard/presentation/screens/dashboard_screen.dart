import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/widgets/app_category_section.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';
import 'package:vidspod_mobile/core/widgets/gradient_button.dart';
import 'package:vidspod_mobile/features/dashboard/dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generations = ref.watch(recentGenerationsProvider);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _AppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(child: _StartButton()),
          const SliverToBoxAdapter(child: SizedBox(height: 4)),
          const SliverToBoxAdapter(child: _ChipsRow()),
          const _ProfilePhotos(),
          SliverToBoxAdapter(
            child: generations.when(
              data: (gen) => AppCategorySection(
                title: 'Trending',
                itemCount: 4,
                itemBuilder: (_, i) {
                  final url = gen.isNotEmpty ? gen[i % gen.length].thumbnailUrl : null;
                  return AppMotionCard(
                    imageUrl: url ?? 'https://picsum.photos/seed/trend$i/300/400',
                    label: 'AI Generated',
                    route: '/motions/demo-motion-${i + 1}',
                  );
                },
              ),
              loading: () => _CardPlaceholderRow(title: 'Trending'),
              error: (_, __) => _CardPlaceholderRow(title: 'Trending'),
            ),
          ),
          const SliverToBoxAdapter(child: _VideoSection('SeeDance 2.5 Video', 'demo-video')),
          const SliverToBoxAdapter(child: _VideoSection('New Arrivals', 'demo-media')),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: CreatiTheme.black,
      surfaceTintColor: Colors.transparent,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SeeDance 2.5', style: CreatiTheme.headingSmall()),
          const SizedBox(width: 3),
          Icon(Icons.keyboard_arrow_down, color: Colors.white.withAlpha(128), size: 18),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            gradient: CreatiTheme.proGradient,
            borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          ),
          child: Text('PRO', style: CreatiTheme.label()),
        ),
      ],
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GradientButton(
        text: 'Start From Photo',
        onPressed: () => context.push('/studio'),
        icon: Icons.add_photo_alternate_outlined,
      ),
    );
  }
}

class _ChipsRow extends StatelessWidget {
  const _ChipsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 7,
          separatorBuilder: (_, __) => const SizedBox(width: 6),
          itemBuilder: (_, i) {
            if (i == 0) return _chip('New', CreatiTheme.green, () => context.go('/motions'));
            if (i == 1) return _chip('Hot', CreatiTheme.orange, () => context.go('/motions'));
            return _chip(['SeeDance', 'Nano', 'Banana', 'Text to Video', 'Image'][i - 2], null, () => context.go('/motions'));
          },
        ),
      ),
    );
  }

  Widget _chip(String label, Color? dot, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: dot != null ? 10 : 14, vertical: 7),
        decoration: BoxDecoration(
          color: CreatiTheme.darkSurface,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(80)),
        ),
        child: dot != null
            ? Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
                const SizedBox(width: 5),
                Text(label, style: CreatiTheme.bodySmall()),
              ])
            : Text(label, style: CreatiTheme.bodySmall()),
      ),
    );
  }
}

class _ProfilePhotos extends StatelessWidget {
  const _ProfilePhotos();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Text('Profile Photo', style: CreatiTheme.headingMedium()),
        ),
        SizedBox(
          height: 88,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, i) {
              final colors = [CreatiTheme.purple, CreatiTheme.pink, CreatiTheme.orange, CreatiTheme.blue, CreatiTheme.deepPurple, CreatiTheme.green];
              return GestureDetector(
                onTap: () => context.push('/motions/profile-$i'),
                child: Container(
                  width: 74, height: 74,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(colors: [colors[i], colors[(i + 1) % colors.length], colors[(i + 2) % colors.length], colors[i]]),
                  ),
                  padding: const EdgeInsets.all(2.5),
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: CreatiTheme.darkSurface),
                    child: Center(
                      child: Icon(Icons.person, color: CreatiTheme.textSecondary.withAlpha(60), size: 28),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 4),
      ]),
    );
  }
}

class _VideoSection extends StatelessWidget {
  final String title;
  final String seed;
  const _VideoSection(this.title, this.seed);

  @override
  Widget build(BuildContext context) {
    return AppCategorySection(
      title: title,
      itemCount: 4,
      itemBuilder: (_, i) => AppMotionCard(
        imageUrl: 'https://picsum.photos/seed/$seed$i/300/400',
        label: 'Motion Video',
        route: '/motions/$seed-${i + 1}',
        icon: Icons.play_circle_outline,
      ),
    );
  }
}

class _CardPlaceholderRow extends StatelessWidget {
  final String title;
  const _CardPlaceholderRow({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppCategorySection(
      title: title,
      itemCount: 4,
      itemBuilder: (_, i) => AppMotionCard(
        imageUrl: '',
        label: 'AI Generated',
        route: '/motions/placeholder-$i',
      ),
    );
  }
}
