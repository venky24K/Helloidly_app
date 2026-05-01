import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/food_item.dart';
import '../../../models/cart_item.dart';

// Provider for the selected navigation index
final navigationIndexProvider = StateProvider<int>((ref) => 0);

// Provider for the navigation bar visibility
final navBarVisibilityProvider = StateProvider<bool>((ref) => true);

// Provider for food items (mock data)
final foodItemsProvider = Provider<List<FoodItem>>((ref) {
  return [
    FoodItem(
      id: '1',
      title: 'Ghee Roast Idly (4 Pcs)',
      description: 'Soft and fluffy idlies roasted in pure cow ghee, served with spicy red chutney and sambar.',
      price: '₹120',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=800',
      isFavorite: true,
      deliveryTime: '20-25 min',
      distance: '2.5 km',
    ),
    FoodItem(
      id: '2',
      title: 'Butter Masala Dosa',
      description: 'Crispy golden dosa filled with spiced potato masala and topped with fresh butter.',
      price: '₹140',
      rating: '4.9',
      imageUrl: 'https://images.unsplash.com/photo-1630383249896-424e482df921?w=800',
      deliveryTime: '15-20 min',
      distance: '1.8 km',
    ),
    FoodItem(
      id: '3',
      title: 'Medu Vada (2 Pcs)',
      description: 'Crispy deep-fried lentil donuts served with coconut chutney and piping hot sambar.',
      price: '₹90',
      rating: '4.7',
      imageUrl: 'https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=800',
      deliveryTime: '25-30 min',
      distance: '3.2 km',
    ),
  ];
});

// Cart Notifier to manage cart operations
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(FoodItem item) {
    final existingIndex = state.indexWhere((element) => element.foodItem.id == item.id);
    if (existingIndex != -1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(foodItem: item)];
    }
  }

  void removeItem(String foodId) {
    state = state.where((item) => item.foodItem.id != foodId).toList();
  }

  void updateQuantity(String foodId, int quantity) {
    if (quantity <= 0) {
      removeItem(foodId);
    } else {
      state = [
        for (final item in state)
          if (item.foodItem.id == foodId)
            item.copyWith(quantity: quantity)
          else
            item
      ];
    }
  }

  void clear() {
    state = [];
  }

  double get totalAmount {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }
}

// Provider for the cart
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Total cart items count
final cartCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

// Total cart amount
final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.totalPrice);
});
