import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class PublishingScreen extends StatelessWidget {
  const PublishingScreen({super.key});

  static const _platforms = [
    _PlatformItem(
      'YouTube',
      'youtube',
      Icons.play_circle_fill,
      const Color(0xFFFF0000),
      true,
      'TechChannel',
    ),
    _PlatformItem(
      'Facebook',
      'facebook',
      Icons.facebook,
      const Color(0xFF1877F2),
      true,
      'My Page',
    ),
    _PlatformItem(
      'Instagram',
      'instagram',
      Icons.photo_camera,
      const Color(0xFFE4405F),
      true,
      '@myhandle',
    ),
    _PlatformItem(
      'TikTok',
      'tiktok',
      Icons.music_note,
      const Color(0xFF000000),
      false,
      null,
    ),
    _PlatformItem(
      'LinkedIn',
      'linkedin',
      Icons.business,
      const Color(0xFF0A66C2),
      false,
      null,
    ),
  ];

  static const _recentPubs = [
    _PubItem(
      'Summer Sale Promo',
      'YouTube, Instagram',
      'Published',
      '2 days ago',
      '1.2K views',
    ),
    _PubItem(
      'Product Launch Teaser',
      'YouTube',
      'Scheduled',
      'Mar 15, 2026',
      '-',
    ),
    _PubItem(
      'Behind the Scenes',
      'Instagram, TikTok',
      'Failed',
      '1 week ago',
      '-',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: CreatiTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Publishing', style: CreatiTheme.headingLarge()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Connected Platforms',
                style: CreatiTheme.headingMedium(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _PlatformCard(item: _platforms[i]),
                childCount: _platforms.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Text(
                    'Recent Publications',
                    style: CreatiTheme.headingMedium(),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('New publication flow')),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: CreatiTheme.brandGradient,
                        borderRadius: BorderRadius.circular(
                          CreatiTheme.radiusFull,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'New',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _PublicationCard(item: _recentPubs[i]),
                childCount: _recentPubs.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _PlatformItem {
  final String name;
  final String id;
  final IconData icon;
  final Color color;
  final bool connected;
  final String? accountName;
  const _PlatformItem(
    this.name,
    this.id,
    this.icon,
    this.color,
    this.connected,
    this.accountName,
  );
}

class _PubItem {
  final String title;
  final String platforms;
  final String status;
  final String date;
  final String analytics;
  const _PubItem(
    this.title,
    this.platforms,
    this.status,
    this.date,
    this.analytics,
  );
}

class _PlatformCard extends StatelessWidget {
  final _PlatformItem item;
  const _PlatformCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(
            color: item.connected
                ? item.color.withAlpha(40)
                : CreatiTheme.cardBorder.withAlpha(60),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.color.withAlpha(20),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
              ),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
                  ),
                  if (item.connected && item.accountName != null)
                    Text(
                      item.accountName!,
                      style: CreatiTheme.caption(
                        color: Colors.white.withAlpha(80),
                        fontSize: 11,
                      ),
                    ),
                  if (!item.connected)
                    Text(
                      'Not connected',
                      style: CreatiTheme.caption(
                        color: Colors.white.withAlpha(50),
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ),
            if (item.connected)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: CreatiTheme.green.withAlpha(20),
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: CreatiTheme.green, size: 12),
                    SizedBox(width: 4),
                    Text(
                      'Connected',
                      style: TextStyle(
                        fontSize: 10,
                        color: CreatiTheme.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            else
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Connect ${item.name}'))),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: item.color.withAlpha(80)),
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                  ),
                  child: Text(
                    'Connect',
                    style: TextStyle(
                      fontSize: 11,
                      color: item.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PublicationCard extends StatelessWidget {
  final _PubItem item;
  const _PublicationCard({required this.item});

  Color get _statusColor {
    switch (item.status) {
      case 'Published':
        return CreatiTheme.green;
      case 'Scheduled':
        return CreatiTheme.blue;
      case 'Failed':
        return Colors.red;
      default:
        return Colors.white38;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: CreatiTheme.bodySmall(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                  ),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: _statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.share_outlined,
                  color: Colors.white.withAlpha(60),
                  size: 12,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item.platforms,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withAlpha(70),
                    ),
                  ),
                ),
                Text(
                  item.date,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withAlpha(50),
                  ),
                ),
              ],
            ),
            if (item.analytics != '-' && item.status == 'Published') ...[
              const SizedBox(height: 4),
              Text(
                item.analytics,
                style: TextStyle(
                  fontSize: 10,
                  color: CreatiTheme.purple.withAlpha(150),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
