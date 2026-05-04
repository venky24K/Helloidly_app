import 'food_item.dart';

class CartItem {
  final FoodItem foodItem;
  final int quantity;

  CartItem({
    required this.foodItem,
    this.quantity = 1,
  });

  CartItem copyWith({
    FoodItem? foodItem,
    int? quantity,
  }) {
    return CartItem(
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      foodItem: FoodItem.fromJson(json['food_item']),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_item': foodItem.toJson(),
      'quantity': quantity,
    };
  }

  double get totalPrice {
    return (foodItem.price * quantity).toDouble();
  }
}
