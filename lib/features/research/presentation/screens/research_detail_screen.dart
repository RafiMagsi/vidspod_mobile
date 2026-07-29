import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/features/research/research_providers.dart';

class ResearchDetailScreen extends ConsumerWidget {
  final String id;

  const ResearchDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final researchRun = ref.watch(researchRunProvider(id));
    final researchResults = ref.watch(researchRunResultsProvider(id));
    final theme = Theme.of(context);

    return Scaffold(
      body: researchRun.when(
        data: (run) => CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(run.topic),
              pinned: true,
              actions: [
                if (run.status == 'running')
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    tooltip: 'Cancel Run',
                    onPressed: () {
                      // TODO: Implement cancel research run
                    },
                  ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
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
                          subtitle: Text(run.id),
                        ),
                        ListTile(
                          leading: const Icon(Icons.sync),
                          title: const Text("Status"),
                          subtitle: Text(run.status),
                          trailing: run.status == 'running'
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Results", style: theme.textTheme.titleLarge),
              ),
            ),
            researchResults.when(
              data: (results) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final result = results[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(result.content),
                      ),
                    );
                  },
                  childCount: results.length,
                ),
              ),
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SliverToBoxAdapter(
                child: Center(child: Text('Error: $error')),
              ),
            ),
             SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: null, // Disabled
                      icon: const Icon(Icons.save_alt_outlined),
                      label: const Text("Save"),
                    ),
                    ElevatedButton.icon(
                      onPressed: null, // Disabled
                      icon: const Icon(Icons.share_outlined),
                      label: const Text("Share"),
                    ),
                    ElevatedButton.icon(
                      onPressed: null, // Disabled
                      icon: const Icon(Icons.upload_file_outlined),
                      label: const Text("Export"),
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
