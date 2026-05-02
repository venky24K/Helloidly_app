import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/order_model.dart';
import '../../../models/cart_item.dart';
import '../../home/providers/home_providers.dart';

class OrderNotifier extends StateNotifier<List<OrderModel>> {
  OrderNotifier() : super([]);

  void placeOrder({
    required List<CartItem> items,
    required double totalAmount,
    required double deliveryFee,
    required double taxes,
    required String address,
  }) {
    final newOrder = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: items,
      totalAmount: totalAmount,
      deliveryFee: deliveryFee,
      taxes: taxes,
      address: address,
      status: OrderStatus.confirmed,
      timestamp: DateTime.now(),
      estimatedArrival: DateTime.now().add(const Duration(minutes: 30)),
    );

    state = [newOrder, ...state];
  }
}

final ordersProvider = StateNotifierProvider<OrderNotifier, List<OrderModel>>((ref) {
  return OrderNotifier();
});

// Provider for active orders
final activeOrdersProvider = Provider<List<OrderModel>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders.where((order) => order.status != OrderStatus.delivered).toList();
});

// A provider to handle the placement of an order and side effects
final placeOrderProvider = Provider((ref) {
  return (List<CartItem> items, double deliveryFee, double taxes, String address) {
    final totalAmount = ref.read(cartProvider.notifier).totalAmount;
    
    // Place the order
    ref.read(ordersProvider.notifier).placeOrder(
      items: items,
      totalAmount: totalAmount,
      deliveryFee: deliveryFee,
      taxes: taxes,
      address: address,
    );
    
    // Clear the cart
    ref.read(cartProvider.notifier).clear();
    
    // Additional side effects (like analytics, notifications) can go here
  };
});
