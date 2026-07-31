import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/models/format_preset.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/hero_video_background.dart';
import 'package:vidspod_mobile/features/billing/billing_providers.dart';
import 'package:vidspod_mobile/features/billing/credit_gate.dart';
import 'package:vidspod_mobile/features/shorts_studio/domain/generate_hub.dart';
import 'package:vidspod_mobile/features/shorts_studio/shorts_studio_providers.dart';

/// Shorts Studio "Get Started" form per docs/MOBILE_APP_GUIDE.md §5.2
/// screens 2–4.
///
/// Selecting a Motion hydrates the whole form (rule 2: the preset carries
/// prompt/genre/speed/camera_movements/shots_mode/scene_count/audio_enabled/
/// model_key/style_pack). We submit the preset key + reference image to
/// `/presets/generate` for clone Motions and `/projects` otherwise. The form is
/// locked to 9:16 and the reference image is hard-capped at 10 MB.
class GetStartedScreen extends ConsumerStatefulWidget {
  final String? motionId;
  final String? motionTitle;

  const GetStartedScreen({super.key, this.motionId, this.motionTitle});

  @override
  ConsumerState<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends ConsumerState<GetStartedScreen> {
  static const int _kMaxPrompt = 1000;
  static const int _kMaxBytes = 10 * 1024 * 1024;

  final _picker = ImagePicker();
  final _promptController = TextEditingController();
  File? _referenceImage;
  bool _submitting = false;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 90);
    if (picked == null) return;
    final file = File(picked.path);
    if (file.lengthSync() > _kMaxBytes) {
      _snack('Reference image must be under 10 MB');
      return;
    }
    setState(() => _referenceImage = file);
  }

  Future<void> _generate() async {
    final hub = await ref.read(generateHubProvider('short-studio').future);
    if (!mounted) return;
    final preset = _resolvePreset(hub.formatPresets);
    if (preset == null) {
      _snack('Pick a Motion first');
      return;
    }

    if (_referenceImage == null) {
      _snack('Add a reference photo — it\'s required for this Motion');
      return;
    }
    if (_referenceImage!.lengthSync() > _kMaxBytes) {
      _snack('Reference image must be under 10 MB');
      return;
    }

    final cost = hub.generationCost;
    if (!await CreditGate.ensureBalance(context, ref, cost)) return;
    if (!mounted) return;

    setState(() => _submitting = true);
    try {
      final runId = await _submit(preset);
      if (!mounted) return;
      context.pushReplacement('/studio/generation/$runId');
    } catch (e) {
      if (!mounted) return;
      if (!CreditGate.onApiError(context, e)) {
        _snack('Generation failed: $e');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<String> _submit(FormatPreset preset) async {
    if (Config.previewMode) {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      return 'run-${DateTime.now().millisecondsSinceEpoch}';
    }
    final repository = ref.read(shortsStudioRepositoryProvider);
    if (preset.isCloneMotion) {
      return repository.submitCloneMotion(
        presetKey: preset.key,
        referenceImage: _referenceImage!,
        title: _promptController.text.trim().isEmpty
            ? preset.label
            : _promptController.text.trim(),
      );
    }
    return repository.submitStandardMotion(
      presetKey: preset.key,
      presetLabel: preset.label,
      referenceImage: _referenceImage!,
      prompt: _promptController.text.trim().isEmpty
          ? preset.prompt
          : _promptController.text.trim(),
    );
  }

  FormatPreset? _resolvePreset(List<FormatPreset> presets) {
    if (presets.isEmpty) return null;
    for (final preset in presets) {
      if (preset.key == widget.motionId || preset.publicId == widget.motionId) {
        return preset;
      }
    }
    return presets.first;
  }

  @override
  Widget build(BuildContext context) {
    final hub = ref.watch(generateHubProvider('short-studio'));
    final credits = ref.watch(creditsProvider);
    final balance = credits.valueOrNull?.balance;

    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shorts Studio', style: VrTheme.headingSmall()),
            if (widget.motionTitle != null)
              Text(
                widget.motionTitle!,
                style: VrTheme.caption(color: Colors.white.withAlpha(100)),
              ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMotionSection(context, hub),
              const SizedBox(height: 20),
              _buildReferenceSection(context),
              const SizedBox(height: 20),
              _buildPromptInput(),
              const SizedBox(height: 24),
              _buildGenerateButton(context),
              const SizedBox(height: 12),
              _buildCreditsDisplay(hub.valueOrNull?.generationCost, balance),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMotionSection(
    BuildContext context,
    AsyncValue<GenerateHub> hub,
  ) {
    return hub.when(
      data: (hubData) {
        final preset = _resolvePreset(hubData.formatPresets);
        if (preset == null) {
          return const SizedBox.shrink();
        }
        final isClone = preset.isCloneMotion;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Motion', style: VrTheme.headingMedium()),
            const SizedBox(height: 12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                  child: SizedBox(
                    width: 72,
                    height: 96,
                    child: HeroVideoBackground(
                      videoUrl: preset.previewVideoUrl,
                      fallbackImageUrl: preset.imageUrl,
                      placeholderIcon: Icons.movie_creation_outlined,
                      autoplay: false,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        preset.label,
                        style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isClone
                              ? VrTheme.purple.withAlpha(40)
                              : VrTheme.blue.withAlpha(40),
                          borderRadius: BorderRadius.circular(
                            VrTheme.radiusFull,
                          ),
                        ),
                        child: Text(
                          isClone ? 'One-click clone' : 'Style reference',
                          style: VrTheme.caption(
                            fontSize: 10,
                            color: isClone ? VrTheme.purple : VrTheme.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${preset.aspectRatio ?? '9:16'} · ${preset.durationSeconds}s',
                        style: VrTheme.caption(
                          color: Colors.white.withAlpha(90),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
      loading: () => const _SectionLoading(),
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Motion', style: VrTheme.headingMedium()),
          const SizedBox(height: 12),
          Text(
            'Motions could not be loaded: $error',
            style: VrTheme.caption(color: VrTheme.orange),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceSection(BuildContext context) {
    final image = _referenceImage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reference photo', style: VrTheme.headingMedium()),
        const SizedBox(height: 12),
        Row(
          children: [
            GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery),
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: VrTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                  border: Border.all(
                    color: image != null
                        ? VrTheme.purple
                        : Colors.white.withAlpha(25),
                    width: image != null ? 2 : 1,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: image != null
                    ? Image.file(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white24,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Colors.white38,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add\nphoto',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  _CaptureButton(
                    icon: Icons.photo_library_outlined,
                    label: 'Choose',
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                  const SizedBox(height: 10),
                  _CaptureButton(
                    icon: Icons.camera_alt_outlined,
                    label: 'Camera',
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          image != null
              ? 'Ready · ${_humanSize(image.lengthSync())}'
              : 'Up to 10 MB · any aspect ratio (locked to 9:16 output)',
          style: VrTheme.caption(color: Colors.white.withAlpha(70)),
        ),
      ],
    );
  }

  Widget _buildPromptInput() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: VrTheme.surfaceDark,
        borderRadius: BorderRadius.circular(VrTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _promptController,
            maxLines: 6,
            maxLength: _kMaxPrompt,
            decoration: const InputDecoration(
              hintText:
                  'Describe your vision — faces, bodies, scenes, camera movement...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white24, fontSize: 13),
              counterText: '',
              isCollapsed: true,
            ),
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: VrTheme.purple.withAlpha(150),
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'AI Powered',
                    style: TextStyle(
                      color: VrTheme.purple.withAlpha(150),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: _promptController,
                builder: (context, value, _) => Text(
                  '${value.text.characters.length}/$_kMaxPrompt',
                  style: VrTheme.caption(color: Colors.white.withAlpha(60)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton(BuildContext context) {
    return GestureDetector(
      onTap: _submitting ? null : _generate,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          gradient: VrTheme.brandGradient,
          boxShadow: VrTheme.buttonShadow(VrTheme.purple),
        ),
        child: Center(
          child: _submitting
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Generate',
                  style: VrTheme.bodyMedium(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCreditsDisplay(int? cost, int? balance) {
    final costText = cost != null ? '$cost' : '—';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.bolt, color: Colors.amber.shade300, size: 16),
        const SizedBox(width: 6),
        Text(
          '$costText credits',
          style: VrTheme.bodySmall(color: Colors.white.withAlpha(110)),
        ),
        if (balance != null) ...[
          const SizedBox(width: 12),
          Text(
            '· $balance available',
            style: VrTheme.bodySmall(color: Colors.white.withAlpha(60)),
          ),
        ],
      ],
    );
  }

  String _humanSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / 1024).toStringAsFixed(0)} KB';
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _CaptureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _CaptureButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
          border: Border.all(color: Colors.white.withAlpha(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white.withAlpha(160), size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withAlpha(140),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLoading extends StatelessWidget {
  const _SectionLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(child: platformLoader(size: 24)),
    );
  }
}
