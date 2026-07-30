import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class ConnectedAccountsScreen extends StatelessWidget {
  const ConnectedAccountsScreen({super.key});

  static const _accounts = [
    _AccountItem(
      'Google',
      'google',
      Icons.g_mobiledata,
      const Color(0xFF4285F4),
      'preview@vidspod.com',
    ),
    _AccountItem(
      'YouTube',
      'youtube',
      Icons.play_circle_fill,
      const Color(0xFFFF0000),
      'TechChannel',
    ),
    _AccountItem(
      'LinkedIn',
      'linkedin',
      Icons.business,
      const Color(0xFF0A66C2),
      null,
    ),
    _AccountItem(
      'Facebook',
      'facebook',
      Icons.facebook,
      const Color(0xFF1877F2),
      'My Page',
    ),
    _AccountItem(
      'Instagram',
      'instagram',
      Icons.photo_camera,
      const Color(0xFFE4405F),
      '@preview_creator',
    ),
    _AccountItem(
      'TikTok',
      'tiktok',
      Icons.music_note,
      const Color(0xFF000000),
      null,
    ),
    _AccountItem(
      'Twitter / X',
      'twitter',
      Icons.alternate_email,
      const Color(0xFF1DA1F2),
      '@vidspod_preview',
    ),
    _AccountItem(
      'Threads',
      'threads',
      Icons.text_fields,
      const Color(0xFF000000),
      null,
    ),
    _AccountItem(
      'Canva',
      'canva',
      Icons.design_services,
      const Color(0xFF00C4CC),
      null,
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
            title: Text(
              'Connected Accounts',
              style: CreatiTheme.headingLarge(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Link your social and creative accounts to enable publishing, asset imports, and more.',
                style: CreatiTheme.caption(color: Colors.white.withAlpha(80)),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _AccountCard(item: _accounts[i]),
                childCount: _accounts.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _AccountItem {
  final String name;
  final String id;
  final IconData icon;
  final Color color;
  final String? email;
  const _AccountItem(this.name, this.id, this.icon, this.color, this.email);
}

class _AccountCard extends StatelessWidget {
  final _AccountItem item;
  const _AccountCard({required this.item});

  bool get isConnected => item.email != null;

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
            color: isConnected
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
                  if (isConnected)
                    Text(
                      item.email!,
                      style: CreatiTheme.caption(
                        color: Colors.white.withAlpha(80),
                        fontSize: 11,
                      ),
                    )
                  else
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
            if (isConnected)
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} disconnected')),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(15),
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                    border: Border.all(color: Colors.red.withAlpha(50)),
                  ),
                  child: Text(
                    'Disconnect',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red.withAlpha(180),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Connecting ${item.name}...')),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: item.color.value == 0xFF000000
                        ? LinearGradient(
                            colors: [
                              Colors.grey.shade700,
                              Colors.grey.shade900,
                            ],
                          )
                        : LinearGradient(
                            colors: [item.color, item.color.withAlpha(180)],
                          ),
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                  ),
                  child: Text(
                    'Connect',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
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
