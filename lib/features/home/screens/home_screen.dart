import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../widgets/home_header.dart';
import '../widgets/tiffin_categories.dart';
import '../widgets/home_filters.dart';
import '../widgets/food_card.dart';
import '../widgets/floating_nav_bar.dart';
import '../providers/home_providers.dart';
import '../../order/providers/order_providers.dart';
import '../widgets/active_order_card.dart';

import '../widgets/cart_view.dart';
import '../widgets/orders_view.dart';
import '../widgets/proceed_to_cart_bar.dart';
import '../../profile/widgets/profile_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      final pixels = _scrollController.position.pixels;
      final isNavVisible = ref.read(navBarVisibilityProvider);

      if (direction == ScrollDirection.reverse && pixels > 50) {
        if (isNavVisible) {
          ref.read(navBarVisibilityProvider.notifier).state = false;
        }
      } else if (direction == ScrollDirection.forward || pixels <= 10) {
        if (!isNavVisible) {
          ref.read(navBarVisibilityProvider.notifier).state = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodItems = ref.watch(foodItemsProvider);
    final isNavVisible = ref.watch(navBarVisibilityProvider);
    final currentIndex = ref.watch(navigationIndexProvider);
    final cartCount = ref.watch(cartCountProvider);

    // Logic to decide which bottom bar to show
    final showProceedBar = cartCount > 0 && currentIndex != 3;

    return AppScaffold(
      safeArea: false,
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: [
              // Home Tab
          RefreshIndicator(
            onRefresh: () async {
              return ref.refresh(foodItemsProvider.future);
            },
            color: const Color(0xFFFF4912),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 16),
                  sliver: SliverToBoxAdapter(
                    child: TiffinCategories(),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 8),
                  sliver: SliverToBoxAdapter(
                    child: HomeFilters(),
                  ),
                ),
                foodItems.when(
                  data: (items) => SliverPadding(
                    padding: const EdgeInsets.only(top: 8, bottom: 140),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return FoodCard(item: items[index]);
                        },
                        childCount: items.length,
                      ),
                    ),
                  ),
                  loading: () => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, stack) => SliverToBoxAdapter(
                    child: Center(child: Text('Error: $err')),
                  ),
                ),
              ],
            ),
          ),
              // Search Tab (Placeholder)
              const Center(child: Text('Search Content')),
              // Orders Tab
              const OrdersView(),
              // Cart Tab
              const CartView(),
              // Profile Tab
              const ProfileView(),
            ],
          ),
          if (ref.watch(activeOrdersProvider).isNotEmpty && currentIndex == 0)
            ActiveOrderCard(order: ref.watch(activeOrdersProvider).first)
          else if (showProceedBar && currentIndex != 4)
            const ProceedToCartBar()
          else
            FloatingNavBar(isVisible: isNavVisible),
        ],
      ),
    );
  }
}
