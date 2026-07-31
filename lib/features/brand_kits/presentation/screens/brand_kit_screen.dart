import 'package:flutter/material.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';

class BrandKitScreen extends StatelessWidget {
  const BrandKitScreen({super.key});

  static const _brandKits = [
    _BrandKitData(
      'Main Brand',
      ['#7C3AED', '#E94057', '#F27121'],
      'Inter',
      true,
    ),
    _BrandKitData(
      'Client A',
      ['#2563EB', '#06B6D4', '#10B981'],
      'Poppins',
      false,
    ),
    _BrandKitData(
      'Personal',
      ['#F43F5E', '#F97316', '#FBBF24'],
      'DM Sans',
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VrTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: VrTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Brand Kits', style: VrTheme.headingLarge()),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: VrTheme.brandGradient,
                  borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'New',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: _InfoBanner()),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _BrandKitCard(item: _brandKits[i], index: i),
                childCount: _brandKits.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _BrandKitData {
  final String name;
  final List<String> colors;
  final String font;
  final bool isActive;
  const _BrandKitData(this.name, this.colors, this.font, this.isActive);
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [VrTheme.purple.withAlpha(30), Colors.transparent],
          ),
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.purple.withAlpha(50)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: VrTheme.purple.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.palette_outlined,
                color: VrTheme.purple,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brand Identity',
                    style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Store colors, fonts, and logos for consistent branding',
                    style: VrTheme.caption(color: Colors.white.withAlpha(80)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandKitCard extends StatelessWidget {
  final _BrandKitData item;
  final int index;
  const _BrandKitCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(
            color: item.isActive
                ? VrTheme.purple.withAlpha(60)
                : VrTheme.cardBorder.withAlpha(60),
          ),
          boxShadow: item.isActive
              ? VrTheme.buttonShadow(VrTheme.purple.withAlpha(30))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item.name,
                  style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                if (item.isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      gradient: VrTheme.brandGradient,
                      borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                    ),
                    child: Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.name} activated')),
                    ),
                    child: Text(
                      'Activate',
                      style: TextStyle(
                        fontSize: 11,
                        color: VrTheme.purple.withAlpha(180),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: item.colors
                  .map(
                    (c) => Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: Color(int.parse(c.replaceFirst('#', '0xFF'))),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white.withAlpha(20)),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.text_fields,
                  color: Colors.white.withAlpha(80),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  item.font,
                  style: TextStyle(
                    color: Colors.white.withAlpha(100),
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Editing ${item.name}')),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(120),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
