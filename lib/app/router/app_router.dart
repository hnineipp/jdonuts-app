import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_donuts/app/presentation/screens/placeholder_screen.dart';
import 'package:jd_donuts/core/motion/motion.dart';
import 'package:jd_donuts/core/navigation/app_shell.dart';

import 'route_names.dart';

import '../../features/auth/presentation/screens/auth_screens.dart';
import '../../features/auth/view_models/auth_view_model.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/product/presentation/screens/product_detail_screen.dart';
import '../../features/rewards/presentation/screens/rewards_screen.dart';
import '../../features/welcome/presentation/screens/welcome_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = ValueNotifier<int>(0);

  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final loggedIn = ref.read(authControllerProvider);
      final path = state.uri.path;

      const publicRoutes = {
        '/',
        '/phone',
        '/otp',
        '/name',
        '/dob',
      };

      final isPublic = publicRoutes.contains(path);

      if (!loggedIn) {
        if (isPublic) return null;
        return '/';
      }

      if (isPublic) {
        if (path == '/dob') return '/welcome';
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        name: RouteNames.main.onboarding,
        path: '/',
        pageBuilder: (context, state) => _buildPage(
          state,
          const OnboardingScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.main.phone,
        path: '/phone',
        pageBuilder: (context, state) => _buildPage(
          state,
          PhoneScreen(
            isLogin: state.uri.queryParameters['mode'] == 'login',
          ),
        ),
      ),
      GoRoute(
        name: RouteNames.main.otp,
        path: '/otp',
        pageBuilder: (context, state) => _buildPage(
          state,
          OtpScreen(
            phone: state.uri.queryParameters['phone'] ?? '',
            isLogin: state.uri.queryParameters['mode'] == 'login',
          ),
        ),
      ),
      GoRoute(
        name: RouteNames.main.name,
        path: '/name',
        pageBuilder: (context, state) => _buildPage(
          state,
          const NameScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.main.birthDate,
        path: '/dob',
        pageBuilder: (context, state) => _buildPage(
          state,
          const BirthDateScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.main.welcome,
        path: '/welcome',
        pageBuilder: (context, state) => _buildPage(
          state,
          const WelcomeScreen(),
        ),
      ),

      GoRoute(
        name: RouteNames.main.productDetail,
        path: '/product/:id',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;

          return ProductDetailScreen(
            productId: productId,
            heroTag: state.extra as String? ?? 'home-seasonal-$productId',
          );
        },
      ),

      // Main shell
      ShellRoute(
        builder: (context, state, child) {
          final location = state.matchedLocation;

          final currentIndex = location.startsWith('/rewards')
              ? 1
              : location.startsWith('/account')
                  ? 2
                  : location.startsWith('/wallet')
                      ? 3
                      : location.startsWith('/settings')
                          ? 4
                          : 0;

          return AppShell(
            currentIndex: currentIndex,
            child: child,
          );
        },
        routes: [
          GoRoute(
            name: RouteNames.main.home,
            path: '/home',
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            name: RouteNames.main.rewards,
            path: '/rewards',
            builder: (_, __) => const RewardsScreen(),
          ),
          GoRoute(
            name: RouteNames.main.placeholder,
            path: '/placeholder/:name',
            builder: (_, state) => PlaceholderScreen(
              title: state.pathParameters['name'] ?? 'More',
            ),
          ),
        ],
      ),
    ],
  );

  ref.listen<bool>(
    authControllerProvider,
    (_, __) => refreshListenable.value++,
  );

  ref.onDispose(() {
    router.dispose();
    refreshListenable.dispose();
  });

  return router;
});

CustomTransitionPage<void> _buildPage(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: AppMotion.normal,
    reverseTransitionDuration: AppMotion.normal,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return AppMotion.fadeSlide(
        animation: animation,
        child: child,
        begin: const Offset(0.12, 0),
      );
    },
  );
}
