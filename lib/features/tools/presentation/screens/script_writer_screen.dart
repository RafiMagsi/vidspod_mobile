import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/features/billing/credit_gate.dart';
import 'package:vidspod_mobile/features/tools/tools_providers.dart';

class ScriptWriterScreen extends ConsumerStatefulWidget {
  const ScriptWriterScreen({super.key});

  @override
  ConsumerState<ScriptWriterScreen> createState() => _ScriptWriterScreenState();
}

class _ScriptWriterScreenState extends ConsumerState<ScriptWriterScreen> {
  final _promptController = TextEditingController();
  String _template = 'youtube_script';
  String _tone = 'Professional';
  String? _script;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) {
      _snack(context, 'Describe your script first');
      return;
    }
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Generating script...'),
        duration: const Duration(milliseconds: 600),
      ),
    );
    try {
      final script = Config.previewMode
          ? PreviewScript.sample(prompt)
          : await ref
                .read(scriptWriterRepositoryProvider)
                .generateScript(
                  prompt: prompt,
                  template: _template,
                  tone: _tone.toLowerCase(),
                );
      if (!mounted) return;
      setState(() => _script = script);
    } catch (e) {
      if (!mounted) return;
      if (!CreditGate.onApiError(context, e)) {
        _snack(context, 'Generation failed: $e');
      }
    }
  }

  static const _templates = [
    _ScriptTemplate(
      'YouTube Script',
      'Engaging intro, body, and outro',
      Icons.play_circle_outline,
      VrTheme.purple,
      'youtube_script',
    ),
    _ScriptTemplate(
      'Product Review',
      'Feature breakdown with CTA',
      Icons.shopping_bag_outlined,
      VrTheme.pink,
      'product_review',
    ),
    _ScriptTemplate(
      'Tutorial Script',
      'Step-by-step educational content',
      Icons.school_outlined,
      VrTheme.blue,
      'tutorial',
    ),
    _ScriptTemplate(
      'Storytelling',
      'Narrative arc with emotional hooks',
      Icons.auto_stories_outlined,
      VrTheme.orange,
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
      backgroundColor: VrTheme.black,
      body: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: VrTheme.black,
              surfaceTintColor: Colors.transparent,
              title: Text('Script Writer', style: VrTheme.headingLarge()),
            ),
            SliverToBoxAdapter(
              child: _PromptInput(
                controller: _promptController,
                onGenerate: _generate,
              ),
            ),
            if (_script != null)
              SliverToBoxAdapter(
                child: _ScriptResult(
                  script: _script!,
                  onEdit: () => _snack(context, 'Script saved'),
                  onSendToVideo: () => context.push('/get-started'),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Templates', style: VrTheme.headingMedium()),
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
                  (_, i) => _TemplateCard(
                    item: _templates[i],
                    selected: _template == _templates[i].id,
                    onTap: () => setState(() => _template = _templates[i].id),
                  ),
                  childCount: _templates.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _ToneSelector(
                selected: _tone,
                onChanged: (t) => setState(() => _tone = t),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Recent Scripts', style: VrTheme.headingMedium()),
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
  final TextEditingController controller;
  final VoidCallback onGenerate;
  const _PromptInput({required this.controller, required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
          boxShadow: VrTheme.cardShadow(VrTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Describe your script',
              style: VrTheme.bodyMedium(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: VrTheme.darkSurface,
                borderRadius: BorderRadius.circular(VrTheme.radiusMd),
                border: Border.all(color: VrTheme.cardBorder.withAlpha(50)),
              ),
              child: TextField(
                controller: controller,
                maxLines: 4,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: const InputDecoration(
                  hintText:
                      'e.g. A 3-minute YouTube video reviewing the latest smartphone...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 13),
                  isCollapsed: true,
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onGenerate,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                  gradient: VrTheme.brandGradient,
                  boxShadow: VrTheme.buttonShadow(VrTheme.purple),
                ),
                child: Center(
                  child: Text(
                    'Generate Script',
                    style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
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

class _ScriptResult extends StatelessWidget {
  final String script;
  final VoidCallback onEdit;
  final VoidCallback onSendToVideo;
  const _ScriptResult({
    required this.script,
    required this.onEdit,
    required this.onSendToVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.purple.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your script', style: VrTheme.headingMedium()),
            const SizedBox(height: 10),
            Text(script, style: VrTheme.bodySmall()),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onEdit,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(10),
                        borderRadius: BorderRadius.circular(VrTheme.radiusMd),
                        border: Border.all(
                          color: VrTheme.cardBorder.withAlpha(80),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: onSendToVideo,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: VrTheme.brandGradient,
                        borderRadius: BorderRadius.circular(VrTheme.radiusMd),
                      ),
                      child: Text(
                        'Send to video',
                        style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
                      ),
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

/// Canned preview output so the screen works offline (§5.7 backend is a 🟡
/// placeholder until the real LLM call ships).
class PreviewScript {
  static String sample(String prompt) {
    return 'Hook: You are going to want to hear this.\n\n'
        'Intro: ${prompt.trim()}\n\n'
        'Body: Walk through the three key points, keeping each one to about '
        '45 seconds with a visual on screen.\n\n'
        'Outro: Recap the main takeaway and end with a clear call to action — '
        'like, subscribe, and tell us what to cover next.';
  }
}

class _ToneSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  const _ToneSelector({required this.selected, required this.onChanged});

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
              style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tones.map((t) {
              final isSelected = t == selected;
              return GestureDetector(
                onTap: () => onChanged(t),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected ? VrTheme.brandGradient : null,
                    color: isSelected ? null : VrTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(VrTheme.radiusFull),
                    border: isSelected
                        ? null
                        : Border.all(color: VrTheme.cardBorder.withAlpha(60)),
                  ),
                  child: Text(
                    t,
                    style: VrTheme.caption(
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withAlpha(140),
                    ),
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
  final bool selected;
  final VoidCallback onTap;
  const _TemplateCard({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(
            color: selected ? item.color : item.color.withAlpha(50),
            width: selected ? 1.5 : 1,
          ),
          boxShadow: VrTheme.cardShadow(VrTheme.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected ? item.color : item.color.withAlpha(25),
                borderRadius: BorderRadius.circular(VrTheme.radiusSm),
              ),
              child: Icon(
                item.icon,
                color: selected ? Colors.white : item.color,
                size: 20,
              ),
            ),
            const Spacer(),
            Text(
              item.title,
              style: VrTheme.bodySmall(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              style: VrTheme.caption(color: Colors.white.withAlpha(80)),
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
      item.status == 'Completed' ? VrTheme.green : VrTheme.orange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: VrTheme.surfaceDark,
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(10),
                borderRadius: BorderRadius.circular(VrTheme.radiusSm),
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
                    style: VrTheme.bodySmall(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        item.template,
                        style: VrTheme.caption(
                          color: Colors.white.withAlpha(60),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.tone,
                        style: VrTheme.caption(
                          color: VrTheme.purple.withAlpha(120),
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
                borderRadius: BorderRadius.circular(VrTheme.radiusFull),
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
