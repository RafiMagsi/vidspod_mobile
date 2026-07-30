import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';
import 'package:vidspod_mobile/core/widgets/app_category_section.dart';

class ImageStudioScreen extends StatelessWidget {
  const ImageStudioScreen({super.key});

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
            title: Text('Image Studio', style: CreatiTheme.headingLarge()),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.white.withAlpha(20), borderRadius: BorderRadius.circular(CreatiTheme.radiusFull)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.auto_awesome, color: CreatiTheme.purple.withAlpha(200), size: 14),
                  const SizedBox(width: 4),
                  Text('AI', style: CreatiTheme.caption(color: Colors.white.withAlpha(180))),
                ]),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: _UploadPrompt()),
          const SliverToBoxAdapter(child: _StudioCategory('Style Transfer', 'style')),
          const SliverToBoxAdapter(child: _StudioCategory('Image Generate', 'igen')),
          const SliverToBoxAdapter(child: _StudioCategory('Enhance & Edit', 'enhance')),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _UploadPrompt extends StatelessWidget {
  const _UploadPrompt();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: CreatiTheme.brandGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.image_outlined, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 14),
          Text('Upload or generate an image', style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Create stunning AI-powered visuals', style: CreatiTheme.bodySmall(color: Colors.white.withAlpha(80))),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _SmallChip(Icons.upload_outlined, 'Upload', () {}),
            const SizedBox(width: 10),
            _SmallChip(Icons.auto_awesome, 'Generate', () {}),
          ]),
        ]),
      ),
    );
  }
}

class _SmallChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SmallChip(this.icon, this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: CreatiTheme.brandGradient,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
          boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: Colors.white.withAlpha(230), size: 14),
          const SizedBox(width: 6),
          Text(label, style: CreatiTheme.caption(fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}

class _StudioCategory extends StatelessWidget {
  final String title;
  final String seed;
  const _StudioCategory(this.title, this.seed);

  @override
  Widget build(BuildContext context) {
    return AppCategorySection(
      title: title,
      itemCount: 4,
      itemBuilder: (_, i) => AppMotionCard(
        imageUrl: 'https://picsum.photos/seed/$seed$i/300/400',
        label: '$title ${i + 1}',
        route: '/motions/$seed-$i',
        icon: Icons.image_outlined,
      ),
    );
  }
}
