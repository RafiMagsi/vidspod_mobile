import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class YouTubeDownloadScreen extends StatelessWidget {
  const YouTubeDownloadScreen({super.key});

  static const _formats = [
    _FormatItem('MP4 1080p', 'Full HD video', Icons.high_quality, 'video'),
    _FormatItem('MP4 720p', 'HD video', Icons.hd_outlined, 'video'),
    _FormatItem('MP4 480p', 'SD video', Icons.sd_outlined, 'video'),
    _FormatItem('MP3 320kbps', 'High quality audio', Icons.audio_file, 'audio'),
    _FormatItem('MP3 128kbps', 'Standard audio', Icons.audio_file_outlined, 'audio'),
    _FormatItem('WAV', 'Lossless audio', Icons.waves, 'audio'),
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
            title: Text('YouTube Download', style: CreatiTheme.headingLarge()),
          ),
          const SliverToBoxAdapter(child: _UrlInput()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Available Formats', style: CreatiTheme.headingMedium()),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) => _FormatCard(item: _formats[i], index: i),
                childCount: _formats.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _FormatItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String type;
  const _FormatItem(this.title, this.subtitle, this.icon, this.type);
}

class _UrlInput extends StatelessWidget {
  const _UrlInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFF0000), Color(0xFFCC0000)]),
              borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
            ),
            child: const Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 14),
          Text('Paste YouTube URL', style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: CreatiTheme.darkSurface,
              borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
              border: Border.all(color: CreatiTheme.cardBorder.withAlpha(50)),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'https://youtube.com/watch?v=...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white24, fontSize: 13),
                isCollapsed: true,
              ),
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                gradient: const LinearGradient(colors: [Color(0xFFFF0000), Color(0xFFCC0000)]),
                boxShadow: [BoxShadow(color: const Color(0xFFFF0000).withAlpha(50), blurRadius: 16, offset: const Offset(0, 6))],
              ),
              child: Center(
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.search, color: Colors.white.withAlpha(230), size: 16),
                  const SizedBox(width: 6),
                  Text('Fetch Formats', style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600)),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _FormatCard extends StatelessWidget {
  final _FormatItem item;
  final int index;
  const _FormatCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(
            color: item.type == 'video'
                ? CreatiTheme.cardBorder.withAlpha(60)
                : CreatiTheme.green.withAlpha(40),
          ),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item.type == 'video'
                      ? CreatiTheme.purple.withAlpha(25)
                      : CreatiTheme.green.withAlpha(25),
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusSm),
                ),
                child: Icon(item.icon, color: item.type == 'video' ? CreatiTheme.purple : CreatiTheme.green, size: 18),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: item.type == 'video' ? CreatiTheme.purple.withAlpha(20) : CreatiTheme.green.withAlpha(20),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.type == 'video' ? 'VIDEO' : 'AUDIO',
                  style: TextStyle(
                    fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 0.5,
                    color: item.type == 'video' ? CreatiTheme.purple.withAlpha(180) : CreatiTheme.green.withAlpha(180),
                  ),
                ),
              ),
            ]),
            const Spacer(),
            Text(item.title, style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(item.subtitle, style: CreatiTheme.caption(color: Colors.white.withAlpha(80))),
          ],
        ),
      ),
    );
  }
}
