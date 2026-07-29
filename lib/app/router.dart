import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/app_scaffold.dart';
import 'package:vidspod_mobile/core/widgets/coming_soon_screen.dart';
import 'package:vidspod_mobile/features/auth/application/auth_service.dart';
import 'package:vidspod_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:vidspod_mobile/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:vidspod_mobile/features/generations/presentation/screens/generation_detail_screen.dart';
import 'package:vidspod_mobile/features/generations/presentation/screens/generation_list_screen.dart';
import 'package:vidspod_mobile/features/motions/presentation/screens/motion_detail_screen.dart';
import 'package:vidspod_mobile/features/motions/presentation/screens/motion_list_screen.dart';
import 'package:vidspod_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:vidspod_mobile/features/research/presentation/screens/research_detail_screen.dart';
import 'package:vidspod_mobile/features/research/presentation/screens/research_list_screen.dart';
import 'package:vidspod_mobile/features/settings/presentation/screens/settings_screen.dart';
import 'package:vidspod_mobile/features/shorts_studio/presentation/screens/shorts_studio_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = authState == AuthStatus.authenticated;
      final bool loggingIn = state.matchedLocation == '/login';

      if (!loggedIn) {
        return '/login';
      }

      if (loggingIn) {
        return '/dashboard';
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: '/motions/:public_guid',
        builder: (BuildContext context, GoRouterState state) {
          return MotionDetailScreen(
            publicGuid: state.pathParameters['public_guid']!,
          );
        },
      ),
      GoRoute(
        path: '/studio',
        builder: (BuildContext context, GoRouterState state) {
          return const ShortsStudioScreen();
        },
      ),
      GoRoute(
        path: '/studio/generation/:id',
        builder: (BuildContext context, GoRouterState state) {
          return ComingSoonScreen(
              title: 'Studio Generation: ${state.pathParameters['id']}');
        },
      ),
      GoRoute(
        path: '/generations/:id',
        builder: (BuildContext context, GoRouterState state) {
          return GenerationDetailScreen(
            id: state.pathParameters['id']!,
          );
        },
      ),
      GoRoute(
        path: '/research',
        builder: (BuildContext context, GoRouterState state) {
          return const ResearchListScreen();
        },
      ),
      GoRoute(
        path: '/research/:id',
        builder: (BuildContext context, GoRouterState state) {
          return ResearchDetailScreen(
            id: state.pathParameters['id']!,
          );
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen();
        },
      ),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppScaffold(child: child);
        },
        routes: <GoRoute>[
          GoRoute(
            path: '/dashboard',
            builder: (BuildContext context, GoRouterState state) {
              return const DashboardScreen();
            },
          ),
          GoRoute(
            path: '/motions',
            builder: (BuildContext context, GoRouterState state) {
              return const MotionListScreen();
            },
          ),
          GoRoute(
            path: '/generations',
            builder: (BuildContext context, GoRouterState state) {
              return const GenerationListScreen();
            },
          ),
          GoRoute(
            path: '/profile',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            },
          ),
        ],
      ),
    ],
  );
});
