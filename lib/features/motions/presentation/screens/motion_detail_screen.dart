import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/core/widgets/hero_video_background.dart';
import 'package:vidspod_mobile/features/motions/domain/motion.dart';
import 'package:vidspod_mobile/features/motions/motion_providers.dart';

/// Motions catalog detail per docs/MOBILE_APP_GUIDE.md §5.12.
///
/// Title/description/thumbnail/credits come from `GET /motions/{public_id}`
/// (preview falls back to deterministic preview data). "Get Started" jumps
/// straight into Shorts Studio with the Motion preselected.
class MotionDetailScreen extends ConsumerWidget {
  final String publicGuid;
  const MotionDetailScreen({super.key, required this.publicGuid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motion = ref.watch(motionDetailProvider(publicGuid));
    return Scaffold(
      backgroundColor: VrTheme.black,
      body: motion.when(
        data: (m) => _MotionDetailBody(motion: m),
        loading: () => Center(child: platformLoader(size: 28)),
        error: (error, _) => AsyncStateView(
          loading: false,
          errorMessage: '$error',
          emptyMessage: '',
        ),
      ),
    );
  }
}

class _MotionDetailBody extends StatelessWidget {
  final Motion motion;
  const _MotionDetailBody({required this.motion});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HeroVideoBackground(
          videoUrl: motion.previewVideoUrl,
          fallbackImageUrl: motion.thumbnailUrl,
          placeholderIcon: Icons.movie_creation_outlined,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withAlpha(180)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      onPressed: () => context.pop(),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        borderRadius: BorderRadius.circular(VrTheme.radiusMd),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.bolt, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '${motion.creditPrice}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      motion.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        height: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      motion.description,
                      style: VrTheme.bodyMedium(
                        color: Colors.white.withAlpha(128),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      motion.isAvailable ? 'Ready to use' : 'Unavailable',
                      style: VrTheme.caption(
                        color: motion.isAvailable
                            ? VrTheme.green
                            : VrTheme.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () => context.push(
                    '/get-started',
                    extra: {
                      'motionId': motion.publicGuid,
                      'motionTitle': motion.title,
                    },
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: VrTheme.brandGradient,
                      boxShadow: VrTheme.buttonShadow(VrTheme.purple),
                    ),
                    child: const Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
