import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/features/shorts_studio/application/shorts_studio_service.dart';

class ShortsStudioScreen extends ConsumerWidget {
  const ShortsStudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortsStudioState = ref.watch(shortsStudioProvider);
    final shortsStudioNotifier = ref.read(shortsStudioProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Shorts Studio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (shortsStudioState.image != null)
              Image.file(shortsStudioState.image!)
            else
              const Text('No image selected.'),
            const SizedBox(height: 20),
            if (shortsStudioState.status == UploadStatus.picking)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  shortsStudioNotifier.pickImage();
                },
                child: const Text('Pick Image'),
              ),
            if (shortsStudioState.status == UploadStatus.picked)
              ElevatedButton(
                onPressed: () {
                  shortsStudioNotifier.uploadImageAndCreateGeneration('dummy_motion_id');
                },
                child: const Text('Upload Image'),
              ),
            if (shortsStudioState.status == UploadStatus.uploading)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
