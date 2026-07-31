import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/widgets/shimmer_widget.dart';

/// Cached network image with an in-app shimmer placeholder and a themed
/// fallback. Every remote thumbnail should go through this widget so repeated
/// list rebuilds hit the disk cache instead of re-fetching (§3.3 media URLs).
class AppNetworkImage extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final double width;
  final double height;
  final double borderRadius;
  final IconData placeholderIcon;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = VrTheme.radiusLg,
    this.placeholderIcon = Icons.image_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = url;
    if (imageUrl == null || imageUrl.isEmpty) {
      return _fallback();
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (_, _) => ShimmerWidget(
        width: width,
        height: height,
        borderRadius: borderRadius,
      ),
      errorWidget: (_, _, _) => _fallback(),
    );
  }

  Widget _fallback() {
    return Container(
      width: width,
      height: height,
      color: VrTheme.darkSurface,
      child: Icon(
        placeholderIcon,
        color: VrTheme.textSecondary.withAlpha(90),
        size: 28,
      ),
    );
  }
}
