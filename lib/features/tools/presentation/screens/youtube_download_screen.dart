import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';
import 'package:vidspod_mobile/features/tools/tools_providers.dart';

class YouTubeDownloadScreen extends ConsumerStatefulWidget {
  const YouTubeDownloadScreen({super.key});

  @override
  ConsumerState<YouTubeDownloadScreen> createState() =>
      _YouTubeDownloadScreenState();
}

class _YouTubeDownloadScreenState extends ConsumerState<YouTubeDownloadScreen> {
  final _urlController = TextEditingController();
  Map<String, dynamic>? _info;
  bool _fetching = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _fetchFormats() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      _snack(context, 'Paste a YouTube URL first');
      return;
    }
    setState(() {
      _fetching = true;
      _info = null;
    });
    try {
      final repository = ref.read(youtubeDownloadRepositoryProvider);
      final info = await repository.getInfo(url);
      if (mounted) setState(() => _info = info);
    } catch (e) {
      if (mounted) _snack(context, 'Could not fetch formats: $e');
    } finally {
      if (mounted) setState(() => _fetching = false);
    }
  }

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
      backgroundColor: VrTheme.black,
      body: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: VrTheme.black,
              surfaceTintColor: Colors.transparent,
              title: Text('YouTube Download', style: VrTheme.headingLarge()),
            ),
            SliverToBoxAdapter(
              child: _UrlInput(
                controller: _urlController,
                fetching: _fetching,
                onFetch: _fetchFormats,
              ),
            ),
            SliverToBoxAdapter(child: _VideoInfo(info: _info)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Available Formats',
                  style: VrTheme.headingMedium(),
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
                child: Text('Recent Downloads', style: VrTheme.headingMedium()),
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

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
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
  final TextEditingController controller;
  final bool fetching;
  final VoidCallback onFetch;
  const _UrlInput({
    required this.controller,
    required this.fetching,
    required this.onFetch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
          boxShadow: VrTheme.cardShadow(VrTheme.black),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF0000), Color(0xFFCC0000)],
                ),
                borderRadius: BorderRadius.circular(VrTheme.radiusMd),
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
              style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: VrTheme.darkSurface,
                borderRadius: BorderRadius.circular(VrTheme.radiusMd),
                border: Border.all(color: VrTheme.cardBorder.withAlpha(50)),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'https://youtube.com/watch?v=...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 13),
                  isCollapsed: true,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: fetching ? null : onFetch,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(VrTheme.radiusFull),
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
                  child: fetching
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white.withAlpha(230),
                          ),
                        )
                      : Row(
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
                              style: VrTheme.bodySmall(
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
  final Map<String, dynamic>? info;
  const _VideoInfo({this.info});

  @override
  Widget build(BuildContext context) {
    final title = (info?['title'] as String?) ?? 'Sample Video Title';
    final thumbnail =
        (info?['thumbnail'] as String?) ??
        'https://picsum.photos/seed/yt-demo/120/90';
    final duration = (info?['duration'] as String?) ?? '12:34';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: VrTheme.darkSurface,
              ),
              clipBehavior: Clip.antiAlias,
              child: AppNetworkImage(
                url: thumbnail,
                borderRadius: 6,
                placeholderIcon: Icons.play_circle_outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: VrTheme.bodySmall(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${info == null ? 'TechChannel' : 'YouTube'} • $duration',
                    style: VrTheme.caption(
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
    final accentColor = isVideo ? VrTheme.purple : VrTheme.green;
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Downloading ${item.title}...'))),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: accentColor.withAlpha(40)),
          boxShadow: VrTheme.cardShadow(VrTheme.black),
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
                    borderRadius: BorderRadius.circular(VrTheme.radiusSm),
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
              style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 1),
            Text(
              item.resolution,
              style: VrTheme.caption(
                color: Colors.white.withAlpha(70),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              item.size,
              style: VrTheme.caption(
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
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(20),
                borderRadius: BorderRadius.circular(VrTheme.radiusSm),
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
                    style: VrTheme.bodySmall(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.channel} • ${item.duration}',
                    style: VrTheme.caption(
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
                color: VrTheme.green.withAlpha(20),
                borderRadius: BorderRadius.circular(VrTheme.radiusFull),
              ),
              child: Text(
                item.status,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: VrTheme.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
