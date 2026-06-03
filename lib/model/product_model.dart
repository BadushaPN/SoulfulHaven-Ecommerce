class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final double rating;
  final String discountPercentage;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    this.rating = 4.8,
    this.discountPercentage = '30%',
  });
}
