import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/features/motions/motion_providers.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MotionDetailScreen extends ConsumerStatefulWidget {
  final String publicGuid;

  const MotionDetailScreen({super.key, required this.publicGuid});

  @override
  ConsumerState<MotionDetailScreen> createState() => _MotionDetailScreenState();
}

class _MotionDetailScreenState extends ConsumerState<MotionDetailScreen> {
  late VideoPlayerController _videoPlayerController;
  bool _isVideoPlayerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final motion = ref.watch(motionDetailProvider(widget.publicGuid));
    motion.whenData((motion) {
      if (!_isVideoPlayerInitialized) {
        _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(motion.previewVideoUrl));
        _videoPlayerController.initialize().then((_) {
          setState(() {
            _isVideoPlayerInitialized = true;
            _videoPlayerController.setLooping(true);
            _videoPlayerController.play();
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motion = ref.watch(motionDetailProvider(widget.publicGuid));
    final theme = Theme.of(context);

    return Scaffold(
      body: motion.when(
        data: (motion) => CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(motion.title, style: const TextStyle(shadows: [Shadow(blurRadius: 10)])),
                background: _isVideoPlayerInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      )
                    : CachedNetworkImage(
                        imageUrl: motion.thumbnailUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(motion.description, style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Price:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${motion.creditPrice} credits'),
                      ],
                    ),

                    const Divider(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement image picker
                      },
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Select Reference Image'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement generate action
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: const Text('Generate'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
