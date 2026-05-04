import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/user_model.dart';
import '../../home/providers/home_providers.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  final userId = Supabase.instance.client.auth.currentUser?.id;
  
  // For demonstration, if no user is logged in, we try to fetch profile '1'
  // In production, you would redirect to login or handle unauthenticated state.
  return await supabaseService.getUserProfile(userId ?? '1');
});
