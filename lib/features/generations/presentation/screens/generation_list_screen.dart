import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/features/generations/generation_providers.dart';

class GenerationListScreen extends ConsumerWidget {
  const GenerationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generations = ref.watch(generationHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Generations')),
      body: generations.when(
        data: (generations) => ListView.builder(
          itemCount: generations.length,
          itemBuilder: (context, index) {
            final generation = generations[index];
            return ListTile(
              title: Text(generation.id),
              subtitle: Text(generation.status),
              onTap: () => context.go('/generations/${generation.id}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
