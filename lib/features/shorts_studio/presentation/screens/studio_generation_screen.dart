import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class StudioGenerationScreen extends StatelessWidget {
  final String id;
  const StudioGenerationScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: CreatiTheme.black,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('Generation $id', style: CreatiTheme.caption(fontWeight: FontWeight.w600)),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://picsum.photos/seed/gen$id/800/600',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: CreatiTheme.darkSurface),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, CreatiTheme.black.withAlpha(200)],
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(140),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black.withAlpha(100), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
              ),
              onPressed: () => context.pop(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CreatiTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                    border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
                    boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          gradient: CreatiTheme.brandGradient,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 14),
                      ),
                      const SizedBox(width: 10),
                      Text('Generation Complete', style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600)),
                    ]),
                    const SizedBox(height: 16),
                    _InfoRow('Duration', '15 seconds'),
                    _InfoRow('Format', 'MP4 - 1080p'),
                    _InfoRow('Created', 'Today, 2:30 PM'),
                  ]),
                ),
                const SizedBox(height: 16),
                Text('Actions', style: CreatiTheme.headingSmall()),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(child: _ActionButton(Icons.download_outlined, 'Download', Colors.white, filled: true)),
                  const SizedBox(width: 10),
                  Expanded(child: _ActionButton(Icons.share_outlined, 'Share', Colors.white, filled: false)),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(child: _ActionButton(Icons.content_copy_outlined, 'Duplicate', Colors.white, filled: false)),
                  const SizedBox(width: 10),
                  Expanded(child: _ActionButton(Icons.delete_outline, 'Delete', Colors.red, filled: false)),
                ]),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Text(label, style: CreatiTheme.bodySmall(color: Colors.white.withAlpha(120))),
        const Spacer(),
        Text(value, style: CreatiTheme.bodySmall(fontWeight: FontWeight.w500)),
      ]),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool filled;
  const _ActionButton(this.icon, this.label, this.color, {required this.filled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
          color: filled ? color.withAlpha(25) : Colors.transparent,
          border: filled ? null : Border.all(color: color.withAlpha(50)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: color.withAlpha(200), size: 16),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color.withAlpha(200), fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.15)),
        ]),
      ),
    );
  }
}
