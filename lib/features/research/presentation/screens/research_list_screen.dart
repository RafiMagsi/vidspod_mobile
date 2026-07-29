import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/features/research/research_providers.dart';

class ResearchListScreen extends ConsumerWidget {
  const ResearchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final researchRuns = ref.watch(researchRunsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Research'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'New Research',
            onPressed: () {
              // TODO: Show dialog to create new research run
            },
          ),
        ],
      ),
      body: researchRuns.when(
        data: (runs) => ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: runs.length,
          itemBuilder: (context, index) {
            final run = runs[index];
            return Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: run.status == 'running' 
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ) 
                      : const Icon(Icons.science_outlined),
                ),
                title: Text(run.topic, style: theme.textTheme.titleMedium),
                subtitle: Text(run.status, style: theme.textTheme.bodyMedium),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/research/${run.id}'),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
