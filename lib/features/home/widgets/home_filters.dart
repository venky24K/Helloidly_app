import 'package:flutter/material.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({super.key});

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  final List<Map<String, dynamic>> filters = const [
    {'label': 'Sort', 'icon': Icons.swap_vert_rounded, 'dropdown': true},
    {'label': 'Nearest', 'icon': Icons.near_me_rounded, 'dropdown': false},
    {
      'label': 'Great Offers',
      'icon': Icons.local_offer_rounded,
      'dropdown': false,
    },
    {'label': 'Rating 4.0+', 'icon': Icons.star_rounded, 'dropdown': false},
    {'label': 'Pure Veg', 'icon': Icons.eco_rounded, 'dropdown': false},
    {'label': 'Cuisines', 'icon': Icons.restaurant_rounded, 'dropdown': true},
  ];

  final Set<int> _selected = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
      child: Row(
        children: filters.asMap().entries.map((entry) {
          final index = entry.key;
          final filter = entry.value;
          final isSelected = _selected.contains(index);

          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: GestureDetector(
              onTap: () => setState(() {
                isSelected ? _selected.remove(index) : _selected.add(index);
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFF4912) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFFF4912)
                        : Colors.grey[300]!,
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFFFF4912,
                            ).withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      filter['icon'] as IconData,
                      size: 13,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFFFF4912),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      filter['label'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black87,
                        letterSpacing: 0.1,
                      ),
                    ),
                    if (filter['dropdown'] == true) ...[
                      const SizedBox(width: 2),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14,
                        color: isSelected ? Colors.white : Colors.black45,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
