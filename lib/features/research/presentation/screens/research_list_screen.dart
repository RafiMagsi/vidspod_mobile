import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/features/research/research_providers.dart';

class ResearchListScreen extends ConsumerWidget {
  const ResearchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final researchRuns = ref.watch(researchRunsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Research'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Show dialog to create new research run
            },
          ),
        ],
      ),
      body: researchRuns.when(
        data: (runs) => ListView.builder(
          itemCount: runs.length,
          itemBuilder: (context, index) {
            final run = runs[index];
            return ListTile(
              title: Text(run.topic),
              subtitle: Text(run.status),
              onTap: () => context.go('/research/${run.id}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
