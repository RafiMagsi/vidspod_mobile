import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VrTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: VrTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Refer & Earn', style: VrTheme.headingLarge()),
          ),
          SliverToBoxAdapter(child: _HeroSection()),
          SliverToBoxAdapter(child: _ReferralCode()),
          SliverToBoxAdapter(child: _StatsRow()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('How it works', style: VrTheme.headingMedium()),
            ),
          ),
          SliverToBoxAdapter(
            child: _StepCard(
              1,
              'Share your unique referral link',
              Icons.share_outlined,
              VrTheme.purple,
            ),
          ),
          SliverToBoxAdapter(
            child: _StepCard(
              2,
              'Friends sign up using your link',
              Icons.person_add_outlined,
              VrTheme.blue,
            ),
          ),
          SliverToBoxAdapter(
            child: _StepCard(
              3,
              'Earn 50 credits per referral',
              Icons.auto_awesome,
              VrTheme.pink,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              VrTheme.purple.withAlpha(60),
              VrTheme.pink.withAlpha(30),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(VrTheme.radiusXl),
          border: Border.all(color: VrTheme.purple.withAlpha(50)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: VrTheme.brandGradient,
                shape: BoxShape.circle,
                boxShadow: VrTheme.buttonShadow(VrTheme.purple),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Earn 50 Free Credits',
              style: VrTheme.headingSmall(fontSize: 22),
            ),
            const SizedBox(height: 6),
            Text(
              'For every friend who joins using your link',
              style: VrTheme.bodySmall(color: Colors.white.withAlpha(100)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReferralCode extends StatelessWidget {
  const _ReferralCode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Referral Code',
              style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: VrTheme.darkSurface,
                      borderRadius: BorderRadius.circular(VrTheme.radiusMd),
                      border: Border.all(
                        color: VrTheme.cardBorder.withAlpha(50),
                      ),
                    ),
                    child: Text(
                      'VIDSPOD-ABC123',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => Clipboard.setData(
                    const ClipboardData(text: 'VIDSPOD-ABC123'),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: VrTheme.brandGradient,
                      borderRadius: BorderRadius.circular(VrTheme.radiusMd),
                    ),
                    child: const Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Clipboard.setData(const ClipboardData(text: 'VIDSPOD-ABC123'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Referral link copied!')),
                );
              },
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                  gradient: VrTheme.brandGradient,
                  boxShadow: VrTheme.buttonShadow(VrTheme.purple),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white.withAlpha(230),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Share Link',
                        style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(child: _StatCard('0', 'Referrals', Icons.people_outline)),
          const SizedBox(width: 12),
          Expanded(child: _StatCard('0', 'Credits Earned', Icons.auto_awesome)),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard('0', 'Rewards', Icons.card_giftcard_outlined),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  const _StatCard(this.value, this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: VrTheme.surfaceDark,
        borderRadius: BorderRadius.circular(VrTheme.radiusMd),
        border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
      ),
      child: Column(
        children: [
          Icon(icon, color: VrTheme.purple.withAlpha(180), size: 20),
          const SizedBox(height: 8),
          Text(value, style: VrTheme.headingSmall(fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(
            label,
            style: VrTheme.caption(
              color: Colors.white.withAlpha(80),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int step;
  final String description;
  final IconData icon;
  final Color color;
  const _StepCard(this.step, this.description, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: VrTheme.brandGradient,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$step',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                description,
                style: VrTheme.bodySmall(fontWeight: FontWeight.w500),
              ),
            ),
            Icon(icon, color: color.withAlpha(150), size: 20),
          ],
        ),
      ),
    );
  }
}
