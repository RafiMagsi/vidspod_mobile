import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';

class ScriptWriterScreen extends StatelessWidget {
  const ScriptWriterScreen({super.key});

  static const _templates = [
    _ScriptTemplate(
      'YouTube Script',
      'Engaging intro, body, and outro',
      Icons.play_circle_outline,
      CreatiTheme.purple,
      'youtube_script',
    ),
    _ScriptTemplate(
      'Product Review',
      'Feature breakdown with CTA',
      Icons.shopping_bag_outlined,
      CreatiTheme.pink,
      'product_review',
    ),
    _ScriptTemplate(
      'Tutorial Script',
      'Step-by-step educational content',
      Icons.school_outlined,
      CreatiTheme.blue,
      'tutorial',
    ),
    _ScriptTemplate(
      'Storytelling',
      'Narrative arc with emotional hooks',
      Icons.auto_stories_outlined,
      CreatiTheme.orange,
      'storytelling',
    ),
    _ScriptTemplate(
      'Podcast Script',
      'Conversation flow with segments',
      Icons.podcasts_outlined,
      Colors.teal,
      'podcast',
    ),
    _ScriptTemplate(
      'Ad Copy',
      'Short, punchy promotional script',
      Icons.campaign_outlined,
      Colors.amber,
      'ad_copy',
    ),
  ];

  static const _recentScripts = [
    _ScriptHistoryItem(
      'Top 10 Gadgets Review',
      'Product Review',
      'Completed',
      'Casual',
    ),
    _ScriptHistoryItem(
      'How to Start a Podcast',
      'Tutorial',
      'Completed',
      'Professional',
    ),
    _ScriptHistoryItem(
      'Behind the Brand Story',
      'Storytelling',
      'Completed',
      'Inspiring',
    ),
    _ScriptHistoryItem('Summer Sale Promo', 'Ad Copy', 'Completed', 'Humorous'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: CreatiTheme.black,
              surfaceTintColor: Colors.transparent,
              title: Text('Script Writer', style: CreatiTheme.headingLarge()),
            ),
            const SliverToBoxAdapter(child: _PromptInput()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Templates', style: CreatiTheme.headingMedium()),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _TemplateCard(item: _templates[i]),
                  childCount: _templates.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: _ToneSelector()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Recent Scripts',
                  style: CreatiTheme.headingMedium(),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _HistoryCard(item: _recentScripts[i]),
                  childCount: _recentScripts.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
}

class _ScriptTemplate {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String id;
  const _ScriptTemplate(
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.id,
  );
}

class _ScriptHistoryItem {
  final String title;
  final String template;
  final String status;
  final String tone;
  const _ScriptHistoryItem(this.title, this.template, this.status, this.tone);
}

class _PromptInput extends StatelessWidget {
  const _PromptInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Describe your script',
              style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: CreatiTheme.darkSurface,
                borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
                border: Border.all(color: CreatiTheme.cardBorder.withAlpha(50)),
              ),
              child: const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      'e.g. A 3-minute YouTube video reviewing the latest smartphone...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 13),
                  isCollapsed: true,
                ),
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _snack(context, 'Generating script...'),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                  gradient: CreatiTheme.brandGradient,
                  boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
                ),
                child: Center(
                  child: Text(
                    'Generate Script',
                    style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600),
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

class _ToneSelector extends StatelessWidget {
  const _ToneSelector();

  static const _tones = [
    'Professional',
    'Casual',
    'Humorous',
    'Inspiring',
    'Dramatic',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Tone',
              style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tones.map((t) {
              final isFirst = t == _tones.first;
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: isFirst ? CreatiTheme.brandGradient : null,
                  color: isFirst ? null : CreatiTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                  border: isFirst
                      ? null
                      : Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
                ),
                child: Text(
                  t,
                  style: CreatiTheme.caption(
                    fontWeight: FontWeight.w500,
                    color: isFirst ? Colors.white : Colors.white.withAlpha(140),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final _ScriptTemplate item;
  const _TemplateCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.title} template selected')),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
          border: Border.all(color: item.color.withAlpha(50)),
          boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item.color.withAlpha(25),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusSm),
              ),
              child: Icon(item.icon, color: item.color, size: 20),
            ),
            const Spacer(),
            Text(
              item.title,
              style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              style: CreatiTheme.caption(color: Colors.white.withAlpha(80)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final _ScriptHistoryItem item;
  const _HistoryCard({required this.item});

  Color get _statusColor =>
      item.status == 'Completed' ? CreatiTheme.green : CreatiTheme.orange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CreatiTheme.surfaceDark,
          borderRadius: BorderRadius.circular(CreatiTheme.radiusMd),
          border: Border.all(color: CreatiTheme.cardBorder.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(10),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusSm),
              ),
              child: const Icon(
                Icons.article_outlined,
                color: Colors.white38,
                size: 18,
              ),
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
                  Row(
                    children: [
                      Text(
                        item.template,
                        style: CreatiTheme.caption(
                          color: Colors.white.withAlpha(60),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.tone,
                        style: CreatiTheme.caption(
                          color: CreatiTheme.purple.withAlpha(120),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _statusColor.withAlpha(20),
                borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
              ),
              child: Text(
                item.status,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: _statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
