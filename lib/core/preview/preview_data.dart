import 'package:vidspod_mobile/core/models/credit_settlement.dart';
import 'package:vidspod_mobile/core/models/format_preset.dart';
import 'package:vidspod_mobile/core/models/project_list_item.dart';
import 'package:vidspod_mobile/core/models/short_run.dart';
import 'package:vidspod_mobile/features/billing/domain/account_credits.dart';
import 'package:vidspod_mobile/features/dashboard/domain/dashboard_summary.dart';
import 'package:vidspod_mobile/features/dashboard/domain/recent_generation.dart';
import 'package:vidspod_mobile/features/generations/domain/generation.dart';
import 'package:vidspod_mobile/features/motions/domain/motion.dart';
import 'package:vidspod_mobile/features/profile/domain/profile.dart';
import 'package:vidspod_mobile/features/research/domain/research_result.dart';
import 'package:vidspod_mobile/features/research/domain/research_run.dart';
import 'package:vidspod_mobile/features/settings/domain/settings.dart';
import 'package:vidspod_mobile/features/shorts_studio/domain/generate_hub.dart';

abstract final class PreviewData {
  static DashboardSummary get dashboardSummary =>
      const DashboardSummary(creditBalance: 1250, recentGenerationsCount: 12);

  static AccountCredits get accountCredits => const AccountCredits(
    balance: 1250,
    plan: 'pro',
    renewsAt: null,
    costs: {
      'script_generation': 10,
      'ai_image_generation': 5,
      'short_video_generation': 25,
    },
  );

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

  static List<ShortRun> get shortRuns => [
    _shortRun(
      'run-2001',
      status: 'generating',
      statusLabel: 'Generating',
      stageLabel: 'Rendering',
      stageMessage: 'Compositing your 9:16 clip…',
    ),
    _shortRun(
      'run-2002',
      status: 'completed',
      statusLabel: 'Completed',
      stageLabel: 'Done',
      stageMessage: 'Your short is ready to watch.',
    ),
    _shortRun(
      'run-2003',
      status: 'failed',
      statusLabel: 'Failed',
      stageLabel: 'Error',
      stageMessage: 'The generation could not be completed.',
      canRetry: true,
    ),
  ];

  static ShortRun shortRun(String id) => _shortRun(id);

  static List<ProjectListItem> get projects => [
    _project(
      'project-3001',
      'Cinematic City Reel',
      status: 'completed',
      creationMode: 'short-studio',
    ),
    _project(
      'project-3002',
      'Product Launch Teaser',
      status: 'in_progress',
      creationMode: 'ai-video-studio',
    ),
    _project(
      'project-3003',
      'Travel Vlog B-Roll',
      status: 'draft',
      creationMode: 'full-auto-studio',
    ),
  ];

  static ProjectListItem project(String id) =>
      _project(id, 'Project', status: 'completed');

  static List<FormatPreset> get formatPresets => [
    _formatPreset('cinematic-9x16', 'Cinematic Vertical'),
    _formatPreset('product-focus', 'Product Spotlight'),
    _formatPreset('dynamic-tiktok', 'Dynamic TikTok'),
  ];

  static GenerateHub get generateHub => const GenerateHub(
    flowMeta: {
      'title': 'Shorts Studio',
      'flow_category': 'short-studio',
      'locked_aspect_ratio': '9:16',
    },
    formatPresets: [
      FormatPreset(
        key: 'cinematic-9x16',
        publicId: 'cinematic-9x16',
        label: 'Cinematic Vertical',
        description: 'A cinematic look for vertical short-form video.',
        imageUrl: 'https://picsum.photos/seed/cinematic-9x16/400/600',
        previewVideoUrl: '',
        aspectRatio: '9:16',
        durationSeconds: 21,
        sceneCount: 3,
        batchSize: 1,
        categories: ['Short Studio'],
        cameraMovements: ['slow-pan'],
        generationMode: 'standard',
        prompt: '',
        genre: 'cinematic',
        speed: 'medium',
        shotsMode: 'single',
        modelKey: 'seedance-2-5',
        requiresReferenceImage: true,
        audioEnabled: true,
      ),
      FormatPreset(
        key: 'product-focus',
        publicId: 'product-focus',
        label: 'Product Spotlight',
        description: 'Product-focused 9:16 with a clean background.',
        imageUrl: 'https://picsum.photos/seed/product-focus/400/600',
        aspectRatio: '9:16',
        durationSeconds: 18,
        sceneCount: 2,
        batchSize: 1,
        categories: ['Short Studio'],
        cameraMovements: ['orbit'],
        generationMode: 'standard',
        prompt: '',
        genre: 'commercial',
        speed: 'medium',
        shotsMode: 'single',
        modelKey: 'seedance-2-5',
        requiresReferenceImage: true,
        audioEnabled: false,
        workflow: {
          'shots': [
            {'duration': 9, 'camera': 'orbit'},
            {'duration': 9, 'camera': 'push-in'},
          ],
        },
      ),
    ],
    stylePacks: [
      {'key': 'natural', 'label': 'Natural'},
      {'key': 'noir', 'label': 'Noir'},
    ],
    aiVideoProducts: [
      {'key': 'seedance-2-5', 'label': 'Seedance 2.5'},
    ],
    cameraMovements: ['static', 'slow-pan', 'orbit', 'push-in'],
    aspectRatios: ['9:16'],
    userElements: [],
    heroBackgroundVideo: 'https://picsum.photos/seed/studio-hero/800/1200',
    generationCost: 25,
  );

  static RecentGeneration _recentGeneration(String id, String status) =>
      RecentGeneration(
        id: id,
        thumbnailUrl: 'https://picsum.photos/seed/$id/400/240',
        status: status,
      );

  static ShortRun _shortRun(
    String id, {
    String status = 'completed',
    String statusLabel = 'Completed',
    String stageLabel = 'Done',
    String stageMessage = 'Your short is ready to watch.',
    bool canRetry = false,
  }) => ShortRun(
    id: id,
    status: status,
    statusLabel: statusLabel,
    stageKey: status,
    stageLabel: stageLabel,
    stageMessage: stageMessage,
    presetName: 'Cinematic Vertical',
    presetKey: 'cinematic-9x16',
    aspectRatio: '9:16',
    referenceImageUrl: 'https://picsum.photos/seed/$id/300/400',
    playbackUrl: 'https://picsum.photos/seed/$id-play/300/400',
    playbackReady: status == 'completed',
    canRetry: canRetry,
    canCancel: status == 'generating',
    canDeleteMedia: status == 'completed',
    outputWidth: 1080,
    outputHeight: 1920,
    durationSeconds: 21,
    creditSettlement: CreditSettlement(
      creditsCharged: 25,
      creditsRefunded: status == 'failed' ? 25 : 0,
      status: 'settled',
    ),
    refundStatus: status == 'failed' ? 'refunded' : 'none',
    createdAt: DateTime.now(),
  );

  static ProjectListItem _project(
    String id,
    String title, {
    String status = 'completed',
    String creationMode = 'short-studio',
  }) => ProjectListItem(
    id: id,
    title: title,
    status: status,
    creationMode: creationMode,
    aspectRatio: '9:16',
    targetDurationSeconds: 30,
    previewUrl: 'https://picsum.photos/seed/$id/300/400',
    finalUrl: status == 'completed'
        ? 'https://picsum.photos/seed/$id-final/300/400'
        : null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  static FormatPreset _formatPreset(String key, String label) => FormatPreset(
    key: key,
    publicId: key,
    label: label,
    description: 'A $label preset for vertical short-form video.',
    imageUrl: 'https://picsum.photos/seed/$key/400/600',
    aspectRatio: '9:16',
    durationSeconds: 21,
    sceneCount: 3,
    batchSize: 1,
    categories: const ['Short Studio'],
    cameraMovements: const ['slow-pan'],
    generationMode: 'standard',
    prompt: '',
    genre: 'cinematic',
    speed: 'medium',
    shotsMode: 'single',
    modelKey: 'seedance-2-5',
    requiresReferenceImage: true,
    audioEnabled: true,
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
