import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/widgets/app_category_section.dart';
import 'package:vidspod_mobile/core/widgets/app_motion_card.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: VrTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Business', style: VrTheme.headingLarge()),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: VrTheme.darkSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
                onPressed: () => context.push('/product-upload'),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: _BusinessCategory('Beauty', 'beauty'),
          ),
          const SliverToBoxAdapter(
            child: _BusinessCategory('Electronics & Software', 'elec'),
          ),
          const SliverToBoxAdapter(
            child: _BusinessCategory('Fashion', 'fashion'),
          ),
          const SliverToBoxAdapter(
            child: _BusinessCategory('Food & Beverage', 'food'),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _BusinessCategory extends StatelessWidget {
  final String title;
  final String seed;
  const _BusinessCategory(this.title, this.seed);

  @override
  Widget build(BuildContext context) {
    return AppCategorySection(
      title: title,
      itemCount: 4,
      itemBuilder: (_, i) => AppMotionCard(
        imageUrl: 'https://picsum.photos/seed/$seed$i/300/400',
        label: title,
        route: '/motions',
        icon: Icons.business_center_outlined,
      ),
    );
  }
}
