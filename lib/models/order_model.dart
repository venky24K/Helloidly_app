import 'cart_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  outForDelivery,
  delivered,
}

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final double deliveryFee;
  final double taxes;
  final String address;
  final OrderStatus status;
  final DateTime timestamp;
  final DateTime? estimatedArrival;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.deliveryFee,
    required this.taxes,
    required this.address,
    required this.status,
    required this.timestamp,
    this.estimatedArrival,
  });

  double get grandTotal => totalAmount + deliveryFee + taxes;

  OrderModel copyWith({
    String? id,
    List<CartItem>? items,
    double? totalAmount,
    double? deliveryFee,
    double? taxes,
    String? address,
    OrderStatus? status,
    DateTime? timestamp,
    DateTime? estimatedArrival,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      taxes: taxes ?? this.taxes,
      address: address ?? this.address,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      estimatedArrival: estimatedArrival ?? this.estimatedArrival,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      items: (json['items'] as List?)?.map((i) => CartItem.fromJson(i)).toList() ?? [],
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0.0,
      taxes: (json['taxes'] as num?)?.toDouble() ?? 0.0,
      address: json['address'] ?? '',
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      estimatedArrival: json['estimated_arrival'] != null ? DateTime.parse(json['estimated_arrival']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((i) => i.toJson()).toList(),
      'total_amount': totalAmount,
      'delivery_fee': deliveryFee,
      'taxes': taxes,
      'address': address,
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
      'estimated_arrival': estimatedArrival?.toIso8601String(),
    };
  }
}
