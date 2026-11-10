import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:jd_donuts/app/providers/app_providers.dart';
import 'package:jd_donuts/app/router/route_names.dart';
import 'package:jd_donuts/core/widgets/common_widgets.dart';
import 'package:jd_donuts/data/store/model/product_model.dart';
import 'package:jd_donuts/features/home/view_models/home_state.dart';
import 'package:jd_donuts/features/home/view_models/home_view_model.dart';
import 'package:jd_donuts/features/home/presentation/widgets/home_error_view.dart';
import 'package:jd_donuts/features/home/presentation/widgets/home_hero_section.dart';
import 'package:jd_donuts/features/home/presentation/widgets/home_loading_view.dart';
import 'package:jd_donuts/features/home/presentation/widgets/nearby_shop_section.dart';
import 'package:jd_donuts/features/home/presentation/widgets/product_section.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const _bannerInterval = Duration(seconds: 4);
  static const _bannerAnimationDuration = Duration(milliseconds: 550);

  final PageController _bannerController =
      PageController(viewportFraction: .84);

  Timer? _bannerTimer;
  int _bannerIndex = 0;

  @override
  void initState() {
    super.initState();

    _bannerTimer = Timer.periodic(
      _bannerInterval,
      (_) => _advanceBanner(),
    );
  }

  void _advanceBanner() {
    if (!mounted || !_bannerController.hasClients) return;

    final count =
        ref.read(homeViewModelProvider).valueOrNull?.banners.length ?? 0;

    if (count < 2) return;

    _bannerIndex = (_bannerIndex + 1) % count;

    _bannerController.animateToPage(
      _bannerIndex,
      duration: _bannerAnimationDuration,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  Future<void> _refresh() {
    return ref.read(homeViewModelProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(isOfflineProvider, (previous, next) {
      if (previous?.valueOrNull == true && next.valueOrNull == false) {
        _refresh();
      }
    });

    final homeAsync = ref.watch(homeViewModelProvider);
    final offlineAsync = ref.watch(isOfflineProvider);

    // AppShell owns Scaffold and bottom navigation.
    return SafeArea(
      child: homeAsync.when(
        loading: () => const HomeLoadingView(),
        error: (_, __) => HomeErrorView(
          onRetry: _refresh,
        ),
        data: (home) => _buildHomeContent(
          home,
          offline: offlineAsync.valueOrNull ?? false,
        ),
      ),
    );
  }

  Widget _buildHomeContent(
    HomeData home, {
    required bool offline,
  }) {
    final l10n = AppLocalizations.of(context);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: MotionEntrance(
              child: HomeHeroSection(
                member: home.member,
                banners: home.banners,
                controller: _bannerController,
                onBannerChanged: (index) {
                  _bannerIndex = index;
                },
                hasBannerError: !home.hasBanners,
                onRetry: _refresh,
              ),
            ),
          ),

          // Offline status.
          SliverToBoxAdapter(
            child: offline ? const OfflineBanner() : const SizedBox.shrink(),
          ),

          // Seasonal products.
          SliverToBoxAdapter(
            child: MotionEntrance(
              delay: const Duration(milliseconds: 100),
              child: ProductSection(
                title: l10n.seasonalSpecials,
                products: home.seasonalProducts,
                style: ProductSectionStyle.seasonal,
                hasError: !home.hasProducts,
                onRetry: _refresh,
                onProductTap: _openProduct,
              ),
            ),
          ),

          // Popular products.
          SliverToBoxAdapter(
            child: MotionEntrance(
              delay: const Duration(milliseconds: 180),
              child: ProductSection(
                title: l10n.popular,
                products: home.popularProducts,
                style: ProductSectionStyle.popular,
                hasError: !home.hasProducts,
                onRetry: _refresh,
                onProductTap: _openProduct,
              ),
            ),
          ),

          // Order again.
          SliverToBoxAdapter(
            child: MotionEntrance(
              delay: const Duration(milliseconds: 260),
              child: ProductSection(
                title: l10n.orderAgain,
                products: home.orderAgainProducts,
                style: ProductSectionStyle.orderAgain,
                hasError: !home.hasProducts || !home.hasOrderAgainProducts,
                onRetry: _refresh,
                onProductTap: _openProduct,
              ),
            ),
          ),

          // Nearby shops.
          SliverToBoxAdapter(
            child: MotionEntrance(
              delay: const Duration(milliseconds: 340),
              child: NearbyShopSection(
                shops: home.shops,
                hasError: !home.hasShops,
                onRetry: _refresh,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 28),
          ),
        ],
      ),
    );
  }

  void _openProduct(ProductModel product, String heroTag) {
    context.pushNamed(
      RouteNames.main.productDetail,
      pathParameters: {
        'id': product.id,
      },
      extra: heroTag,
    );
  }
}
