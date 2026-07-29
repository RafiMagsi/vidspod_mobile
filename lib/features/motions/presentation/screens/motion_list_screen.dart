import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/features/motions/motion_providers.dart';

class MotionListScreen extends ConsumerWidget {
  const MotionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motions = ref.watch(motionListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Motions')),
      body: motions.when(
        data: (motions) => ListView.builder(
          itemCount: motions.length,
          itemBuilder: (context, index) {
            final motion = motions[index];
            return ListTile(
              leading: Image.network(motion.thumbnailUrl),
              title: Text(motion.title),
              subtitle: Text(motion.description),
              onTap: () => context.go('/motions/${motion.publicGuid}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
