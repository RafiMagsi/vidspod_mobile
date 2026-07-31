import 'package:flutter/material.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';

class ShimmerWidget extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 14,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _animation = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              colors: [
                VrTheme.darkSurface,
                VrTheme.lightSurface,
                VrTheme.mediumSurface,
                VrTheme.darkSurface,
              ],
              stops: [
                (_animation.value - 0.6).clamp(0.0, 1.0),
                (_animation.value - 0.2).clamp(0.0, 1.0),
                (_animation.value + 0.2).clamp(0.0, 1.0),
                (_animation.value + 0.6).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
