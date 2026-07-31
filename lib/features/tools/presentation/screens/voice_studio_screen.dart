import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/permissions/app_permissions.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/features/tools/domain/voice.dart';
import 'package:vidspod_mobile/features/tools/tools_providers.dart';

class VoiceStudioScreen extends ConsumerWidget {
  const VoiceStudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voices = ref.watch(voicesProvider);
    return Scaffold(
      backgroundColor: VrTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: VrTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Voice Studio', style: VrTheme.headingLarge()),
          ),
          const SliverToBoxAdapter(child: _RecordPrompt()),
          const SliverToBoxAdapter(child: _VoiceCloningBanner()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Text('Available Voices', style: VrTheme.headingMedium()),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: voices.when(
              data: (items) => SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _VoiceCard(item: items[i], index: i),
                  childCount: items.length,
                ),
              ),
              loading: () => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => SliverFillRemaining(
                hasScrollBody: false,
                child: AsyncStateView(
                  loading: false,
                  errorMessage: '$error',
                  emptyMessage: '',
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
}

class _VoiceCard extends StatelessWidget {
  final Voice item;
  final int index;
  const _VoiceCard({required this.item, required this.index});

  static const _palette = [
    Color(0xFF4A90E2),
    Color(0xFFE94057),
    Color(0xFF8A2387),
    Color(0xFFF27121),
    Color(0xFF34C759),
    Color(0xFFFFD60A),
  ];

  Color get _color => _palette[index % _palette.length];

  IconData get _icon => item.isMale ? Icons.record_voice_over : Icons.face;

  Color get _providerColor {
    switch (item.provider) {
      case 'elevenlabs':
        return const Color(0xFF8A2387);
      case 'openai':
        return const Color(0xFF4A90E2);
      case 'azure':
        return const Color(0xFF00B4D8);
      default:
        return VrTheme.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _snack(context, '${item.name} voice selected'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: _color.withAlpha(60)),
          boxShadow: VrTheme.cardShadow(VrTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _color.withAlpha(30),
                    borderRadius: BorderRadius.circular(VrTheme.radiusSm),
                  ),
                  child: Icon(_icon, color: _color, size: 18),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _providerColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.provider.toUpperCase(),
                    style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      color: _providerColor.withAlpha(200),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item.name,
              style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 1),
            Text(
              item.style ?? '',
              style: VrTheme.caption(
                color: Colors.white.withAlpha(100),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                _Tag(item.accent ?? ''),
                _Tag(item.isMale ? 'Male' : 'Female'),
              ],
            ),
            const Spacer(),
            Text(
              item.bestFor ?? '',
              style: VrTheme.caption(
                color: Colors.white.withAlpha(60),
                fontSize: 9,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordPrompt extends StatelessWidget {
  const _RecordPrompt();

  Future<void> _onRecord(BuildContext context) async {
    final granted = await AppPermissions.microphone();
    if (!context.mounted) return;
    _snack(
      context,
      granted
          ? 'Recording is coming in a future update'
          : 'Microphone access is needed to record a voice sample',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: GestureDetector(
        onTap: () => _onRecord(context),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [VrTheme.purple.withAlpha(40), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(VrTheme.radiusLg),
            border: Border.all(color: VrTheme.purple.withAlpha(50)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const SweepGradient(
                    colors: [
                      VrTheme.purple,
                      VrTheme.pink,
                      VrTheme.orange,
                      VrTheme.purple,
                    ],
                  ),
                ),
                child: const Icon(Icons.mic, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Record your voice',
                      style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Or type text to convert to speech',
                      style: VrTheme.caption(color: Colors.white.withAlpha(80)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: VrTheme.brandGradient,
                  borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                ),
                child: Text(
                  'Record',
                  style: VrTheme.caption(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VoiceCloningBanner extends StatelessWidget {
  const _VoiceCloningBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [VrTheme.blue.withAlpha(30), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.blue.withAlpha(50)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: VrTheme.blue.withAlpha(30),
                borderRadius: BorderRadius.circular(VrTheme.radiusMd),
              ),
              child: const Icon(Icons.copy_all, color: VrTheme.blue, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voice Cloning',
                    style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Clone any voice with a short sample',
                    style: VrTheme.caption(color: Colors.white.withAlpha(80)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [VrTheme.blue, const Color(0xFF0083B0)],
                ),
                borderRadius: BorderRadius.circular(VrTheme.radiusFull),
              ),
              child: Text(
                'Try',
                style: VrTheme.caption(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(15),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 8, color: Colors.white.withAlpha(120)),
      ),
    );
  }
}
