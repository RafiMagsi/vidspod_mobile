import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/features/auth/application/auth_service.dart';
import 'package:vidspod_mobile/features/dashboard/dashboard_providers.dart';
import 'package:vidspod_mobile/features/profile/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final summary = ref.watch(dashboardSummaryProvider);
    final authNotifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: profile.when(
        data: (profile) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: CreatiTheme.black,
              surfaceTintColor: Colors.transparent,
              title: Text('Profile', style: CreatiTheme.headingLarge()),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: CreatiTheme.brandGradient,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CreatiTheme.darkSurface,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white38,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    profile.displayName,
                    style: CreatiTheme.headingSmall(fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.email,
                    style: CreatiTheme.bodySmall(
                      color: Colors.white.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: summary.when(
                  data: (summary) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CreatiTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                      border: Border.all(
                        color: CreatiTheme.cardBorder.withAlpha(60),
                      ),
                      boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: CreatiTheme.brandGradient,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Credit Balance',
                                    style: CreatiTheme.bodyMedium(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${summary.creditBalance} credits',
                                    style: CreatiTheme.caption(
                                      color: Colors.white.withAlpha(100),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                gradient: CreatiTheme.brandGradient,
                                borderRadius: BorderRadius.circular(
                                  CreatiTheme.radiusFull,
                                ),
                              ),
                              child: Text(
                                'Buy',
                                style: CreatiTheme.caption(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _StatChip(
                              '${summary.recentGenerationsCount}',
                              'Generations',
                            ),
                            const SizedBox(width: 8),
                            _StatChip('Pro', 'Plan'),
                            const SizedBox(width: 8),
                            _StatChip('0', 'Referrals'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  loading: () => const SizedBox(
                    height: 80,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: CreatiTheme.purple,
                      ),
                    ),
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
            ),
            SliverToBoxAdapter(child: _SectionHeader('Account')),
            SliverToBoxAdapter(
              child: _MenuTile(
                Icons.history_outlined,
                'Generation History',
                () => context.go('/generations'),
              ),
            ),
            SliverToBoxAdapter(
              child: _MenuTile(
                Icons.favorite_border,
                'Saved Motions',
                () => context.go('/motions'),
              ),
            ),
            SliverToBoxAdapter(
              child: _MenuTile(Icons.dashboard_outlined, 'Brand Kits', () {}),
            ),
            SliverToBoxAdapter(child: _SectionHeader('Subscription')),
            SliverToBoxAdapter(
              child: _MenuTile(
                Icons.workspace_premium_outlined,
                'Plan & Billing',
                () {},
              ),
            ),
            SliverToBoxAdapter(
              child: _MenuTile(Icons.history, 'Transaction History', () {}),
            ),
            SliverToBoxAdapter(
              child: _MenuTile(Icons.share_outlined, 'Refer & Earn', () {}),
            ),
            SliverToBoxAdapter(child: _SectionHeader('Settings')),
            SliverToBoxAdapter(
              child: _MenuTile(
                Icons.settings_outlined,
                'Settings',
                () => context.go('/settings'),
              ),
            ),
            SliverToBoxAdapter(
              child: _MenuTile(Icons.help_outline, 'Help & Support', () {}),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
                child: GestureDetector(
                  onTap: () => authNotifier.logout(),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.red.withAlpha(80)),
                      color: Colors.red.withAlpha(15),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red.withAlpha(200),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red.withAlpha(200),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white38,
          ),
        ),
        error: (error, _) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.white38),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;
  const _StatChip(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: CreatiTheme.bodySmall(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: CreatiTheme.caption(
                color: Colors.white.withAlpha(80),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: CreatiTheme.bodySmall(
          fontWeight: FontWeight.w600,
          color: CreatiTheme.textSecondary,
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _MenuTile(this.icon, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: CreatiTheme.cardBorder.withAlpha(40)),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white.withAlpha(150), size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: CreatiTheme.bodyMedium(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withAlpha(80),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
