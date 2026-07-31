import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/models/format_preset.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/widgets/hero_video_background.dart';

/// A 9:16 Motion card for the Shorts Studio. Autoplays the preset's preview
/// clip (muted, looping) and falls back to the cover image, per
/// docs/MOBILE_APP_GUIDE.md §5.2 screen 2 ("autoplaying preview clips").
class MotionPresetCard extends StatelessWidget {
  final FormatPreset preset;
  final double width;
  final double height;

  /// Autoplay the preview clip. Pass `false` in compact carousels to keep
  /// several cards on screen from each holding a video decoder.
  final bool autoPlay;

  const MotionPresetCard({
    super.key,
    required this.preset,
    this.width = 150,
    this.height = 267,
    this.autoPlay = true,
  });

  @override
  Widget build(BuildContext context) {
    final isClone = preset.isCloneMotion;
    return GestureDetector(
      onTap: () => context.push(
        '/get-started',
        extra: {'motionId': preset.key, 'motionTitle': preset.label},
      ),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  HeroVideoBackground(
                    videoUrl: preset.previewVideoUrl,
                    fallbackImageUrl: preset.imageUrl,
                    placeholderIcon: Icons.movie_creation_outlined,
                    autoplay: autoPlay,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(140),
                        borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                      ),
                      child: Text(
                        isClone ? 'One-click clone' : 'Style reference',
                        style: VrTheme.caption(fontSize: 10),
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
                        Icons.play_circle_outline,
                        color: Colors.white.withAlpha(220),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    preset.label,
                    style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    preset.aspectRatio ?? '9:16',
                    style: VrTheme.caption(color: Colors.white.withAlpha(80)),
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
