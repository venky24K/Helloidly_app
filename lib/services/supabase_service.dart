import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/food_item.dart';
import '../models/user_model.dart';
import '../models/order_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // Food Items
  Future<List<FoodItem>> getFoodItems() async {
    final response = await _client
        .from('food_items')
        .select()
        .order('title', ascending: true);
    
    return (response as List).map((json) => FoodItem.fromJson(json)).toList();
  }

  // User Profile
  Future<UserModel> getUserProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    
    return UserModel.fromJson(response);
  }

  Future<void> updateUserProfile(UserModel user) async {
    await _client
        .from('profiles')
        .update(user.toJson())
        .eq('id', user.id);
  }

  // Orders
  Future<List<OrderModel>> getOrders(String userId) async {
    final response = await _client
        .from('orders')
        .select()
        .eq('user_id', userId)
        .order('timestamp', ascending: false);
    
    return (response as List).map((json) => OrderModel.fromJson(json)).toList();
  }

  Future<void> createOrder(OrderModel order, String userId) async {
    final orderData = order.toJson(forInsert: true);
    orderData['user_id'] = userId;
    await _client.from('orders').insert(orderData);
  }
}
