import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/features/generations/generation_providers.dart';
import 'package:vidspod_mobile/features/generations/presentation/widgets/video_player_widget.dart';

class GenerationDetailScreen extends ConsumerWidget {
  final String id;

  const GenerationDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generation = ref.watch(generationProvider(id));
    final theme = Theme.of(context);

    return Scaffold(
      body: generation.when(
        data: (generation) => CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Generation: ${generation.id.substring(0, 8)}...', style: const TextStyle(shadows: [Shadow(blurRadius: 10)])),
                background: generation.videoUrl != null
                    ? VideoPlayerWidget(videoUrl: generation.videoUrl!)
                    : Container(
                        color: Colors.black,
                        child: const Center(
                          child: Icon(Icons.videocam_off_outlined, color: Colors.white, size: 48),
                        ),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text("Details", style: theme.textTheme.titleLarge),
                             const SizedBox(height: 16),
                             ListTile(
                               leading: const Icon(Icons.tag),
                               title: const Text("ID"),
                               subtitle: Text(generation.id),
                             ),
                             ListTile(
                               leading: const Icon(Icons.sync),
                               title: const Text("Status"),
                               subtitle: Text(generation.status),
                             ),
                             ListTile(
                               leading: const Icon(Icons.lan),
                               title: const Text("Workflow"),
                               subtitle: Text(generation.workflowType),
                             ),
                             ListTile(
                              leading: const Icon(Icons.percent),
                              title: const Text("Progress"),
                              subtitle: Text(generation.progress.toString()),
                              trailing: generation.status != 'complete' ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()) : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download_outlined),
                          label: const Text("Download"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                          label: const Text("Share"),
                        ),
                        if (generation.status == 'failed')
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.refresh_outlined),
                            label: const Text("Retry"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.error,
                              foregroundColor: theme.colorScheme.onError,
                            ),
                          ),
                      ],
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
