import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/widgets/coming_soon_screen.dart';
import 'package:vidspod_mobile/features/auth/application/auth_service.dart';
import 'package:vidspod_mobile/features/auth/presentation/screens/login_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
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
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const ComingSoonScreen(title: 'Home');
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),
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
        path: '/generations',
        builder: (BuildContext context, GoRouterState state) {
          return const GenerationListScreen();
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
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileScreen();
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen();
        },
      ),
    ],
  );
});
