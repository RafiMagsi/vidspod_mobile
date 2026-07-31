import 'package:flutter/material.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';

class ConnectedAccountsScreen extends StatelessWidget {
  const ConnectedAccountsScreen({super.key});

  static const _accounts = [
    _AccountItem(
      'Google',
      'google',
      Icons.g_mobiledata,
      Color(0xFF4285F4),
      'preview@vidspod.com',
    ),
    _AccountItem(
      'YouTube',
      'youtube',
      Icons.play_circle_fill,
      Color(0xFFFF0000),
      'TechChannel',
    ),
    _AccountItem(
      'LinkedIn',
      'linkedin',
      Icons.business,
      Color(0xFF0A66C2),
      null,
    ),
    _AccountItem(
      'Facebook',
      'facebook',
      Icons.facebook,
      Color(0xFF1877F2),
      'My Page',
    ),
    _AccountItem(
      'Instagram',
      'instagram',
      Icons.photo_camera,
      Color(0xFFE4405F),
      '@preview_creator',
    ),
    _AccountItem('TikTok', 'tiktok', Icons.music_note, Color(0xFF000000), null),
    _AccountItem(
      'Twitter / X',
      'twitter',
      Icons.alternate_email,
      Color(0xFF1DA1F2),
      '@vidspod_preview',
    ),
    _AccountItem(
      'Threads',
      'threads',
      Icons.text_fields,
      Color(0xFF000000),
      null,
    ),
    _AccountItem(
      'Canva',
      'canva',
      Icons.design_services,
      Color(0xFF00C4CC),
      null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VrTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: VrTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Connected Accounts', style: VrTheme.headingLarge()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Link your social and creative accounts to enable publishing, asset imports, and more.',
                style: VrTheme.caption(color: Colors.white.withAlpha(80)),
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
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(
            color: isConnected
                ? item.color.withAlpha(40)
                : VrTheme.cardBorder.withAlpha(60),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.color.withAlpha(20),
                borderRadius: BorderRadius.circular(VrTheme.radiusMd),
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
                    style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
                  ),
                  if (isConnected)
                    Text(
                      item.email!,
                      style: VrTheme.caption(
                        color: Colors.white.withAlpha(80),
                        fontSize: 11,
                      ),
                    )
                  else
                    Text(
                      'Not connected',
                      style: VrTheme.caption(
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
                    borderRadius: BorderRadius.circular(VrTheme.radiusFull),
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
                    gradient: item.color.toARGB32() == 0xFF000000
                        ? LinearGradient(
                            colors: [
                              Colors.grey.shade700,
                              Colors.grey.shade900,
                            ],
                          )
                        : LinearGradient(
                            colors: [item.color, item.color.withAlpha(180)],
                          ),
                    borderRadius: BorderRadius.circular(VrTheme.radiusFull),
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
