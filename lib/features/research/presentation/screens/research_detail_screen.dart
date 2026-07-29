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

    return Scaffold(
      appBar: AppBar(title: const Text('Research Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            researchRun.when(
              data: (run) => ListTile(
                title: Text(run.topic),
                subtitle: Text(run.status),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
            researchResults.when(
              data: (results) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  return ListTile(
                    title: Text(result.content),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }
}
