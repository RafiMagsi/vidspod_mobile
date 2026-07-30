import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  static const List<_ToolItem> _tools = [
    _ToolItem(
      'Image Studio',
      'Create and edit AI images',
      Icons.image_outlined,
      '/image-studio',
    ),
    _ToolItem(
      'Voice Studio',
      'Generate AI voiceovers',
      Icons.record_voice_over_outlined,
      '/voice-studio',
    ),
    _ToolItem(
      'Research Tools',
      'Market & trend research',
      Icons.science_outlined,
      '/research',
    ),
    _ToolItem(
      'Script Writer',
      'AI-powered script generation',
      Icons.article_outlined,
      '/script-writer',
    ),
    _ToolItem(
      'YouTube Download',
      'Download videos & audio',
      Icons.download_outlined,
      '/youtube-download',
    ),
    _ToolItem(
      'Publishing',
      'Publish to social platforms',
      Icons.share_outlined,
      '/publishing',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: Scrollbar(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: CreatiTheme.black,
              surfaceTintColor: Colors.transparent,
              title: Text('Tools', style: CreatiTheme.headingLarge()),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _ToolCard(item: _tools[i], index: i),
                  childCount: _tools.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? route;
  const _ToolItem(this.title, this.subtitle, this.icon, this.route);
}

class _ToolCard extends StatelessWidget {
  final _ToolItem item;
  final int index;
  const _ToolCard({required this.item, required this.index});

  static const _gradients = [
    CreatiTheme.brandGradient,
    CreatiTheme.proGradient,
    LinearGradient(colors: [Color(0xFF00B4DB), Color(0xFF0083B0)]),
    LinearGradient(colors: [Color(0xFFF857A6), Color(0xFFFF5858)]),
    LinearGradient(colors: [Color(0xFF4CB8C4), Color(0xFF3CD3AD)]),
    LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.route != null) {
          context.push(item.route!);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: _gradients[index % _gradients.length],
                borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
              ),
              child: Icon(item.icon, color: Colors.white, size: 22),
            ),
            const Spacer(),
            Text(
              item.title,
              style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              style: CreatiTheme.caption(color: Colors.white.withAlpha(80)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
