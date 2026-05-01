import 'package:flutter/material.dart';

class TiffinCategories extends StatelessWidget {
  const TiffinCategories({super.key});

  final List<Map<String, String>> categories = const [
    {'name': 'Idly', 'icon': 'assets/icons/idly.png'},
    {'name': 'Dosa', 'icon': 'assets/icons/dosa.png'},
    {'name': 'Vada', 'icon': 'assets/icons/vada.png'},
    {'name': 'Poori', 'icon': 'assets/icons/poori.png'},
    {'name': 'Pongal', 'icon': 'assets/icons/pongal.png'},
    {'name': 'Parotta', 'icon': 'assets/icons/parotta.png'},
    {'name': 'Coffee', 'icon': 'assets/icons/coffee.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4912),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "What's on your mind?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                name: categories[index]['name']!,
                icon: categories[index]['icon']!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String icon;

  const CategoryItem({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF4912).withValues(alpha: 0.08),
                  const Color(0xFFFF4912).withValues(alpha: 0.14),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFF4912).withValues(alpha: 0.18),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF4912).withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                _getIconData(name),
                size: 26,
                color: const Color(0xFFFF4912),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'Idly':
        return Icons.circle_outlined;
      case 'Dosa':
        return Icons.change_history_outlined;
      case 'Vada':
        return Icons.panorama_fish_eye;
      case 'Poori':
        return Icons.circle;
      case 'Pongal':
        return Icons.rice_bowl_outlined;
      case 'Parotta':
        return Icons.layers_outlined;
      case 'Coffee':
        return Icons.coffee_outlined;
      default:
        return Icons.fastfood_outlined;
    }
  }
}
