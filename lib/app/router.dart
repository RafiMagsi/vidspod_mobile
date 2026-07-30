import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/app_scaffold.dart';
import 'package:vidspod_mobile/features/auth/application/auth_service.dart';
import 'package:vidspod_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:vidspod_mobile/features/billing/presentation/screens/plan_billing_screen.dart';
import 'package:vidspod_mobile/features/billing/presentation/screens/transaction_history_screen.dart';
import 'package:vidspod_mobile/features/brand_kits/presentation/screens/brand_kit_screen.dart';
import 'package:vidspod_mobile/features/business/presentation/screens/business_screen.dart';
import 'package:vidspod_mobile/features/business/presentation/screens/product_upload_screen.dart';
import 'package:vidspod_mobile/features/connections/presentation/screens/connected_accounts_screen.dart';
import 'package:vidspod_mobile/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:vidspod_mobile/features/generations/presentation/screens/generation_detail_screen.dart';
import 'package:vidspod_mobile/features/generations/presentation/screens/generation_list_screen.dart';
import 'package:vidspod_mobile/features/history/presentation/screens/history_screen.dart';
import 'package:vidspod_mobile/features/motions/presentation/screens/motion_detail_screen.dart';
import 'package:vidspod_mobile/features/motions/presentation/screens/motion_list_screen.dart';
import 'package:vidspod_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:vidspod_mobile/features/publishing/presentation/screens/publishing_screen.dart';
import 'package:vidspod_mobile/features/referrals/presentation/screens/refer_earn_screen.dart';
import 'package:vidspod_mobile/features/research/presentation/screens/research_detail_screen.dart';
import 'package:vidspod_mobile/features/research/presentation/screens/research_list_screen.dart';
import 'package:vidspod_mobile/features/settings/presentation/screens/settings_screen.dart';
import 'package:vidspod_mobile/features/shorts_studio/presentation/screens/get_started_screen.dart';
import 'package:vidspod_mobile/features/shorts_studio/presentation/screens/shorts_studio_screen.dart';
import 'package:vidspod_mobile/features/shorts_studio/presentation/screens/studio_generation_screen.dart';
import 'package:vidspod_mobile/features/shorts_studio/presentation/screens/upload_suggestions_screen.dart';
import 'package:vidspod_mobile/features/speak/presentation/screens/speak_screen.dart';
import 'package:vidspod_mobile/features/splash/splash_screen.dart';
import 'package:vidspod_mobile/features/tools/presentation/screens/image_studio_screen.dart';
import 'package:vidspod_mobile/features/tools/presentation/screens/script_writer_screen.dart';
import 'package:vidspod_mobile/features/tools/presentation/screens/tools_screen.dart';
import 'package:vidspod_mobile/features/tools/presentation/screens/voice_studio_screen.dart';
import 'package:vidspod_mobile/features/tools/presentation/screens/youtube_download_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

Page<void> _slideRight(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
                reverseCurve: Curves.easeInCubic,
              ),
            ),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      );
    },
  );
}

Page<void> _slideUp(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
                reverseCurve: Curves.easeInCubic,
              ),
            ),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      );
    },
  );
}

Page<void> _fadeIn(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = authState == AuthStatus.authenticated;
      final bool loggingIn = state.matchedLocation == '/login';
      final bool onSplash = state.matchedLocation == '/splash';

      if (onSplash) return null;

      if (!loggedIn) return '/login';

      if (loggingIn) return '/dashboard';

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _fadeIn(const SplashScreen(), state),
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _fadeIn(LoginScreen(), state),
      ),
      GoRoute(
        path: '/get-started',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, String?>?;
          return _slideUp(
            GetStartedScreen(
              motionId: extra?['motionId'],
              motionTitle: extra?['motionTitle'],
            ),
            state,
          );
        },
      ),
      GoRoute(
        path: '/upload-suggestions',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideUp(const UploadSuggestionsScreen(), state),
      ),
      GoRoute(
        path: '/product-upload',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideUp(const ProductUploadScreen(), state),
      ),
      GoRoute(
        path: '/motions/:public_guid',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideRight(
          MotionDetailScreen(publicGuid: state.pathParameters['public_guid']!),
          state,
        ),
      ),
      GoRoute(
        path: '/studio',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const ShortsStudioScreen(), state),
      ),
      GoRoute(
        path: '/studio/generation/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideRight(
          StudioGenerationScreen(id: state.pathParameters['id']!),
          state,
        ),
      ),
      GoRoute(
        path: '/image-studio',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const ImageStudioScreen(), state),
      ),
      GoRoute(
        path: '/voice-studio',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const VoiceStudioScreen(), state),
      ),
      GoRoute(
        path: '/script-writer',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const ScriptWriterScreen(), state),
      ),
      GoRoute(
        path: '/youtube-download',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const YouTubeDownloadScreen(), state),
      ),
      GoRoute(
        path: '/generations/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideRight(
          GenerationDetailScreen(id: state.pathParameters['id']!),
          state,
        ),
      ),
      GoRoute(
        path: '/research',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const ResearchListScreen(), state),
      ),
      GoRoute(
        path: '/research/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideRight(
          ResearchDetailScreen(id: state.pathParameters['id']!),
          state,
        ),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const SettingsScreen(), state),
      ),
      GoRoute(
        path: '/brand-kits',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const BrandKitScreen(), state),
      ),
      GoRoute(
        path: '/plan-billing',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const PlanBillingScreen(), state),
      ),
      GoRoute(
        path: '/transactions',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const TransactionHistoryScreen(), state),
      ),
      GoRoute(
        path: '/publishing',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const PublishingScreen(), state),
      ),
      GoRoute(
        path: '/connections',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const ConnectedAccountsScreen(), state),
      ),
      GoRoute(
        path: '/refer-earn',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _slideRight(const ReferEarnScreen(), state),
      ),
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: <GoRoute>[
          GoRoute(
            path: '/dashboard',
            pageBuilder: (context, state) =>
                _slideRight(const DashboardScreen(), state),
          ),
          GoRoute(
            path: '/business',
            pageBuilder: (context, state) =>
                _slideRight(const BusinessScreen(), state),
          ),
          GoRoute(
            path: '/speak',
            pageBuilder: (context, state) =>
                _slideRight(const SpeakScreen(), state),
          ),
          GoRoute(
            path: '/tools',
            pageBuilder: (context, state) =>
                _slideRight(const ToolsScreen(), state),
          ),
          GoRoute(
            path: '/history',
            pageBuilder: (context, state) =>
                _slideRight(const HistoryScreen(), state),
          ),
          GoRoute(
            path: '/motions',
            pageBuilder: (context, state) =>
                _slideRight(const MotionListScreen(), state),
          ),
          GoRoute(
            path: '/generations',
            pageBuilder: (context, state) =>
                _slideRight(const GenerationListScreen(), state),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                _slideRight(const ProfileScreen(), state),
          ),
        ],
      ),
    ],
  );
});
