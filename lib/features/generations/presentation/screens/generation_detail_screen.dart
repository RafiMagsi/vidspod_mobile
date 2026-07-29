import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/features/generations/generation_providers.dart';

class GenerationDetailScreen extends ConsumerWidget {
  final String id;

  const GenerationDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generation = ref.watch(generationProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('Generation Details')),
      body: generation.when(
        data: (generation) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ID: ${generation.id}'),
              Text('Status: ${generation.status}'),
              Text('Workflow: ${generation.workflowType}'),
              Text('Progress: ${generation.progress}'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
