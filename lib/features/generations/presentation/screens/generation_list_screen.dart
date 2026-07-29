import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/features/generations/generation_providers.dart';

class GenerationListScreen extends ConsumerWidget {
  const GenerationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generations = ref.watch(generationHistoryProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generations'),
      ),
      body: generations.when(
        data: (generations) => ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: generations.length,
          itemBuilder: (context, index) {
            final generation = generations[index];
            return Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.videocam_off_outlined),
                ),
                title: Text(
                  generation.id,
                  style: theme.textTheme.titleMedium,
                ),
                subtitle: Text(
                  generation.status,
                  style: theme.textTheme.bodyMedium,
                ),
                onTap: () => context.go('/generations/${generation.id}'),
                trailing: const Icon(Icons.chevron_right),
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
