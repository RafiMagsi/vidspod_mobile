import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/features/dashboard/dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentGenerations = ref.watch(recentGenerationsProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.headset_mic_outlined, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text('PRO'),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('SeeDance 2.5'),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              background: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/seed/picsum/800/400',
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [Colors.purple.shade300, Colors.blue.shade300],
                        ),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text(
                          'Select Photo',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildVideoModelCard(
                      context,
                      icon: Icons.music_video,
                      label: 'SeeDance',
                      badge: 'New',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildVideoModelCard(
                      context,
                      icon: Icons.movie_filter,
                      label: 'Nano Banana',
                      badge: 'Hot',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildVideoModelCard(
                      context,
                      icon: Icons.text_fields,
                      label: 'Text to Video',
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildMotionCardGrid(context, ref, 'Trending'),
          _buildMotionCardGrid(context, ref, 'Seedance 2.5 Video'),
          _buildMotionCardGrid(context, ref, 'New Arrivals'),
        ],
      ),
    );
  }

  Widget _buildMotionCardGrid(BuildContext context, WidgetRef ref, String title) {
    final recentGenerations = ref.watch(recentGenerationsProvider);
    final theme = Theme.of(context);

    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text('All'),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: recentGenerations.when(
            data: (generations) => SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final generation = generations[index];
                  return Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: generation.thumbnailUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                generation.id,
                                style: theme.textTheme.titleSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                generation.status,
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: generations.length,
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverToBoxAdapter(
              child: Center(child: Text('Error: $error')),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildVideoModelCard(BuildContext context,
    {required IconData icon, required String label, String? badge}) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 120,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 8.0),
                Text(
                  label,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badge == 'New'
                    ? Colors.blue
                    : badge == 'Hot'
                        ? Colors.orange
                        : Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badge,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
    ),
  );
}
