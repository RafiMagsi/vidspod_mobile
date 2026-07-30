import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class VoiceStudioScreen extends StatelessWidget {
  const VoiceStudioScreen({super.key});

  static const _voices = [
    _VoiceItem(
      'Daniel',
      'Professional',
      'elevenlabs',
      'English',
      'American',
      'Deep authoritative male voice',
      'male',
      'narration, podcasts',
      Icons.record_voice_over,
      Color(0xFF4A90E2),
    ),
    _VoiceItem(
      'Emma',
      'Warm & Friendly',
      'elevenlabs',
      'English',
      'British',
      'Soft approachable female voice',
      'female',
      'storytelling, tutorials',
      Icons.face,
      Color(0xFFE94057),
    ),
    _VoiceItem(
      'Liam',
      'Narrative',
      'openai',
      'English',
      'American',
      'Cinematic storytelling voice',
      'male',
      'documentaries, ads',
      Icons.menu_book,
      Color(0xFF8A2387),
    ),
    _VoiceItem(
      'Sophia',
      'Energetic',
      'azure',
      'English',
      'American',
      'Upbeat high-energy presenter',
      'female',
      'commercials, promos',
      Icons.bolt,
      Color(0xFFF27121),
    ),
    _VoiceItem(
      'Oliver',
      'Calm & Soothing',
      'elevenlabs',
      'English',
      'British',
      'Gentle relaxing meditation voice',
      'male',
      'meditation, ASMR',
      Icons.water_drop,
      Color(0xFF34C759),
    ),
    _VoiceItem(
      'Aria',
      'Character',
      'elevenlabs',
      'English',
      'American',
      'Fun cartoon-style voice acting',
      'female',
      'animation, gaming',
      Icons.emoji_emotions,
      Color(0xFFFFD60A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: CreatiTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Voice Studio', style: CreatiTheme.headingLarge()),
          ),
          const SliverToBoxAdapter(child: _RecordPrompt()),
          const SliverToBoxAdapter(child: _VoiceCloningBanner()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Text(
                'Available Voices',
                style: CreatiTheme.headingMedium(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) => _VoiceCard(item: _voices[i], index: i),
                childCount: _voices.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _VoiceItem {
  final String name;
  final String style;
  final String provider;
  final String languageCode;
  final String accent;
  final String description;
  final String gender;
  final String bestFor;
  final IconData icon;
  final Color color;
  const _VoiceItem(
    this.name,
    this.style,
    this.provider,
    this.languageCode,
    this.accent,
    this.description,
    this.gender,
    this.bestFor,
    this.icon,
    this.color,
  );
}

class _RecordPrompt extends StatelessWidget {
  const _RecordPrompt();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [CreatiTheme.purple.withAlpha(40), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.purple.withAlpha(50)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const SweepGradient(
                  colors: [
                    CreatiTheme.purple,
                    CreatiTheme.pink,
                    CreatiTheme.orange,
                    CreatiTheme.purple,
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
                    style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Or type text to convert to speech',
                    style: CreatiTheme.caption(
                      color: Colors.white.withAlpha(80),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: CreatiTheme.brandGradient,
                borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
              ),
              child: Text(
                'Record',
                style: CreatiTheme.caption(fontWeight: FontWeight.w600),
              ),
            ),
          ],
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
            colors: [CreatiTheme.blue.withAlpha(30), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.blue.withAlpha(50)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CreatiTheme.blue.withAlpha(30),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
              ),
              child: const Icon(
                Icons.copy_all,
                color: CreatiTheme.blue,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voice Cloning',
                    style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Clone any voice with a short sample',
                    style: CreatiTheme.caption(
                      color: Colors.white.withAlpha(80),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [CreatiTheme.blue, const Color(0xFF0083B0)],
                ),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
              ),
              child: Text(
                'Try',
                style: CreatiTheme.caption(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VoiceCard extends StatelessWidget {
  final _VoiceItem item;
  final int index;
  const _VoiceCard({required this.item, required this.index});

  Color get _providerColor {
    switch (item.provider) {
      case 'elevenlabs':
        return const Color(0xFF8A2387);
      case 'openai':
        return const Color(0xFF4A90E2);
      case 'azure':
        return const Color(0xFF00B4D8);
      default:
        return CreatiTheme.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: item.color.withAlpha(60)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withAlpha(30),
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusSm),
                  ),
                  child: Icon(item.icon, color: item.color, size: 18),
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
              style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 1),
            Text(
              item.style,
              style: CreatiTheme.caption(
                color: Colors.white.withAlpha(100),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                _Tag(item.accent),
                _Tag(item.gender == 'male' ? 'Male' : 'Female'),
              ],
            ),
            const Spacer(),
            Text(
              item.bestFor,
              style: CreatiTheme.caption(
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
