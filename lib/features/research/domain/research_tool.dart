import 'package:flutter/material.dart';

/// The eight research tools per docs/MOBILE_APP_GUIDE.md §5.9.
///
/// One nav section, eight tools, one backend today:
///  - GET `/content-research` (saved research, exports, recent searches)
///  - POST `/content-research/search` (run a research query)
///
/// Per-tool endpoints are 🔴 — these tools share the single search backend for
/// now. Web pages exist under `app/(app)/content-research/**`.
class ResearchTool {
  final String key;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const ResearchTool({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  static const List<ResearchTool> all = [
    ResearchTool(
      key: 'topic-explorer',
      title: 'Topic Explorer',
      subtitle: 'Discover content topics',
      icon: Icons.explore_outlined,
      color: Color(0xFF6D5DF6),
    ),
    ResearchTool(
      key: 'trend-tracker',
      title: 'Trend Tracker',
      subtitle: 'Monitor rising trends',
      icon: Icons.trending_up,
      color: Color(0xFFE06036),
    ),
    ResearchTool(
      key: 'audience-insights',
      title: 'Audience Insights',
      subtitle: 'Understand your viewers',
      icon: Icons.groups_outlined,
      color: Color(0xFF00B4DB),
    ),
    ResearchTool(
      key: 'competition-analysis',
      title: 'Competition Analysis',
      subtitle: 'Study competitor content',
      icon: Icons.bar_chart_outlined,
      color: Color(0xFFF857A6),
    ),
    ResearchTool(
      key: 'content-gap-finder',
      title: 'Content Gap Finder',
      subtitle: 'Find underserved niches',
      icon: Icons.space_dashboard_outlined,
      color: Color(0xFF34C759),
    ),
    ResearchTool(
      key: 'content-planner',
      title: 'Content Planner',
      subtitle: 'Plan your content calendar',
      icon: Icons.calendar_month_outlined,
      color: Color(0xFFFFB224),
    ),
    ResearchTool(
      key: 'platform-adaptation',
      title: 'Platform Adaptation',
      subtitle: 'Repurpose across platforms',
      icon: Icons.devices_outlined,
      color: Color(0xFF8E44AD),
    ),
    ResearchTool(
      key: 'reports-workspace',
      title: 'Reports Workspace',
      subtitle: 'Saved reports & exports',
      icon: Icons.folder_shared_outlined,
      color: Color(0xFF4A90E2),
    ),
  ];

  static ResearchTool byKey(String key) =>
      all.firstWhere((t) => t.key == key, orElse: () => all.first);
}
