import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF4912);
  static const Color secondary = Color(0xFFFFEBE5);
  static const Color textMain = Colors.black87;
  static const Color textSecondary = Colors.grey;
  static const Color background = Colors.white;
  
  // Gradient for headers
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFFF6B3D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
