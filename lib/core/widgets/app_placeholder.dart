import 'package:flutter/material.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';

class AppPlaceholder extends StatelessWidget {
  final IconData icon;

  const AppPlaceholder({super.key, this.icon = Icons.movie_creation_outlined});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            VrTheme.lightSurface,
            VrTheme.mediumSurface,
            VrTheme.darkSurface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white.withAlpha(25), size: 32),
            const SizedBox(height: 4),
            Text(
              'N/A',
              style: TextStyle(color: Colors.white.withAlpha(15), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
