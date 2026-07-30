import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class ScriptWriterScreen extends StatelessWidget {
  const ScriptWriterScreen({super.key});

  static const _templates = [
    _ScriptTemplate('YouTube Script', 'Engaging intro, body, and outro', Icons.play_circle_outline, CreatiTheme.purple),
    _ScriptTemplate('Product Review', 'Feature breakdown with CTA', Icons.shopping_bag_outlined, CreatiTheme.pink),
    _ScriptTemplate('Tutorial Script', 'Step-by-step educational content', Icons.school_outlined, CreatiTheme.blue),
    _ScriptTemplate('Storytelling', 'Narrative arc with emotional hooks', Icons.auto_stories_outlined, CreatiTheme.orange),
    _ScriptTemplate('Podcast Script', 'Conversation flow with segments', Icons.podcasts_outlined, Colors.teal),
    _ScriptTemplate('Ad Copy', 'Short, punchy promotional script', Icons.campaign_outlined, Colors.amber),
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
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _ScriptTemplate {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _ScriptTemplate(this.title, this.subtitle, this.icon, this.color);
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Describe your script', style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w600)),
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
                hintText: 'e.g. A 3-minute YouTube video reviewing the latest smartphone...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white24, fontSize: 13),
                isCollapsed: true,
              ),
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CreatiTheme.radiusFull),
                gradient: CreatiTheme.brandGradient,
                boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
              ),
              child: Center(
                child: Text('Generate Script', style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ]),
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
      onTap: () {},
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
            Text(item.title, style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(item.subtitle, style: CreatiTheme.caption(color: Colors.white.withAlpha(80)), maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
