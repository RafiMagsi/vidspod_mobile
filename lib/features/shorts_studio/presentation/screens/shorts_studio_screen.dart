import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/features/shorts_studio/application/shorts_studio_service.dart';
import 'package:dotted_border/dotted_border.dart';

class ShortsStudioScreen extends ConsumerWidget {
  const ShortsStudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortsStudioState = ref.watch(shortsStudioProvider);
    final shortsStudioNotifier = ref.read(shortsStudioProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Shorts Studio')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Step 1: Select Motion (Placeholder)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Step 1: Select a Motion", style: theme.textTheme.titleLarge),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.movie_filter_outlined),
                      title: const Text("Motion Title"), // Placeholder
                      subtitle: const Text("Description of the selected motion."), // Placeholder
                      trailing: ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to motion selection screen
                        },
                        child: const Text("Change"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Step 2: Select Reference Image
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Step 2: Select Reference Image", style: theme.textTheme.titleLarge),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => shortsStudioNotifier.pickImage(),
                      child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: const Radius.circular(12),
                        dashPattern: const [6, 6],
                        strokeWidth: 2,
                        color: theme.colorScheme.primary.withOpacity(0.6),
                      ),
                      child: Container(
                          height: 200,
                          width: double.infinity,
                          child: shortsStudioState.image != null
                              ? Image.file(shortsStudioState.image!, fit: BoxFit.cover)
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined, size: 48),
                                    SizedBox(height: 8),
                                    Text("Tap to select an image"),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Step 3: Generate
            if (shortsStudioState.image != null)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Step 3: Generate", style: theme.textTheme.titleLarge),
                      const SizedBox(height: 16),
                      const ListTile(
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text("Estimated Cost"),
                        trailing: Text("10 Credits"), // Placeholder
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      if (shortsStudioState.status == UploadStatus.uploading)
                        const Center(child: CircularProgressIndicator())
                      else
                        ElevatedButton.icon(
                          onPressed: () {
                            shortsStudioNotifier.uploadImageAndCreateGeneration('dummy_motion_id');
                          },
                          icon: const Icon(Icons.auto_awesome),
                          label: const Text('Generate'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
