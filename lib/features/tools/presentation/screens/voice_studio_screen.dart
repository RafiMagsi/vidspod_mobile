import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class VoiceStudioScreen extends StatelessWidget {
  const VoiceStudioScreen({super.key});

  static const _voices = [
    _VoiceItem('Professional', 'Deep, authoritative male voice', Icons.record_voice_over, Color(0xFF4A90E2)),
    _VoiceItem('Warm & Friendly', 'Soft, approachable female voice', Icons.face, Color(0xFFE94057)),
    _VoiceItem('Narrative', 'Cinematic storytelling voice', Icons.menu_book, Color(0xFF8A2387)),
    _VoiceItem('Energetic', 'Upbeat, high-energy presenter', Icons.bolt, Color(0xFFF27121)),
    _VoiceItem('Calm & Soothing', 'Gentle, relaxing meditation voice', Icons.water_drop, Color(0xFF34C759)),
    _VoiceItem('Character', 'Fun, cartoon-style voice acting', Icons.emoji_emotions, Color(0xFFFFD60A)),
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
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
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
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _VoiceItem(this.title, this.subtitle, this.icon, this.color);
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
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.purple.withAlpha(50)),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(colors: [
                CreatiTheme.purple, CreatiTheme.pink, CreatiTheme.orange, CreatiTheme.purple,
              ]),
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Record your voice', style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text('Or type text to convert to speech', style: CreatiTheme.caption(color: Colors.white.withAlpha(80))),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: CreatiTheme.brandGradient,
              borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
              boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
            ),
            child: Text('Record', style: CreatiTheme.caption(fontWeight: FontWeight.w600)),
          ),
        ]),
      ),
    );
  }
}

class _VoiceCard extends StatelessWidget {
  final _VoiceItem item;
  final int index;
  const _VoiceCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: item.color.withAlpha(60)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.color.withAlpha(30),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
              ),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            const Spacer(),
            Text(item.title, style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(item.subtitle, style: CreatiTheme.caption(color: Colors.white.withAlpha(80)), maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
