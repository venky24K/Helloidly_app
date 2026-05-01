import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_providers.dart';

class FloatingNavBar extends ConsumerWidget {
  final bool isVisible;

  const FloatingNavBar({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    final cartCount = ref.watch(cartCountProvider);

    return AnimatedSlide(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
      offset: isVisible ? Offset.zero : const Offset(0, 2),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItem(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      isActive: currentIndex == 0,
                      onTap: () => ref.read(navigationIndexProvider.notifier).state = 0,
                    ),
                    _NavItem(
                      icon: Icons.search_rounded,
                      label: 'Search',
                      isActive: currentIndex == 1,
                      onTap: () => ref.read(navigationIndexProvider.notifier).state = 1,
                    ),
                    _NavItem(
                      icon: Icons.receipt_long_rounded,
                      label: 'Orders',
                      isActive: currentIndex == 2,
                      onTap: () => ref.read(navigationIndexProvider.notifier).state = 2,
                    ),
                    Stack(
                      children: [
                        _NavItem(
                          icon: Icons.shopping_cart_rounded,
                          label: 'Cart',
                          isActive: currentIndex == 3,
                          onTap: () => ref.read(navigationIndexProvider.notifier).state = 3,
                        ),
                        if (cartCount > 0)
                          Positioned(
                            right: 0,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF4912),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '$cartCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFFFF4912) : Colors.grey[400];
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Icon(icon, color: color, size: 24),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isActive ? 4 : 0,
            width: isActive ? 4 : 0,
            margin: EdgeInsets.only(top: isActive ? 4 : 0),
            decoration: const BoxDecoration(
              color: Color(0xFFFF4912),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
