import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_providers.dart';
import '../../profile/providers/profile_providers.dart';

class ProfileIcons extends ConsumerWidget {
  const ProfileIcons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    
    return GestureDetector(
      onTap: () {
        ref.read(navigationIndexProvider.notifier).state = 4;
      },
      child: userAsync.when(
        data: (user) => CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white24,
          backgroundImage: NetworkImage(user.profileImageUrl),
        ),
        loading: () => const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (_, _) => const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white24,
          child: Icon(Icons.person_outline, color: Colors.white),
        ),
      ),
    );
  }
}
