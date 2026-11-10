import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_donuts/app/presentation/screens/placeholder_screen.dart';
import 'package:jd_donuts/core/motion/motion.dart';
import 'package:jd_donuts/core/navigation/app_shell.dart';

import 'route_names.dart';

import '../../features/auth/presentation/screens/auth_screens.dart';
import '../../features/auth/presentation/view_models/auth_view_model.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/product/presentation/screens/product_detail_screen.dart';
import '../../features/rewards/presentation/screens/rewards_screen.dart';
import '../../features/welcome/presentation/screens/welcome_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = ValueNotifier<int>(0);

  final router = GoRouter(
    initialLocation: RouteNames.onboarding,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final loggedIn = ref.read(authControllerProvider);
      final path = state.uri.path;

      const publicRoutes = {
        RouteNames.onboarding,
        RouteNames.phone,
        RouteNames.otp,
        RouteNames.name,
        RouteNames.birthDate,
      };

      final isPublic = publicRoutes.contains(path);

      if (!loggedIn) {
        if (isPublic) return null;

        return RouteNames.onboarding;
      }

      if (isPublic) {
        if (path == RouteNames.birthDate) {
          return RouteNames.welcome;
        }

        return RouteNames.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionDuration: AppMotion.normal,
          reverseTransitionDuration: AppMotion.normal,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppMotion.fadeSlide(
              animation: animation,
              child: child,
              begin: const Offset(0.12, 0),
            );
          },
        ),
      ),
      GoRoute(
        path: RouteNames.phone,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: PhoneScreen(
            isLogin: state.uri.queryParameters['mode'] == 'login',
          ),
          transitionDuration: AppMotion.normal,
          reverseTransitionDuration: AppMotion.normal,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppMotion.fadeSlide(
              animation: animation,
              child: child,
              begin: const Offset(0.12, 0),
            );
          },
        ),
      ),
      GoRoute(
        path: RouteNames.otp,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: OtpScreen(
            phone: state.uri.queryParameters['phone'] ?? '',
            isLogin: state.uri.queryParameters['mode'] == 'login',
          ),
          transitionDuration: AppMotion.normal,
          reverseTransitionDuration: AppMotion.normal,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppMotion.fadeSlide(
              animation: animation,
              child: child,
              begin: const Offset(0.12, 0),
            );
          },
        ),
      ),
      GoRoute(
        path: RouteNames.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NameScreen(),
          transitionDuration: AppMotion.normal,
          reverseTransitionDuration: AppMotion.normal,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppMotion.fadeSlide(
              animation: animation,
              child: child,
              begin: const Offset(0.12, 0),
            );
          },
        ),
      ),
      GoRoute(
        path: RouteNames.birthDate,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BirthDateScreen(),
          transitionDuration: AppMotion.normal,
          reverseTransitionDuration: AppMotion.normal,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppMotion.fadeSlide(
              animation: animation,
              child: child,
              begin: const Offset(0.12, 0),
            );
          },
        ),
      ),
      GoRoute(
        path: RouteNames.welcome,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const WelcomeScreen(),
          transitionDuration: AppMotion.normal,
          reverseTransitionDuration: AppMotion.normal,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppMotion.fadeSlide(
              animation: animation,
              child: child,
              begin: const Offset(0.12, 0),
            );
          },
        ),
      ),
      GoRoute(
        path: RouteNames.product,
        builder: (_, state) => ProductDetailScreen(
          productId: state.pathParameters['id']!,
        ),
      ),
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
            path: RouteNames.home,
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: RouteNames.rewards,
            builder: (_, __) => const RewardsScreen(),
          ),
          GoRoute(
            path: RouteNames.placeholder,
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
