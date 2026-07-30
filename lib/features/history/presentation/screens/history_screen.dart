import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/widgets/app_placeholder.dart';
import 'package:vidspod_mobile/core/widgets/shimmer_widget.dart';

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
              backgroundColor: CreatiTheme.black,
              surfaceTintColor: Colors.transparent,
              title: Text('History', style: CreatiTheme.headingLarge()),
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
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: CreatiTheme.brandGradient,
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
                    style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '1,250 credits remaining',
                    style: CreatiTheme.bodySmall(
                      color: Colors.white.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: CreatiTheme.brandGradient,
                borderRadius: BorderRadius.circular(CreatiTheme.radiusXl),
                boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
              ),
              child: Text(
                'Buy',
                style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600),
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
            colors: [CreatiTheme.purple.withAlpha(30), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.purple.withAlpha(50)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Become an ambassador',
                    style: CreatiTheme.bodyMedium(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Earn rewards by referring friends',
                    style: CreatiTheme.bodySmall(
                      color: Colors.white.withAlpha(110),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: CreatiTheme.brandGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
              ),
              child: Text(
                'Join',
                style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600),
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
        color: CreatiTheme.surfaceDark,
        borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
        border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          gradient: CreatiTheme.brandGradient,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusSm + 2),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: CreatiTheme.textSecondary,
        labelStyle: CreatiTheme.bodySmall(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        unselectedLabelStyle: CreatiTheme.bodySmall(fontSize: 11),
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
            onTap: () => context.push('/motions/history-${i + 1}'),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
                boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/seed/history$i/300/400',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const ShimmerWidget(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    errorWidget: (_, __, ___) =>
                        AppPlaceholder(icon: iconMap[type] ?? Icons.history),
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
                            CreatiTheme.black.withAlpha(200),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        '$type ${i + 1}',
                        style: CreatiTheme.caption(),
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
