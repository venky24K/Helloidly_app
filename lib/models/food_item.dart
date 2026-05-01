class FoodItem {
  final String id;
  final String title;
  final String description;
  final String price;
  final String rating;
  final String imageUrl;
  final bool isFavorite;
  final String? deliveryTime;
  final String? distance;

  FoodItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
    this.deliveryTime,
    this.distance,
  });

  FoodItem copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    String? rating,
    String? imageUrl,
    bool? isFavorite,
    String? deliveryTime,
    String? distance,
  }) {
    return FoodItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      distance: distance ?? this.distance,
    );
  }
}
