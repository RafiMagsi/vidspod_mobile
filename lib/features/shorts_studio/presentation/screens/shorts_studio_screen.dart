import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/widgets/custom_bottom_nav_bar.dart';
import 'package:vidspod_mobile/core/widgets/gradient_button.dart';
import 'package:vidspod_mobile/features/motions/domain/motion.dart';
import 'package:vidspod_mobile/features/motions/motion_providers.dart';
import 'package:vidspod_mobile/features/shorts_studio/state/shorts_studio_state.dart';

class ShortsStudioScreen extends ConsumerWidget {
  const ShortsStudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortsStudioState = ref.watch(shortsStudioProvider);
    final shortsStudioNotifier = ref.read(shortsStudioProvider.notifier);
    final motionsAsync = ref.watch(motionListProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 350.0,
            backgroundColor: Colors.black,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/vidspod-2282a.appspot.com/o/spider_man.png?alt=media&token=29998159-2346-4456-8ab0-3abe29a393d4',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                          Colors.black.withOpacity(0.9)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child:
                          const Icon(Icons.headset, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Text('PRO',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const Text(
                          'SeeDance 2.5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.7),
                        Colors.blue.withOpacity(0.7)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Start From Photo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildCategoryList(),
          SliverToBoxAdapter(
            child: _buildSectionTitle('Profile Photo'),
          ),
          _buildMotionsList([], isCircular: true),
          SliverToBoxAdapter(
            child: _buildSectionTitle('Trending'),
          ),
          _buildMotionsList([], isCircular: false),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      Category(
          icon: Icons.slideshow,
          name: 'SeeDance',
          badge: 'New',
          color: Colors.blue),
      Category(
          icon: Icons.nightlight_round,
          name: 'Nano Banana',
          badge: 'Hot',
          color: Colors.orange),
      Category(
          icon: Icons.movie_filter,
          name: 'Text to Video',
          badge: 'Seedance 2',
          color: Colors.cyan),
      Category(
          icon: Icons.image,
          name: 'Image',
          badge: '',
          color: Colors.transparent),
    ];
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category.icon, color: Colors.white),
                        const SizedBox(height: 4),
                        Text(category.name,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  if (category.badge.isNotEmpty)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: category.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          category.badge,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'All >',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMotionsList(List<Motion> motions, {bool isCircular = false}) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: motions.isEmpty ? 5 : motions.length,
          itemBuilder: (context, index) {
            if (motions.isEmpty) {
              return Container(
                width: isCircular ? 150 : 110,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: isCircular ? 1 / 1 : 9 / 16,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            shape: isCircular
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            borderRadius:
                                isCircular ? null : BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    if (!isCircular) const SizedBox(height: 8),
                    if (!isCircular)
                      Container(
                        height: 15,
                        width: 80,
                        color: Colors.grey[900],
                      ),
                  ],
                ),
              );
            }
            final motion = motions[index];
            return GestureDetector(
              onTap: () {
                context.push('/motions/${motion.publicGuid}');
              },
              child: Container(
                width: 110,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(12),
                            image: motion.thumbnailUrl.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(motion.thumbnailUrl),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: motion.thumbnailUrl.isEmpty
                              ? const Center(
                                  child: Icon(Icons.movie_creation,
                                      color: Colors.white),
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      motion.title,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Category {
  final IconData icon;
  final String name;
  final String badge;
  final Color color;

  Category(
      {required this.icon,
      required this.name,
      required this.badge,
      required this.color});
}
