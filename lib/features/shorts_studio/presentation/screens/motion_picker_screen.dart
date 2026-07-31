import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/models/format_preset.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/core/widgets/staggered_fade_in.dart';
import 'package:vidspod_mobile/features/shorts_studio/presentation/widgets/motion_preset_card.dart';
import 'package:vidspod_mobile/features/shorts_studio/shorts_studio_providers.dart';

/// Full-screen Motion picker per docs/MOBILE_APP_GUIDE.md §5.2 screen 2.
///
/// 9:16 grid of every Motion the server gated for Shorts Studio, filtered by
/// type ("Style reference" vs "One-click clone") and autoplaying each preview
/// clip. Selecting a Motion hydrates Get Started.
enum MotionTypeFilter { all, styleReference, clone }

class MotionPickerScreen extends ConsumerStatefulWidget {
  const MotionPickerScreen({super.key});

  @override
  ConsumerState<MotionPickerScreen> createState() => _MotionPickerScreenState();
}

class _MotionPickerScreenState extends ConsumerState<MotionPickerScreen> {
  MotionTypeFilter _filter = MotionTypeFilter.all;

  List<FormatPreset> _applyFilter(List<FormatPreset> items) {
    switch (_filter) {
      case MotionTypeFilter.all:
        return items;
      case MotionTypeFilter.styleReference:
        return items.where((p) => !p.isCloneMotion).toList();
      case MotionTypeFilter.clone:
        return items.where((p) => p.isCloneMotion).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final presets = ref.watch(shortStudioPresetsProvider);
    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Pick a Motion', style: VrTheme.headingLarge()),
        actions: [
          GestureDetector(
            onTap: () {
              context.pop();
              context.push('/get-started');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  Text(
                    'Skip',
                    style: VrTheme.bodySmall(
                      color: VrTheme.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    color: VrTheme.purple,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: presets.when(
        data: (items) {
          final visible = _applyFilter(items);
          return Column(
            children: [
              _FilterBar(
                filter: _filter,
                onChanged: (f) => setState(() => _filter = f),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 9 / 16,
                  ),
                  itemCount: visible.length,
                  itemBuilder: (_, index) {
                    return StaggeredFadeIn(
                      index: index,
                      child: MotionPresetCard(
                        preset: visible[index],
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const AsyncStateView(loading: true, emptyMessage: ''),
        error: (error, _) => AsyncStateView(
          loading: false,
          errorMessage: '$error',
          emptyMessage: '',
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final MotionTypeFilter filter;
  final ValueChanged<MotionTypeFilter> onChanged;

  const _FilterBar({required this.filter, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final options = [
      (MotionTypeFilter.all, 'All'),
      (MotionTypeFilter.styleReference, 'Style reference'),
      (MotionTypeFilter.clone, 'One-click clone'),
    ];
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final (value, label) = options[i];
          final selected = filter == value;
          return GestureDetector(
            onTap: () {
              hapticTap();
              onChanged(value);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? VrTheme.purple.withAlpha(40)
                    : VrTheme.surfaceDark,
                borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                border: Border.all(
                  color: selected
                      ? VrTheme.purple.withAlpha(120)
                      : VrTheme.cardBorder.withAlpha(50),
                ),
              ),
              child: Text(
                label,
                style: VrTheme.bodySmall(
                  color: selected
                      ? VrTheme.purple
                      : Colors.white.withAlpha(140),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
