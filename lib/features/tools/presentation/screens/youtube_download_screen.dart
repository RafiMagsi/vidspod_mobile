import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';

class YouTubeDownloadScreen extends StatelessWidget {
  const YouTubeDownloadScreen({super.key});

  static const _formats = [
    _FormatItem(
      'MP4 1080p',
      'Full HD video',
      '1920x1080',
      '~150 MB',
      Icons.high_quality,
      'video',
    ),
    _FormatItem(
      'MP4 720p',
      'HD video',
      '1280x720',
      '~80 MB',
      Icons.hd_outlined,
      'video',
    ),
    _FormatItem(
      'MP4 480p',
      'SD video',
      '854x480',
      '~40 MB',
      Icons.sd_outlined,
      'video',
    ),
    _FormatItem(
      'MP3 320kbps',
      'High quality audio',
      '44100 Hz',
      '~15 MB',
      Icons.audio_file,
      'audio',
    ),
    _FormatItem(
      'MP3 128kbps',
      'Standard audio',
      '44100 Hz',
      '~6 MB',
      Icons.audio_file_outlined,
      'audio',
    ),
    _FormatItem(
      'WAV',
      'Lossless audio',
      '16-bit PCM',
      '~50 MB',
      Icons.waves,
      'audio',
    ),
  ];

  static const _recentDownloads = [
    _DownloadItem('How to Build a PC', 'LTT', '12:34', 'Completed'),
    _DownloadItem('Top 10 AI Tools 2026', 'TechReview', '8:21', 'Completed'),
    _DownloadItem('Music Mix 2026', 'MusicChannel', '45:00', 'Completed'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: CreatiTheme.black,
              surfaceTintColor: Colors.transparent,
              title: Text(
                'YouTube Download',
                style: CreatiTheme.headingLarge(),
              ),
            ),
            const SliverToBoxAdapter(child: _UrlInput()),
            const SliverToBoxAdapter(child: _VideoInfo()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Available Formats',
                  style: CreatiTheme.headingMedium(),
                ),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Recent Downloads',
                  style: CreatiTheme.headingMedium(),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _DownloadHistoryCard(item: _recentDownloads[i]),
                  childCount: _recentDownloads.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _FormatItem {
  final String title;
  final String subtitle;
  final String resolution;
  final String size;
  final IconData icon;
  final String type;
  const _FormatItem(
    this.title,
    this.subtitle,
    this.resolution,
    this.size,
    this.icon,
    this.type,
  );
}

class _DownloadItem {
  final String title;
  final String channel;
  final String duration;
  final String status;
  const _DownloadItem(this.title, this.channel, this.duration, this.status);
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF0000), Color(0xFFCC0000)],
                ),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
              ),
              child: const Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Paste YouTube URL',
              style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
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
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF0000), Color(0xFFCC0000)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF0000).withAlpha(50),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white.withAlpha(230),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Fetch Formats',
                        style: CreatiTheme.bodySmall(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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

class _VideoInfo extends StatelessWidget {
  const _VideoInfo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://picsum.photos/seed/yt-demo/120/90',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sample Video Title',
                    style: CreatiTheme.bodySmall(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'TechChannel • 12:34 • 2.5M views',
                    style: CreatiTheme.caption(
                      color: Colors.white.withAlpha(70),
                      fontSize: 10,
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

class _FormatCard extends StatelessWidget {
  final _FormatItem item;
  final int index;
  const _FormatCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final isVideo = item.type == 'video';
    final accentColor = isVideo ? CreatiTheme.purple : CreatiTheme.green;
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Downloading ${item.title}...'))),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: accentColor.withAlpha(40)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusSm),
                  ),
                  child: Icon(item.icon, color: accentColor, size: 18),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isVideo ? 'VIDEO' : 'AUDIO',
                    style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      color: accentColor.withAlpha(180),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              item.title,
              style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 1),
            Text(
              item.resolution,
              style: CreatiTheme.caption(
                color: Colors.white.withAlpha(70),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              item.size,
              style: CreatiTheme.caption(
                color: Colors.white.withAlpha(50),
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DownloadHistoryCard extends StatelessWidget {
  final _DownloadItem item;
  const _DownloadHistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(20),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusSm),
              ),
              child: const Icon(
                Icons.play_circle_fill,
                color: Colors.red,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: CreatiTheme.bodySmall(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.channel} • ${item.duration}',
                    style: CreatiTheme.caption(
                      color: Colors.white.withAlpha(60),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: CreatiTheme.green.withAlpha(20),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
              ),
              child: Text(
                item.status,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: CreatiTheme.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
