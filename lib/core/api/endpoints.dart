/// Central registry of every API path string, per docs/MOBILE_APP_GUIDE.md §6.
///
/// Keep all URL segments in this file. Paths are relative to
/// `{API_ORIGIN}/api/v1` (see `Config.apiUrl`).
///
/// Tag legend (from the guide):
///  - ✅ live in FastAPI today
///  - 🟡 works only in the legacy Laravel app (must be ported)
///  - 🔴 exists nowhere yet — new backend work
abstract final class Endpoints {
  // ── Auth (§4) ────────────────────────────────────────────────────────────────
  static const String login = '/auth/login'; // ✅
  static const String register = '/auth/register'; // ✅
  static const String mobileLogin = '/auth/mobile/login'; // 🔴
  static const String mobileRefresh = '/auth/mobile/refresh'; // 🔴
  static const String mobileLogout = '/auth/mobile/logout'; // 🔴
  static const String session = '/auth/session'; // ✅
  static const String passwordForgot = '/auth/password/forgot'; // ✅
  static const String passwordReset = '/auth/password/reset'; // ✅
  static const String emailVerification = '/auth/email/verification'; // ✅
  static const String emailVerify = '/auth/email/verify'; // ✅
  static const String profile = '/account/profile'; // ✅
  static const String meProfile = '/me/profile'; // ✅
  static const String meSettings = '/me/settings'; // ✅
  static const String changePassword = '/account/profile/change-password'; // ✅
  static const String changeEmail = '/account/profile/change-email'; // ✅

  // ── Devices / push (§9) ──────────────────────────────────────────────────────
  static const String registerDevice = '/devices/register'; // 🔴
  static const String device = '/devices/{token}'; // 🔴

  // ── Home / dashboard (§5.1) ─────────────────────────────────────────────────
  static const String dashboard = '/dashboard'; // ✅
  static const String dashboardRecent = '/dashboard/recent-generations'; // ✅
  static const String projectsOverview = '/projects/overview'; // ✅
  static const String settings = '/settings'; // ✅
  static const String settingsTheme = '/settings/theme'; // ✅
  static const String accountCredits = '/account/credits'; // 🔴

  // ── Shorts Studio (§5.2) ⭐ ──────────────────────────────────────────────────
  static const String generateHub = '/generate/hub'; // ✅
  static const String presetsGenerate = '/presets/generate'; // 🔴 (🟡 Laravel)
  static const String projects = '/projects'; // 🔴 (🟡 Laravel)
  static const String myShorts = '/my-shorts'; // ✅

  // ── My Shorts run monitoring (§5.3) ─────────────────────────────────────────
  static const String retryRun = '/my-shorts/{runId}/retry'; // ✅
  static const String cancelRun = '/my-shorts/{runId}/cancel'; // ✅
  static const String deleteRunMedia = '/my-shorts/{runId}/media'; // ✅
  static const String downloadRun = '/my-shorts/{runId}/download'; // 🟡

  // ── Generations ─────────────────────────────────────────────────────────────
  static const String generations = '/generations'; // ✅
  static const String generation = '/generations/{id}'; // ✅
  static const String _paramGenerationId = '{id}';
  static String generationWith(String id) =>
      generation.replaceAll(_paramGenerationId, id);

  // ── Image Generator (§5.4) ──────────────────────────────────────────────────
  static const String imageGenerator = '/tools/image-generator'; // 🔴
  static const String imageGeneratorStatus =
      '/tools/image-generator/{id}/status'; // 🔴
  static const String imageGeneratorMediaAssets =
      '/tools/image-generator/{id}/media-assets'; // 🔴

  // ── Video studios (§5.5) ────────────────────────────────────────────────────
  static const String project = '/projects/{id}'; // ✅
  static const String projectRuns =
      '/projects/{id}/generation-runs/{runId}/{action}'; // 🔴 (🟡 Laravel)

  // ── Projects (§5.6) ─────────────────────────────────────────────────────────
  static const String deleteProject = '/projects/{id}'; // 🔴

  // ── Script Writer (§5.7) ────────────────────────────────────────────────────
  static const String generateScript = '/generate/script'; // 🟡 placeholder
  static const String generateNarration = '/generate/narration'; // 🟡
  static const String scriptWriterHistory = '/script-writer/history'; // 🔴

  // ── Voice Studio (§5.8) ─────────────────────────────────────────────────────
  static const String voices = '/voices'; // ✅
  static const String voiceSettings = '/voices/settings'; // ✅
  static const String voiceClones = '/voices/clones'; // 🔴
  static const String voicePreview = '/voices/preview'; // 🔴

  // ── Research (§5.9) ─────────────────────────────────────────────────────────
  static const String contentResearch = '/content-research'; // ✅
  static const String contentResearchSearch = '/content-research/search'; // ✅
  static const String _paramResearchId = '{researchId}';
  static const String contentResearchItem =
      '/content-research/{researchId}'; // ✅
  static const String contentResearchResults =
      '/content-research/{researchId}/results'; // ✅

  static String contentResearchWith(String id) =>
      contentResearchItem.replaceAll(_paramResearchId, id);

  static String contentResearchResultsWith(String id) =>
      contentResearchResults.replaceAll(_paramResearchId, id);

  // ── YouTube tools (§5.10) ───────────────────────────────────────────────────
  static const String youtubeDownloaderInfo =
      '/tools/youtube/downloader/info'; // 🔴 (🟡)
  static const String youtubeDownloaderDownload =
      '/tools/youtube/downloader/download'; // 🔴 (🟡)
  static const String youtubeDownloaderStatus =
      '/tools/youtube/downloader/{id}/status'; // 🔴 (🟡)
  static const String youtubeDownloaderFile =
      '/tools/youtube/downloader/{id}/file'; // 🔴 (🟡)
  static const String youtubeNicheFinderSearch =
      '/tools/youtube/niche-finder/search'; // 🔴 (🟡)
  static const String youtubeNicheFinderFavorite =
      '/tools/youtube/niche-finder/favorite'; // 🔴 (🟡)

  // ── Publishing (§5.11) ──────────────────────────────────────────────────────
  static const String publishing = '/publishing'; // ✅
  static const String publishingSchedule = '/publishing/schedule'; // 🔴
  static const String publishingAction = '/publishing/{id}/{action}'; // 🔴

  // ── Motions catalog (§5.12) ─────────────────────────────────────────────────
  static const String motions = '/motions'; // ✅
  static const String motion = '/motions/{publicId}'; // ✅

  // ── Billing & credits (§5.13 / §10) ────────────────────────────────────────
  static const String accountBilling = '/account/billing'; // 🔴
  static const String verifyReceipt = '/billing/mobile/verify-receipt'; // 🔴

  static const String _paramToken = '{token}';
  static const String _paramRunId = '{runId}';
  static const String _paramId = '{id}';
  static const String _paramAction = '{action}';
  static const String _paramPublicId = '{publicId}';

  static String deviceWithToken(String token) =>
      device.replaceAll(_paramToken, token);

  static String myShortRunWith(String runId) => '$myShorts/$runId';

  static String retryRunWith(String runId) =>
      retryRun.replaceAll(_paramRunId, runId);

  static String cancelRunWith(String runId) =>
      cancelRun.replaceAll(_paramRunId, runId);

  static String deleteRunMediaWith(String runId) =>
      deleteRunMedia.replaceAll(_paramRunId, runId);

  static String downloadRunWith(String runId) =>
      downloadRun.replaceAll(_paramRunId, runId);

  static String imageGeneratorStatusWith(String id) =>
      imageGeneratorStatus.replaceAll(_paramId, id);

  static String imageGeneratorMediaAssetsWith(String id) =>
      imageGeneratorMediaAssets.replaceAll(_paramId, id);

  static String projectWith(String id) => project.replaceAll(_paramId, id);

  static String projectRunActionWith(String id, String runId, String action) =>
      projectRuns
          .replaceAll(_paramId, id)
          .replaceAll(_paramRunId, runId)
          .replaceAll(_paramAction, action);

  static String deleteProjectWith(String id) =>
      deleteProject.replaceAll(_paramId, id);

  static String youtubeDownloaderStatusWith(String id) =>
      youtubeDownloaderStatus.replaceAll(_paramId, id);

  static String youtubeDownloaderFileWith(String id) =>
      youtubeDownloaderFile.replaceAll(_paramId, id);

  static String publishingActionWith(String id, String action) =>
      publishingAction
          .replaceAll(_paramId, id)
          .replaceAll(_paramAction, action);

  static String motionWith(String publicId) =>
      motion.replaceAll(_paramPublicId, publicId);
}
