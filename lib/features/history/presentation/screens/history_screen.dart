import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: VrTheme.black,
              surfaceTintColor: Colors.transparent,
              title: Text('History', style: VrTheme.headingLarge()),
            ),
            const SliverToBoxAdapter(child: _CreditsBanner()),
            const SliverToBoxAdapter(child: _AmbassadorCard()),
            const SliverToBoxAdapter(child: _HistoryTabBar()),
            const _HistoryGrid(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _CreditsBanner extends StatelessWidget {
  const _CreditsBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
          boxShadow: VrTheme.cardShadow(VrTheme.black),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: VrTheme.brandGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Credits',
                    style: VrTheme.bodyMedium(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '1,250 credits remaining',
                    style: VrTheme.bodySmall(
                      color: Colors.white.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: VrTheme.brandGradient,
                borderRadius: BorderRadius.circular(VrTheme.radiusXl),
                boxShadow: VrTheme.buttonShadow(VrTheme.purple),
              ),
              child: Text(
                'Buy',
                style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmbassadorCard extends StatelessWidget {
  const _AmbassadorCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [VrTheme.purple.withAlpha(30), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.purple.withAlpha(50)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Become an ambassador',
                    style: VrTheme.bodyMedium(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Earn rewards by referring friends',
                    style: VrTheme.bodySmall(
                      color: Colors.white.withAlpha(110),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: VrTheme.brandGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: VrTheme.buttonShadow(VrTheme.purple),
              ),
              child: Text(
                'Join',
                style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryTabBar extends StatelessWidget {
  const _HistoryTabBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      height: 40,
      decoration: BoxDecoration(
        color: VrTheme.surfaceDark,
        borderRadius: BorderRadius.circular(VrTheme.radiusMd),
        border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          gradient: VrTheme.brandGradient,
          borderRadius: BorderRadius.circular(VrTheme.radiusSm + 2),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: VrTheme.textSecondary,
        labelStyle: VrTheme.bodySmall(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        unselectedLabelStyle: VrTheme.bodySmall(fontSize: 11),
        dividerColor: Colors.transparent,
        isScrollable: true,
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Image'),
          Tab(text: 'Video'),
          Tab(text: 'Script'),
          Tab(text: 'Voice'),
        ],
      ),
    );
  }
}

class _HistoryGrid extends StatelessWidget {
  const _HistoryGrid();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate((_, i) {
          final types = ['Image', 'Video', 'Script', 'Voice', 'Image', 'Video'];
          final type = types[i % types.length];
          final iconMap = {
            'Image': Icons.image_outlined,
            'Video': Icons.videocam_outlined,
            'Script': Icons.article_outlined,
            'Voice': Icons.record_voice_over_outlined,
          };
          return GestureDetector(
            onTap: () {
              if (type == 'Image' || type == 'Video') {
                context.push('/generations/history-${i + 1}');
              } else if (type == 'Script') {
                context.push('/script-writer');
              } else if (type == 'Voice') {
                context.push('/voice-studio');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
                boxShadow: VrTheme.cardShadow(VrTheme.black),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    url: 'https://picsum.photos/seed/history$i/300/400',
                    placeholderIcon: iconMap[type] ?? Icons.history,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            VrTheme.black.withAlpha(200),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text('$type ${i + 1}', style: VrTheme.caption()),
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
                        iconMap[type] ?? Icons.history,
                        color: Colors.white.withAlpha(200),
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }, childCount: 8),
      ),
    );
  }
}
