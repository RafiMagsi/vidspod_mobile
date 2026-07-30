import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  static const _transactions = [
    _TxItem(
      'Credit Pack Purchase',
      'Boost - 250 credits',
      '+250',
      '\$24.99',
      'Completed',
      Icons.add_circle_outline,
      CreatiTheme.green,
    ),
    _TxItem(
      'AI Video Generation',
      'Project: Summer Promo',
      '-25',
      '',
      'Completed',
      Icons.videocam_outlined,
      CreatiTheme.purple,
    ),
    _TxItem(
      'Subscription Renewal',
      'Creator Plan - March',
      '+100',
      '\$19.99',
      'Completed',
      Icons.workspace_premium_outlined,
      CreatiTheme.blue,
    ),
    _TxItem(
      'Image Generation',
      'Text to Image (4 images)',
      '-8',
      '',
      'Completed',
      Icons.image_outlined,
      CreatiTheme.orange,
    ),
    _TxItem(
      'Voice Clone Enrollment',
      'Voice: Professional Narrator',
      '-50',
      '',
      'Completed',
      Icons.record_voice_over_outlined,
      CreatiTheme.pink,
    ),
    _TxItem(
      'Credit Refund',
      'Failed generation - AI Video',
      '+25',
      '',
      'Refunded',
      Icons.replay_outlined,
      Colors.amber,
    ),
    _TxItem(
      'Script Generation',
      'YouTube Script: Tech Review',
      '-5',
      '',
      'Completed',
      Icons.article_outlined,
      Colors.teal,
    ),
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
            title: Text('Transactions', style: CreatiTheme.headingLarge()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  _FilterChip('All', true),
                  const SizedBox(width: 8),
                  _FilterChip('Credits', false),
                  const SizedBox(width: 8),
                  _FilterChip('Payments', false),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Text(
                    '1,250 credits',
                    style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    'Total spent: \$44.98',
                    style: CreatiTheme.caption(
                      color: Colors.white.withAlpha(80),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _TransactionCard(item: _transactions[i], index: i),
                childCount: _transactions.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _TxItem {
  final String title;
  final String subtitle;
  final String amount;
  final String amountUsd;
  final String status;
  final IconData icon;
  final Color color;
  const _TxItem(
    this.title,
    this.subtitle,
    this.amount,
    this.amountUsd,
    this.status,
    this.icon,
    this.color,
  );
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip(this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: selected ? CreatiTheme.brandGradient : null,
        color: selected ? null : CreatiTheme.surfaceDark,
        borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
        border: selected
            ? null
            : Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : Colors.white.withAlpha(120),
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final _TxItem item;
  final int index;
  const _TransactionCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final isCredit = item.amount.startsWith('+');
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.color.withAlpha(20),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusSm),
              ),
              child: Icon(item.icon, color: item.color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: CreatiTheme.bodySmall(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: CreatiTheme.caption(
                      color: Colors.white.withAlpha(60),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isCredit ? '+' : ''}${item.amount} cr',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isCredit
                        ? CreatiTheme.green
                        : Colors.white.withAlpha(180),
                  ),
                ),
                if (item.amountUsd.isNotEmpty)
                  Text(
                    item.amountUsd,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withAlpha(60),
                    ),
                  ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: item.status == 'Completed'
                        ? CreatiTheme.green.withAlpha(20)
                        : Colors.amber.withAlpha(20),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: item.status == 'Completed'
                          ? CreatiTheme.green
                          : Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
