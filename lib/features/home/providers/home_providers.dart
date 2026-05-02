import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/food_item.dart';
import '../../../models/cart_item.dart';
import '../../../services/supabase_service.dart';

// Provider for the supabase service
final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return SupabaseService();
});

// Provider for the selected navigation index
final navigationIndexProvider = StateProvider<int>((ref) => 0);

// Provider for the navigation bar visibility
final navBarVisibilityProvider = StateProvider<bool>((ref) => true);

// Provider for food items from Supabase
final foodItemsProvider = FutureProvider<List<FoodItem>>((ref) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return await supabaseService.getFoodItems();
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
