import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: CreatiTheme.black,
            surfaceTintColor: Colors.transparent,
            title: Text('Refer & Earn', style: CreatiTheme.headingLarge()),
          ),
          SliverToBoxAdapter(child: _HeroSection()),
          SliverToBoxAdapter(child: _ReferralCode()),
          SliverToBoxAdapter(child: _StatsRow()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('How it works', style: CreatiTheme.headingMedium()),
            ),
          ),
          SliverToBoxAdapter(
            child: _StepCard(
              1,
              'Share your unique referral link',
              Icons.share_outlined,
              CreatiTheme.purple,
            ),
          ),
          SliverToBoxAdapter(
            child: _StepCard(
              2,
              'Friends sign up using your link',
              Icons.person_add_outlined,
              CreatiTheme.blue,
            ),
          ),
          SliverToBoxAdapter(
            child: _StepCard(
              3,
              'Earn 50 credits per referral',
              Icons.auto_awesome,
              CreatiTheme.pink,
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
              CreatiTheme.purple.withAlpha(60),
              CreatiTheme.pink.withAlpha(30),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(CreatiTheme.radiusXl),
          border: Border.all(color: CreatiTheme.purple.withAlpha(50)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: CreatiTheme.brandGradient,
                shape: BoxShape.circle,
                boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
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
              style: CreatiTheme.headingSmall(fontSize: 22),
            ),
            const SizedBox(height: 6),
            Text(
              'For every friend who joins using your link',
              style: CreatiTheme.bodySmall(color: Colors.white.withAlpha(100)),
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
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Referral Code',
              style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
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
                      color: CreatiTheme.darkSurface,
                      borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
                      border: Border.all(
                        color: CreatiTheme.cardBorder.withAlpha(50),
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
                      gradient: CreatiTheme.brandGradient,
                      borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
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
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                  gradient: CreatiTheme.brandGradient,
                  boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
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
                        style: CreatiTheme.bodySmall(
                          fontWeight: FontWeight.w600,
                        ),
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
        color: CreatiTheme.surfaceDark,
        borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
        border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
      ),
      child: Column(
        children: [
          Icon(icon, color: CreatiTheme.purple.withAlpha(180), size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: CreatiTheme.headingSmall(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: CreatiTheme.caption(
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
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: CreatiTheme.brandGradient,
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
                style: CreatiTheme.bodySmall(fontWeight: FontWeight.w500),
              ),
            ),
            Icon(icon, color: color.withAlpha(150), size: 20),
          ],
        ),
      ),
    );
  }
}
