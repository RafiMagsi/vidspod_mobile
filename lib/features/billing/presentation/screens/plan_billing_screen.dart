import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class PlanBillingScreen extends StatelessWidget {
  const PlanBillingScreen({super.key});

  static const _plans = [
    _PlanData('Free', '\$0', '/mo', '10 credits', false, false),
    _PlanData('Creator', '\$19.99', '/mo', '100 credits/month', true, false),
    _PlanData('Studio', '\$99', '/mo', '1,000 credits/month', false, true),
  ];

  static const _creditPacks = [
    _PackData('Starter', '\$9.99', '50 credits'),
    _PackData('Boost', '\$24.99', '250 credits'),
    _PackData('Scale', '\$79.99', '1,000 credits'),
  ];

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
            title: Text('Plan & Billing', style: CreatiTheme.headingLarge()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text('Current Plan', style: CreatiTheme.headingMedium()),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CreatiTheme.purple.withAlpha(40),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                  border: Border.all(color: CreatiTheme.purple.withAlpha(60)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: CreatiTheme.proGradient,
                        borderRadius: BorderRadius.circular(
                          CreatiTheme.radiusMd,
                        ),
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Creator Plan',
                            style: CreatiTheme.bodyMedium(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '\$19.99/mo • 100 credits remaining',
                            style: CreatiTheme.caption(
                              color: Colors.white.withAlpha(80),
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
                        'Manage',
                        style: CreatiTheme.caption(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Available Plans',
                style: CreatiTheme.headingMedium(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _PlanCard(plan: _plans[i], index: i),
                childCount: _plans.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text('Credit Packs', style: CreatiTheme.headingMedium()),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) => _PackCard(pack: _creditPacks[i], index: i),
                childCount: _creditPacks.length,
              ),
            ),
          ),
          SliverToBoxAdapter(child: _PaymentMethods()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _PlanData {
  final String name;
  final String price;
  final String period;
  final String credits;
  final bool isCurrent;
  final bool isPopular;
  const _PlanData(
    this.name,
    this.price,
    this.period,
    this.credits,
    this.isCurrent,
    this.isPopular,
  );
}

class _PackData {
  final String name;
  final String price;
  final String credits;
  const _PackData(this.name, this.price, this.credits);
}

class _PlanCard extends StatelessWidget {
  final _PlanData plan;
  final int index;
  const _PlanCard({required this.plan, required this.index});

  @override
  Widget build(BuildContext context) {
    final isActive = plan.isCurrent || plan.isPopular;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(
            color: isActive
                ? CreatiTheme.purple.withAlpha(60)
                : CreatiTheme.cardBorder.withAlpha(60),
          ),
          boxShadow: isActive
              ? CreatiTheme.buttonShadow(CreatiTheme.purple.withAlpha(30))
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        plan.name,
                        style: CreatiTheme.bodyMedium(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (plan.isPopular) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            gradient: CreatiTheme.brandGradient,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Popular',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      if (plan.isCurrent) ...[
                        const SizedBox(width: 6),
                        Text(
                          'Current',
                          style: TextStyle(
                            fontSize: 10,
                            color: CreatiTheme.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        plan.price,
                        style: CreatiTheme.headingSmall(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        plan.period,
                        style: CreatiTheme.caption(
                          color: Colors.white.withAlpha(80),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plan.credits,
                    style: CreatiTheme.caption(
                      color: Colors.white.withAlpha(70),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (!plan.isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: plan.isPopular
                      ? CreatiTheme.brandGradient
                      : LinearGradient(
                          colors: [
                            Colors.white.withAlpha(15),
                            Colors.white.withAlpha(5),
                          ],
                        ),
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                  border: plan.isPopular
                      ? null
                      : Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
                ),
                child: Text(
                  plan.isPopular ? 'Upgrade' : 'Downgrade',
                  style: CreatiTheme.caption(
                    fontWeight: FontWeight.w600,
                    color: plan.isPopular
                        ? Colors.white
                        : Colors.white.withAlpha(140),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PackCard extends StatelessWidget {
  final _PackData pack;
  final int index;
  const _PackCard({required this.pack, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credit pack purchase flow')),
      ),
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: index == 1
                    ? CreatiTheme.brandGradient
                    : CreatiTheme.proGradient,
                borderRadius: BorderRadius.circular(CreatiTheme.radiusSm),
              ),
              child: Icon(Icons.auto_awesome, color: Colors.white, size: 16),
            ),
            const Spacer(),
            Text(
              pack.name,
              style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              pack.credits,
              style: CreatiTheme.caption(
                color: Colors.white.withAlpha(70),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              pack.price,
              style: CreatiTheme.headingSmall(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethods extends StatelessWidget {
  const _PaymentMethods();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
              'Payment Methods',
              style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.credit_card,
                  color: Colors.white.withAlpha(120),
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '•••• 4242',
                    style: CreatiTheme.bodySmall(
                      color: Colors.white.withAlpha(140),
                    ),
                  ),
                ),
                Text(
                  'Expires 12/27',
                  style: CreatiTheme.caption(
                    color: Colors.white.withAlpha(60),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add payment method flow')),
              ),
              child: Text(
                '+ Add Payment Method',
                style: TextStyle(
                  fontSize: 12,
                  color: CreatiTheme.purple.withAlpha(180),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
