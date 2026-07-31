import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/app_category_section.dart';
import 'package:vidspod_mobile/features/billing/credit_gate.dart';
import 'package:vidspod_mobile/features/shorts_studio/domain/generate_hub.dart';
import 'package:vidspod_mobile/features/shorts_studio/presentation/widgets/motion_preset_card.dart';
import 'package:vidspod_mobile/features/shorts_studio/shorts_studio_providers.dart';

/// Generic video studio per docs/MOBILE_APP_GUIDE.md §5.5.
///
/// Every studio is the same `/generate/hub` payload keyed by `flow_category`.
/// Mobile shows prompt + style pack + aspect ratio + duration; the ~15 desktop
/// production controls are hidden behind "Advanced". Nothing is hardcoded —
/// all options come from the hub payload.
class VideoStudioScreen extends ConsumerStatefulWidget {
  final String flowCategory;
  final String title;
  const VideoStudioScreen({
    super.key,
    required this.flowCategory,
    required this.title,
  });

  @override
  ConsumerState<VideoStudioScreen> createState() => _VideoStudioScreenState();
}

class _VideoStudioScreenState extends ConsumerState<VideoStudioScreen> {
  final _promptController = TextEditingController();
  String? _stylePack;
  String? _aspectRatio;
  String? _cameraMovement;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hub = ref.watch(generateHubProvider(widget.flowCategory));
    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(
        backgroundColor: VrTheme.black,
        title: Text(widget.title, style: VrTheme.headingLarge()),
      ),
      body: hub.when(
        data: (data) => _StudioBody(
          hub: data,
          promptController: _promptController,
          stylePack: _stylePack,
          aspectRatio: _aspectRatio,
          cameraMovement: _cameraMovement,
          onStylePack: (v) => setState(() => _stylePack = v),
          onAspectRatio: (v) => setState(() => _aspectRatio = v),
          onCameraMovement: (v) => setState(() => _cameraMovement = v),
        ),
        loading: () => Center(child: platformLoader(size: 28)),
        error: (error, _) => Center(
          child: Text(
            'Failed to load studio',
            style: VrTheme.bodyMedium(color: Colors.white.withAlpha(100)),
          ),
        ),
      ),
    );
  }
}

class _StudioBody extends ConsumerWidget {
  final GenerateHub hub;
  final TextEditingController promptController;
  final String? stylePack;
  final String? aspectRatio;
  final String? cameraMovement;
  final ValueChanged<String> onStylePack;
  final ValueChanged<String> onAspectRatio;
  final ValueChanged<String> onCameraMovement;
  const _StudioBody({
    required this.hub,
    required this.promptController,
    required this.stylePack,
    required this.aspectRatio,
    required this.cameraMovement,
    required this.onStylePack,
    required this.onAspectRatio,
    required this.onCameraMovement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (hub.flowMeta['title'] as String?) ?? 'Prompt',
            style: VrTheme.headingMedium(),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: promptController,
            style: const TextStyle(color: Colors.white),
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Describe the video you want…',
              hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
              filled: true,
              fillColor: VrTheme.darkSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (hub.stylePacks.isNotEmpty) ...[
            Text('Style pack', style: VrTheme.headingMedium()),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                for (final pack in hub.stylePacks)
                  _optionChip(
                    label:
                        (pack['label'] as String?) ??
                        (pack['key'] as String? ?? ''),
                    selected: stylePack == pack['key'],
                    onTap: () => onStylePack(pack['key'] as String? ?? ''),
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
          if (hub.aspectRatios.isNotEmpty) ...[
            Text('Aspect ratio', style: VrTheme.headingMedium()),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                for (final ratio in hub.aspectRatios)
                  _optionChip(
                    label: ratio,
                    selected: aspectRatio == ratio,
                    onTap: () => onAspectRatio(ratio),
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
          Text(
            'Duration: ~${(hub.flowMeta['default_duration_seconds'] as int?) ?? 15}s',
            style: VrTheme.caption(color: Colors.white.withAlpha(80)),
          ),
          const SizedBox(height: 12),
          _AdvancedPanel(
            cameraMovements: hub.cameraMovements,
            cameraMovement: cameraMovement,
            onCameraMovement: onCameraMovement,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: VrTheme.purple,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => _generate(context, ref),
              icon: const Icon(Icons.auto_awesome),
              label: Text('Generate · ${hub.generationCost} credits'),
            ),
          ),
          if (hub.formatPresets.isNotEmpty) ...[
            const SizedBox(height: 24),
            AppCategorySection(
              title: 'Presets',
              itemCount: hub.formatPresets.length,
              itemBuilder: (_, i) {
                final preset = hub.formatPresets[i];
                return MotionPresetCard(preset: preset, autoPlay: false);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _optionChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? VrTheme.purple.withAlpha(30) : VrTheme.darkSurface,
          borderRadius: BorderRadius.circular(VrTheme.radiusFull),
          border: Border.all(
            color: selected
                ? VrTheme.purple.withAlpha(90)
                : VrTheme.cardBorder.withAlpha(60),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? VrTheme.purple : Colors.white.withAlpha(90),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _generate(BuildContext context, WidgetRef ref) async {
    // §3.4 / §5.5: block submit when the balance can't cover the run cost.
    final ok = await CreditGate.ensureBalance(context, ref, hub.generationCost);
    if (!ok || !context.mounted) return;
    _snack(context, 'Generation coming soon');
  }
}

/// Collapsible production controls (§5.5 "hidden behind Advanced"). Options
/// come from the hub payload — never hardcoded.
class _AdvancedPanel extends StatefulWidget {
  final List<String> cameraMovements;
  final String? cameraMovement;
  final ValueChanged<String> onCameraMovement;
  const _AdvancedPanel({
    required this.cameraMovements,
    required this.cameraMovement,
    required this.onCameraMovement,
  });

  @override
  State<_AdvancedPanel> createState() => _AdvancedPanelState();
}

class _AdvancedPanelState extends State<_AdvancedPanel> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final hasCamera = widget.cameraMovements.isNotEmpty;
    return Container(
      decoration: BoxDecoration(
        color: VrTheme.darkSurface,
        borderRadius: BorderRadius.circular(VrTheme.radiusLg),
        border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: Colors.white.withAlpha(140),
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Advanced',
                    style: VrTheme.bodyMedium(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white.withAlpha(80),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(width: double.infinity),
            secondChild: hasCamera
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Camera movement',
                          style: VrTheme.caption(
                            color: Colors.white.withAlpha(100),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final move in widget.cameraMovements)
                              _advancedChip(
                                label: _humanize(move),
                                selected: widget.cameraMovement == move,
                                onTap: () => widget.onCameraMovement(move),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'No advanced options for this studio.',
                      style: TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _humanize(String value) => value
      .split('-')
      .map(
        (part) =>
            part.isEmpty ? part : part[0].toUpperCase() + part.substring(1),
      )
      .join(' ');
}

Widget _advancedChip({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? VrTheme.purple.withAlpha(30)
            : Colors.white.withAlpha(10),
        borderRadius: BorderRadius.circular(VrTheme.radiusFull),
        border: Border.all(
          color: selected
              ? VrTheme.purple.withAlpha(90)
              : VrTheme.cardBorder.withAlpha(60),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? VrTheme.purple : Colors.white.withAlpha(90),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
