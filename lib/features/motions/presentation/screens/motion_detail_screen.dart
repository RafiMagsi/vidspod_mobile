import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/features/motions/motion_providers.dart';

class MotionDetailScreen extends ConsumerWidget {
  final String publicGuid;

  const MotionDetailScreen({super.key, required this.publicGuid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motion = ref.watch(motionDetailProvider(publicGuid));

    return Scaffold(
      appBar: AppBar(title: const Text('Motion Details')),
      body: motion.when(
        data: (motion) => SingleChildScrollView(
          child: Column(
            children: [
              Image.network(motion.previewVideoUrl),
              Text(motion.title),
              Text(motion.description),
              Text('Price: ${motion.creditPrice} credits'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
