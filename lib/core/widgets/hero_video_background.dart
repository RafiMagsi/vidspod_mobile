import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';

/// Muted, looping, autoplaying background video used for studio heroes
/// (docs/MOBILE_APP_GUIDE.md §5.2 screen 1).
///
/// Covers its parent at the exact size of the placeholder image, falls back to
/// a cached [AppNetworkImage] when no URL is available or playback fails, and
/// pauses while the app is backgrounded to save battery/data.
class HeroVideoBackground extends StatefulWidget {
  final String? videoUrl;
  final String? fallbackImageUrl;
  final IconData placeholderIcon;
  final BoxFit fit;

  /// When false the widget never initializes a video player — it renders the
  /// fallback image only. Use for compact previews (e.g. carousels) so we do
  /// not spin up a decoder per visible card (§8: efficiency).
  final bool autoplay;

  const HeroVideoBackground({
    super.key,
    required this.videoUrl,
    this.fallbackImageUrl,
    this.placeholderIcon = Icons.play_circle_outline,
    this.fit = BoxFit.cover,
    this.autoplay = true,
  });

  @override
  State<HeroVideoBackground> createState() => _HeroVideoBackgroundState();
}

class _HeroVideoBackgroundState extends State<HeroVideoBackground>
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  bool _failed = false;
  bool _wasPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initVideo();
  }

  @override
  void didUpdateWidget(HeroVideoBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _failed = false;
      _initVideo();
    }
  }

  Future<void> _initVideo() async {
    if (!widget.autoplay) {
      _failed = true;
      return;
    }
    final url = widget.videoUrl;
    if (url == null || url.isEmpty) {
      _failed = true;
      return;
    }
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      _controller = controller;
      await controller.initialize();
      if (!mounted || !identical(_controller, controller)) return;
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();
      setState(() {});
    } on Object {
      if (!mounted) return;
      setState(() => _failed = true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (state == AppLifecycleState.resumed) {
      if (_wasPlaying) controller.play();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      _wasPlaying = controller.value.isPlaying;
      controller.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final playing =
        controller != null && controller.value.isInitialized && !_failed;

    if (playing) {
      return SizedBox.expand(
        child: FittedBox(
          fit: widget.fit,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: controller.value.size.width,
            height: controller.value.size.height,
            child: VideoPlayer(controller),
          ),
        ),
      );
    }
    return AppNetworkImage(
      url: widget.fallbackImageUrl,
      placeholderIcon: widget.placeholderIcon,
    );
  }
}
