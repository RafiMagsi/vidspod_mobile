import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';

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
    this.height = 267,
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
        hapticTap();
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
            borderRadius: BorderRadius.circular(VrTheme.radiusLg),
            color: VrTheme.darkSurface,
            border: Border.all(
              color: _pressed
                  ? VrTheme.purple.withAlpha(100)
                  : VrTheme.cardBorder.withAlpha(80),
            ),
            boxShadow: _pressed
                ? [
                    BoxShadow(
                      color: VrTheme.purple.withAlpha(15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : VrTheme.cardShadow(VrTheme.black),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(
                url: widget.imageUrl,
                width: widget.width,
                height: widget.height,
                placeholderIcon: widget.icon ?? Icons.movie_creation_outlined,
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: VrTheme.brandGradient,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        VrTheme.black.withAlpha(200),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
              ),
              if (_pressed)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: VrTheme.purple.withAlpha(10),
                      borderRadius: BorderRadius.circular(VrTheme.radiusLg),
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
