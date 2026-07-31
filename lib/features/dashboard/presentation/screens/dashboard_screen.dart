import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/models/short_run.dart';
import 'package:vidspod_mobile/core/widgets/app_category_section.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';
import 'package:vidspod_mobile/core/widgets/gradient_button.dart';
import 'package:vidspod_mobile/features/billing/billing_providers.dart';
import 'package:vidspod_mobile/features/dashboard/dashboard_providers.dart';
import 'package:vidspod_mobile/features/my_shorts/my_shorts_providers.dart';

/// Home / Dashboard per docs/MOBILE_APP_GUIDE.md §5.1:
/// credit chip, "Create" CTA, in-progress runs carousel, recent grid, and
/// one-tap studio entries.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credits = ref.watch(creditsProvider);
    final runs = ref.watch(shortRunsProvider(null));
    final generations = ref.watch(recentGenerationsProvider);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _AppBar(credits: credits.valueOrNull?.balance),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(child: _StartButton()),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const SliverToBoxAdapter(child: _StudioEntries()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _InFlightRuns(runs: runs.valueOrNull ?? const []),
          SliverToBoxAdapter(
            child: generations.when(
              data: (gen) => AppCategorySection(
                title: 'Recent',
                itemCount: gen.isNotEmpty ? gen.length : 4,
                itemBuilder: (_, i) {
                  final url = gen.isNotEmpty
                      ? gen[i % gen.length].thumbnailUrl
                      : null;
                  return AppMotionCard(
                    imageUrl:
                        url ?? 'https://picsum.photos/seed/recent$i/300/400',
                    label: gen.isNotEmpty
                        ? gen[i % gen.length].status
                        : 'AI Generated',
                    route: '/generations/history-${i + 1}',
                  );
                },
              ),
              loading: () => AppCategorySection(
                title: 'Recent',
                itemCount: 4,
                itemBuilder: (_, i) => AppMotionCard(
                  imageUrl: '',
                  label: 'AI Generated',
                  route: '/motions/placeholder-$i',
                ),
              ),
              error: (_, _) => AppCategorySection(
                title: 'Recent',
                itemCount: 4,
                itemBuilder: (_, i) => AppMotionCard(
                  imageUrl: '',
                  label: 'AI Generated',
                  route: '/motions/placeholder-$i',
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final int? credits;
  const _AppBar({required this.credits});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: VrTheme.black,
      surfaceTintColor: Colors.transparent,
      title: Text('Home', style: VrTheme.headingSmall()),
      actions: [
        GestureDetector(
          onTap: () => context.push('/plan-billing'),
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: VrTheme.darkSurface,
              borderRadius: BorderRadius.circular(VrTheme.radiusFull),
              border: Border.all(color: VrTheme.cardBorder.withAlpha(80)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.bolt, color: VrTheme.amber, size: 15),
                const SizedBox(width: 5),
                Text(
                  '${credits ?? '…'}',
                  style: VrTheme.label(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: VrTheme.darkSurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, size: 20),
          ),
          onPressed: () => context.push('/profile'),
        ),
        const SizedBox(width: 4),
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
        text: 'Create a Short',
        onPressed: () => context.push('/studio'),
        icon: Icons.add_photo_alternate_outlined,
      ),
    );
  }
}

/// One-tap studio entries driven from §5.1's "studios list" — surfaced as
/// quick links per the guide's one-tap requirement.
class _StudioEntries extends StatelessWidget {
  const _StudioEntries();

  static const _entries = [
    (Icons.bolt_outlined, 'Shorts', '/studio'),
    (Icons.image_outlined, 'Images', '/image-studio'),
    (Icons.record_voice_over_outlined, 'Voice', '/voice-studio'),
    (Icons.article_outlined, 'Script', '/script-writer'),
    (Icons.science_outlined, 'Research', '/research'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _entries.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final (icon, label, route) = _entries[i];
          return GestureDetector(
            onTap: () => context.push(route),
            child: Container(
              width: 84,
              decoration: BoxDecoration(
                color: VrTheme.darkSurface,
                borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: VrTheme.purple, size: 26),
                  const SizedBox(height: 8),
                  Text(label, style: VrTheme.caption()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// In-progress runs carousel (§5.1). Tapping opens My Shorts monitoring.
class _InFlightRuns extends StatelessWidget {
  final List<ShortRun> runs;
  const _InFlightRuns({required this.runs});

  @override
  Widget build(BuildContext context) {
    final inFlight = runs.where((r) => !r.playbackReady).toList();
    if (inFlight.isEmpty) return const SliverToBoxAdapter(child: SizedBox());

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('In progress', style: VrTheme.headingMedium()),
                GestureDetector(
                  onTap: () => context.push('/my-shorts'),
                  child: Text(
                    'See all',
                    style: VrTheme.bodySmall(
                      color: VrTheme.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: inFlight.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final run = inFlight[i];
                return GestureDetector(
                  onTap: () => context.push('/my-shorts'),
                  child: Container(
                    width: 240,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: VrTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                      border: Border.all(
                        color: VrTheme.cardBorder.withAlpha(60),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: VrTheme.blue.withAlpha(40),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.hourglass_top,
                            color: VrTheme.blue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                run.presetName,
                                style: VrTheme.bodySmall(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                run.stageMessage,
                                style: VrTheme.caption(
                                  color: Colors.white.withAlpha(80),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
