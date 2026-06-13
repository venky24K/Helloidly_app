import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../../home/providers/home_providers.dart';
import '../../auth/providers/auth_providers.dart';

final userProvider = FutureProvider<UserModel?>((ref) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  final userId = ref.watch(userIdProvider);
  
  if (userId == null) {
    return null;
  }
  
  try {
    return await supabaseService.getUserProfile(userId);
  } catch (e) {
    // If user profile doesn't exist yet, we could return a default or rethrow
    rethrow;
  }
});
