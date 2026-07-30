import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppCategorySection extends StatelessWidget {
  final String title;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final void Function()? onAllTap;
  final double itemHeight;

  const AppCategorySection({
    super.key,
    required this.title,
    required this.itemCount,
    required this.itemBuilder,
    this.onAllTap,
    this.itemHeight = 190,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: onAllTap ?? () => context.go('/motions'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'All',
                        style: TextStyle(
                          color: Colors.white.withAlpha(140),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white.withAlpha(90),
                        size: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: itemHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: itemCount,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: itemBuilder,
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
