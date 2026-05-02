import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../../home/providers/home_providers.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  // Using a mock ID for demonstration. In a real app, this would come from auth.
  return await supabaseService.getUserProfile('1');
});
