import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final index = _calculateSelectedIndex(context);
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        body: child,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: VrTheme.surfaceDark, width: 0.5),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: VrTheme.nearBlack,
            selectedItemColor: VrTheme.purple,
            unselectedItemColor: VrTheme.textSecondary,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Creator',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business_center_outlined),
                activeIcon: Icon(Icons.business_center),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.record_voice_over_outlined),
                activeIcon: Icon(Icons.record_voice_over),
                label: 'Speak',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.build_outlined),
                activeIcon: Icon(Icons.build),
                label: 'Tools',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                activeIcon: Icon(Icons.history),
                label: 'History',
              ),
            ],
            currentIndex: index,
            onTap: (i) {
              hapticTap();
              _onTap(i, context);
            },
          ),
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/profile')) return 0;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/business')) return 1;
    if (location.startsWith('/speak')) return 2;
    if (location.startsWith('/tools')) return 3;
    if (location.startsWith('/history')) return 4;
    return 0;
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
      case 1:
        context.go('/business');
      case 2:
        context.go('/speak');
      case 3:
        context.go('/tools');
      case 4:
        context.go('/history');
    }
  }
}
