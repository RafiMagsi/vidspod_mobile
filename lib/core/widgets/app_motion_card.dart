import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/widgets/app_placeholder.dart';
import 'package:vidspod_mobile/core/widgets/shimmer_widget.dart';

class AppMotionCard extends StatefulWidget {
  final String imageUrl;
  final String label;
  final IconData? icon;
  final String route;
  final double width;
  final double height;

  const AppMotionCard({
    super.key,
    required this.imageUrl,
    required this.label,
    this.icon,
    required this.route,
    this.width = 150,
    this.height = 190,
  });

  @override
  State<AppMotionCard> createState() => _AppMotionCardState();
}

class _AppMotionCardState extends State<AppMotionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressed = true);
        _scaleController.forward();
      },
      onTapUp: (_) {
        _scaleController.reverse();
        setState(() => _pressed = false);
        context.push(widget.route);
      },
      onTapCancel: () {
        _scaleController.reverse();
        setState(() => _pressed = false);
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (_, child) => Transform.scale(
          scale: 1 - _scaleAnimation.value * 0.04,
          child: child,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
            color: CreatiTheme.darkSurface,
            border: Border.all(
              color: _pressed
                  ? CreatiTheme.purple.withAlpha(100)
                  : CreatiTheme.cardBorder.withAlpha(80),
            ),
            boxShadow: _pressed
                ? [BoxShadow(color: CreatiTheme.purple.withAlpha(15), blurRadius: 12, offset: const Offset(0, 4))]
                : CreatiTheme.cardShadow(CreatiTheme.black),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => ShimmerWidget(
                  width: widget.width,
                  height: widget.height,
                ),
                errorWidget: (_, __, ___) =>
                    AppPlaceholder(icon: widget.icon ?? Icons.movie_creation_outlined),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: CreatiTheme.brandGradient,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.auto_awesome, color: Colors.white, size: 10),
                ),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        CreatiTheme.black.withAlpha(200),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                    )),
                ),
              ),
              if (_pressed)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: CreatiTheme.purple.withAlpha(10),
                      borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
