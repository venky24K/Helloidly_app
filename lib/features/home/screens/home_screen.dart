import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../widgets/home_header.dart';
import '../widgets/tiffin_categories.dart';
import '../widgets/home_filters.dart';
import '../widgets/food_card.dart';
import '../widgets/floating_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isNavVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      final pixels = _scrollController.position.pixels;

      if (direction == ScrollDirection.reverse && pixels > 50) {
        if (_isNavVisible) {
          setState(() => _isNavVisible = false);
        }
      } else if (direction == ScrollDirection.forward || pixels <= 10) {
        if (!_isNavVisible) {
          setState(() => _isNavVisible = true);
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
    return AppScaffold(
      safeArea: false, // Allows header to go behind status bar
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const HomeHeader(),
                const SizedBox(height: 16),
                const TiffinCategories(),
                const SizedBox(height: 8),
                const HomeFilters(),
                const SizedBox(height: 8),
                const FoodCard(
                  title: 'Ghee Roast Idly (4 Pcs)',
                  description:
                      'Soft and fluffy idlies roasted in pure cow ghee, served with spicy red chutney and sambar.',
                  price: '₹120',
                  rating: '4.8',
                  imageUrl:
                      'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=800',
                  isFavorite: true,
                ),
                const FoodCard(
                  title: 'Butter Masala Dosa',
                  description:
                      'Crispy golden dosa filled with spiced potato masala and topped with fresh butter.',
                  price: '₹140',
                  rating: '4.9',
                  imageUrl:
                      'https://images.unsplash.com/photo-1630383249896-424e482df921?w=800',
                ),
                const FoodCard(
                  title: 'Medu Vada (2 Pcs)',
                  description:
                      'Crispy deep-fried lentil donuts served with coconut chutney and piping hot sambar.',
                  price: '₹90',
                  rating: '4.7',
                  imageUrl:
                      'https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=800',
                ),
                const SizedBox(height: 100), // Extra space for nav bar
              ],
            ),
          ),
          FloatingNavBar(isVisible: _isNavVisible),
        ],
      ),
    );
  }
}
