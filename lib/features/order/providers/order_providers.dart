import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/order_model.dart';
import '../../../models/cart_item.dart';
import '../../home/providers/home_providers.dart';
import '../../../services/supabase_service.dart';
import '../../auth/providers/auth_providers.dart';

class OrderNotifier extends StateNotifier<AsyncValue<List<OrderModel>>> {
  final SupabaseService _supabaseService;
  final String? _userId;

  OrderNotifier(this._supabaseService, this._userId) : super(const AsyncValue.loading()) {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    if (_userId == null) {
      state = const AsyncValue.data([]);
      return;
    }
    
    state = const AsyncValue.loading();
    try {
      final orders = await _supabaseService.getOrders(_userId);
      state = AsyncValue.data(orders);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> placeOrder({
    required List<CartItem> items,
    required double totalAmount,
    required double deliveryFee,
    required double taxes,
    required String address,
  }) async {
    final newOrder = OrderModel(
      id: '', // Will be ignored by toJson(forInsert: true)
      items: items,
      totalAmount: totalAmount,
      deliveryFee: deliveryFee,
      taxes: taxes,
      address: address,
      status: OrderStatus.confirmed,
      timestamp: DateTime.now(),
      estimatedArrival: DateTime.now().add(const Duration(minutes: 30)),
    );

    try {
      if (_userId == null) {
        throw Exception('User must be logged in to place an order');
      }
      await _supabaseService.createOrder(newOrder, _userId);
      await fetchOrders(); // Refresh orders list
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}


final ordersProvider = StateNotifierProvider<OrderNotifier, AsyncValue<List<OrderModel>>>((ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  final userId = ref.watch(userIdProvider);
  return OrderNotifier(supabaseService, userId);
});

// Provider for active orders
final activeOrdersProvider = Provider<List<OrderModel>>((ref) {
  final ordersAsync = ref.watch(ordersProvider);
  return ordersAsync.when(
    data: (orders) => orders.where((order) => order.status != OrderStatus.delivered).toList(),
    loading: () => [],
    error: (_, _) => [],
  );
});

// A provider to handle the placement of an order and side effects
final placeOrderProvider = Provider((ref) {
  return (List<CartItem> items, double deliveryFee, double taxes, String address) async {
    final totalAmount = ref.read(cartProvider.notifier).totalAmount;
    
    // Place the order
    await ref.read(ordersProvider.notifier).placeOrder(
      items: items,
      totalAmount: totalAmount,
      deliveryFee: deliveryFee,
      taxes: taxes,
      address: address,
    );
    
    // Clear the cart
    ref.read(cartProvider.notifier).clear();
  };
});
