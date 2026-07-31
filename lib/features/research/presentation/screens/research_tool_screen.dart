import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/widgets/async_state_view.dart';
import 'package:vidspod_mobile/core/widgets/gradient_button.dart';
import 'package:vidspod_mobile/features/research/data/research_cache.dart';
import 'package:vidspod_mobile/features/research/domain/research_result.dart';
import 'package:vidspod_mobile/features/research/domain/research_tool.dart';
import 'package:vidspod_mobile/features/research/research_providers.dart';

/// A single research tool per §5.9: search-input → result cards →
/// save/export → "turn into a script/video" handoff.
class ResearchToolScreen extends ConsumerStatefulWidget {
  final String toolKey;
  const ResearchToolScreen({super.key, required this.toolKey});

  @override
  ConsumerState<ResearchToolScreen> createState() => _ResearchToolScreenState();
}

class _ResearchToolScreenState extends ConsumerState<ResearchToolScreen> {
  final _queryController = TextEditingController();
  bool _hasSearched = false;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _runSearch() {
    final query = _queryController.text.trim();
    if (query.isEmpty) {
      _snack('Enter a research question first');
      return;
    }
    setState(() => _hasSearched = true);
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final tool = ResearchTool.byKey(widget.toolKey);
    final search = _hasSearched
        ? ref.watch(
            researchSearchProvider((
              query: _queryController.text.trim(),
              toolKey: widget.toolKey,
            )),
          )
        : null;

    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(
        backgroundColor: VrTheme.black,
        title: Text(tool.title, style: VrTheme.headingLarge()),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _queryController,
            style: const TextStyle(color: Colors.white),
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _runSearch(),
            decoration: InputDecoration(
              hintText: 'Ask ${tool.title.toLowerCase()}…',
              hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
              filled: true,
              fillColor: VrTheme.darkSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.white.withAlpha(80)),
            ),
          ),
          const SizedBox(height: 12),
          GradientButton(
            text: 'Run Research',
            onPressed: _runSearch,
            icon: Icons.science_outlined,
          ),
          const SizedBox(height: 20),
          if (search != null)
            search.when(
              data: (run) => _ResultsView(
                runId: run.id,
                toolKey: widget.toolKey,
                query: _queryController.text.trim(),
              ),
              loading: () =>
                  const AsyncStateView(loading: true, emptyMessage: ''),
              error: (error, _) => AsyncStateView(
                loading: false,
                errorMessage: '$error',
                emptyMessage: '',
              ),
            )
          else
            const AsyncStateView(
              loading: false,
              emptyMessage: 'Results will appear here',
              emptyIcon: Icons.auto_awesome_outlined,
            ),
        ],
      ),
    );
  }
}

class _ResultsView extends ConsumerStatefulWidget {
  final String runId;
  final String toolKey;
  final String query;
  const _ResultsView({
    required this.runId,
    required this.toolKey,
    required this.query,
  });

  @override
  ConsumerState<_ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends ConsumerState<_ResultsView> {
  List<ResearchResult>? _cached;

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(researchRunResultsProvider(widget.runId));
    return results.when(
      data: (items) {
        _persist(items);
        final shown = items.isEmpty ? (_cached ?? items) : items;
        return _ResultsColumn(
          runId: widget.runId,
          results: shown,
          fromCache: items.isEmpty && (_cached?.isNotEmpty ?? false),
        );
      },
      loading: () => (_cached != null && _cached!.isNotEmpty)
          ? _ResultsColumn(
              runId: widget.runId,
              results: _cached!,
              fromCache: true,
            )
          : const AsyncStateView(loading: true, emptyMessage: ''),
      error: (error, _) => _cached != null && _cached!.isNotEmpty
          ? _ResultsColumn(
              runId: widget.runId,
              results: _cached!,
              fromCache: true,
            )
          : AsyncStateView(
              loading: false,
              errorMessage: '$error',
              emptyMessage: '',
            ),
    );
  }

  void _persist(List<ResearchResult> items) {
    if (items.isEmpty || _cached != null) return;
    _cached = items;
    final cache = ref.read(researchCacheProvider);
    cache.whenData(
      (c) => c.put(widget.toolKey, widget.query, [
        for (final r in items) r.toJson(),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCached();
  }

  Future<void> _loadCached() async {
    final cache = await ref.read(researchCacheProvider.future);
    final cached = cache.get(widget.toolKey, widget.query);
    if (!mounted || cached == null) return;
    setState(() {
      _cached = [for (final e in cached) ResearchResult.fromJson(e)];
    });
  }
}

class _ResultsColumn extends StatelessWidget {
  final String runId;
  final List<ResearchResult> results;
  final bool fromCache;
  const _ResultsColumn({
    required this.runId,
    required this.results,
    required this.fromCache,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fromCache)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.offline_pin_outlined,
                  size: 14,
                  color: Colors.white.withAlpha(80),
                ),
                const SizedBox(width: 6),
                Text(
                  'Showing cached results',
                  style: VrTheme.bodySmall(color: Colors.white.withAlpha(80)),
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Results',
                style: VrTheme.headingMedium(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () => context.push('/research/$runId'),
              child: Text(
                'Open saved run',
                style: VrTheme.bodySmall(
                  color: VrTheme.purple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (results.isEmpty)
          const AsyncStateView(loading: false, emptyMessage: 'No results yet')
        else
          Column(
            children: [
              for (final result in results)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: VrTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                    border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
                  ),
                  child: Text(result.content, style: VrTheme.bodySmall()),
                ),
            ],
          ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _HandoffChip(
                icon: Icons.share_outlined,
                label: 'Save / Export',
                color: VrTheme.blue,
                onTap: () => _snack(context, 'Saved'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _HandoffChip(
                icon: Icons.article_outlined,
                label: 'Turn into script',
                color: VrTheme.purple,
                onTap: () => context.push('/script-writer'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class _HandoffChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _HandoffChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(VrTheme.radiusMd),
          border: Border.all(color: color.withAlpha(80)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
