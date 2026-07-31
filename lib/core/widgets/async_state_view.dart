import 'package:flutter/material.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';

/// Standard empty / error / loading states per docs/MOBILE_APP_GUIDE.md §8.
///
/// Use in place of hand-rolled per-screen placeholders so the app reads the
/// same everywhere.
class AsyncStateView extends StatelessWidget {
  final bool loading;
  final String? errorMessage;
  final String emptyMessage;
  final IconData emptyIcon;
  final Widget? child;

  const AsyncStateView({
    super.key,
    required this.loading,
    required this.emptyMessage,
    this.errorMessage,
    this.emptyIcon = Icons.inbox_outlined,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: platformLoader(size: 28));
    }
    if (errorMessage != null) {
      return _MessageState(
        icon: Icons.error_outline,
        color: VrTheme.orange,
        title: 'Something went wrong',
        message: errorMessage!,
      );
    }
    if (child == null) {
      return _MessageState(
        icon: emptyIcon,
        color: Colors.white.withAlpha(60),
        title: emptyMessage,
      );
    }
    return child!;
  }
}

class _MessageState extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? message;
  const _MessageState({
    required this.icon,
    required this.color,
    required this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 6),
              Text(
                message!,
                style: VrTheme.bodySmall(color: Colors.white.withAlpha(80)),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
