import 'package:flutter/material.dart';

class ProfileIcons extends StatelessWidget {
  const ProfileIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white24,
      child: Icon(Icons.person_outline, color: Colors.white, size: 24),
    );
  }
}
