import 'package:vidspod_mobile/features/dashboard/domain/dashboard_summary.dart';
import 'package:vidspod_mobile/features/dashboard/domain/recent_generation.dart';
import 'package:vidspod_mobile/features/generations/domain/generation.dart';
import 'package:vidspod_mobile/features/motions/domain/motion.dart';
import 'package:vidspod_mobile/features/profile/domain/profile.dart';
import 'package:vidspod_mobile/features/research/domain/research_result.dart';
import 'package:vidspod_mobile/features/research/domain/research_run.dart';
import 'package:vidspod_mobile/features/settings/domain/settings.dart';

abstract final class PreviewData {
  static DashboardSummary get dashboardSummary =>
      const DashboardSummary(creditBalance: 1250, recentGenerationsCount: 12);

  static List<RecentGeneration> get recentGenerations => [
    _recentGeneration('gen-1001', 'Completed'),
    _recentGeneration('gen-1002', 'Processing'),
    _recentGeneration('gen-1003', 'Completed'),
  ];

  static List<Motion> get motions => [
    _motion('motion-cinematic'),
    _motion('motion-product'),
    _motion('motion-fashion'),
  ];

  static Motion motion(String publicGuid) => _motion(publicGuid);

  static List<Generation> get generations => [
    generation('gen-1001'),
    generation('gen-1002', status: 'Processing'),
    generation('gen-1003'),
  ];

  static Generation generation(String id, {String status = 'Completed'}) =>
      Generation(
        id: id,
        status: status,
        reservedCredits: 25,
        workflowType: 'Image to Video',
        progress: {'percent': status == 'Completed' ? 100 : 62},
      );

  static List<ResearchRun> get researchRuns => [researchRun('research-1')];

  static ResearchRun researchRun(String id) => const ResearchRun(
    id: 'research-1',
    topic: 'Short-form video trends in 2026',
    status: 'Completed',
    progress: {'percent': 100},
  );

  static List<ResearchResult> researchResults(String id) => const [
    ResearchResult(
      id: 'result-1',
      content:
          'Short-form videos perform best when the first three seconds establish a clear visual hook.',
    ),
    ResearchResult(
      id: 'result-2',
      content:
          'Vertical 9:16 compositions and captions improve mobile-first viewing completion.',
    ),
  ];

  static Profile get profile => const Profile(
    email: 'preview@vidspod.com',
    displayName: 'Preview Creator',
  );

  static AppSettings get settings => const AppSettings(
    autoplay: true,
    useMobileData: false,
    theme: 'system',
    language: 'en',
  );

  static RecentGeneration _recentGeneration(String id, String status) =>
      RecentGeneration(
        id: id,
        thumbnailUrl: 'https://picsum.photos/seed/$id/400/240',
        status: status,
      );

  static Motion _motion(String id) => Motion(
    publicGuid: id,
    title: id.replaceAll('-', ' ').toUpperCase(),
    description: 'A production-ready motion preset for your next social video.',
    thumbnailUrl: 'https://picsum.photos/seed/$id/600/360',
    previewVideoUrl: '',
    referenceType: 'image',
    creditPrice: 25,
    supportedAspectRatios: const ['9:16', '1:1', '16:9'],
    isAvailable: true,
  );
}
